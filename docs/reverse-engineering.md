# Reverse-engineering OpenSLIM

Notes taken while recovering the application from its published binaries. Everything below is
reproducible with `tools/extract.sh`.

## 1. The artifacts

The upstream repository [`cveira/openslim`](https://github.com/cveira/openslim) publishes:

```
OpenSLIM/openslim-v373b0.mdb                 8.9 MB   Access 2003 front end (JET4)
OpenSLIM/OpenSLIM-v373b0-20100509-0.bak     18.0 MB   SQL Server 2005 database backup
OpenSLIM/install.txt                                  restore the .bak, create the ODBC DSN, launch
```

## 2. The .mdb hides its tables

`mdb-tables` reports only `MSys*` tables, which initially looks like an empty database. Dumping the
object catalogue explains why:

```bash
mdb-export openslim.mdb MSysObjects
```

Every application table is `Type = 4` (linked) with

```
Connect     = DSN=OpenSLIM-current;Description=OpenSLIM-current;APP=Microsoft Office 2003;…
ForeignName = dbo.TblNodes
```

so the `.mdb` holds no data at all — it is a front end over SQL Server. The catalogue also reveals
the shape of the application:

| Type | Count | Meaning |
| --- | --- | --- |
| `4` | 72 | ODBC-linked tables |
| `5` | 586 | Saved queries |
| `-32768` | 60 | Forms |
| `-32764` | 4 | Reports |
| `-32761` | 2 | VBA modules (`GlobalFunctions`, `GlobalQueryFunctions`) |

Full listing: [`access_objects.md`](access_objects.md).

## 3. The saved queries are the business logic

```bash
mdb-queries -1 openslim.mdb              # names
mdb-queries openslim.mdb <name>          # reconstructed SQL
```

Dumped to [`access_queries.sql`](access_queries.sql). mdbtools reconstructs the SELECT/FROM/WHERE
of the stored query definition; join and GROUP BY clauses are only partially recovered, so the
queries were used as a specification of *intent* and re-expressed as PostgreSQL in
`src/lib/queries.ts`. Representative examples:

```sql
-- Nodes_Summary_TotalNodes
SELECT COUNT(TblNodes.NodeId) FROM [TblNodes] WHERE TblNodes.NodeIsDeleted=False

-- Nodes_Summary_NodesByEnvironment
SELECT TblEnvironments.EnvironmentName, Count(TblNodes.NodeId)
FROM [TblEnvironments],[TblNodes] WHERE TblNodes.NodeIsDeleted=False
ORDER BY Count(TblNodes.NodeId)
```

The naming convention of the 586 queries is itself a map of the application:
`Nodes_Summary_*`, `Nodes_Storage_SAN_*`, `Nodes_Repairs_{Pending,Repaired}_*`,
`Nodes_Decommissioning_{Pending,Completed}_*`, `Project_{Tasks,ClosedTasks}_*`,
`Issues_ProgressByPeriod_*`, and the `_`-prefixed queries that back individual forms.

## 4. The back end

Restoring the `.bak` into SQL Server 2022 in Docker gives the authoritative schema:

- 72 tables: 41 lookup/reference tables, 15 entity tables, 16 `Rel*` junction tables, plus a
  parallel `*History` table for every mutable entity (the application's audit design).
- 133 foreign keys, defaults on nearly every column, `IDENTITY` primary keys.
- No views; the only stored procedures are the SQL Server diagram helpers — confirming that all
  logic lives in the Access front end.
- Reference data is fully populated (26 system types from Windows NT 4.0 to VMware ESXi, 41 CPU
  types, 12 node statuses, …); operational tables contain only the placeholder rows
  (`Unknown`, `N/A`, `Unassigned`, `Unavailable`) the front end depends on for its defaults.

## 5. Conversion decisions

| SQL Server | PostgreSQL | Note |
| --- | --- | --- |
| `bit` | `boolean` | defaults `((0))`/`((1))` become `false`/`true` |
| `money` | `numeric(19,4)` | |
| `nvarchar(200)` | `varchar(100)` | `max_length` is in bytes for `n*` types |
| `text` / `ntext` | `text` | |
| `int IDENTITY` | `serial` | sequences re-synced with `setval` after loading |
| `getdate()` | `now()` | |
| `TblNodes` | `nodes` | `Tbl` prefix dropped |
| `RelNodes2Roles` | `rel_nodes_roles` | `2` → `_` |
| `NodeIsDeleted` | `node_is_deleted` | PascalCase → snake_case |

Foreign keys are created `deferrable initially deferred` and the seed runs inside one transaction:
the original data has circular references (for example every entity points at an `Unassigned`
placeholder row that itself points back), so no insertion order satisfies immediate constraints.

## 6. Rules extracted from the front end

| Rule | Evidence |
| --- | --- |
| Nodes are never hard-deleted | `TblNodes.NodeIsDeleted` and the `WHERE NodeIsDeleted=False` filter present in every summary query |
| Issues and risks are one table | `TblIssues.IsARisk`, and the split `Issues_ProgressByPeriod_LiveIssues` vs `…_Risks` |
| A task closes when it reaches 100% | `TblTasks.EndDate` is null for open tasks; `Tasks_OpenedButPending` selects on it |
| Status colour coding | `TblKpiStatus` rows 5–8 are literally Green/Yellow/Orange/Red, referenced by seven `*StatusKPI` columns on projects, tasks, issues, repairs and decommissioning |
| Operational readiness checklist | 17 `*IsOperational` / `*AreOperational` boolean columns on `TblNodes` |
