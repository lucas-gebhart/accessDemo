# OpenSLIM Modern

A rebuild of a real, publicly available **Microsoft Access** low-code application in
TypeScript / Next.js / PostgreSQL — schema, reference data and business rules recovered from the
published binaries, not from documentation.

| | |
| --- | --- |
| Original application | [OpenSLIM](https://github.com/cveira/openslim) — "Open Simple & Lightweight Infrastructure Manager", an infrastructure/asset manager built in Access 2003 |
| Original artifacts | `openslim-v373b0.mdb` (Access front end) + `OpenSLIM-v373b0-20100509-0.bak` (SQL Server back end, ODBC-linked via the `OpenSLIM-current` DSN) |
| Original scale | 72 tables · 586 saved queries · 60 forms · 4 reports · 2 VBA modules |
| Rebuild | Next.js 15 (App Router, React Server Components, Server Actions) · TypeScript · PostgreSQL 16 · Tailwind CSS |

## Why this application

Access is the archetypal low-code tool: the schema, the queries, the forms and the VBA all live in
one opaque `.mdb`. OpenSLIM is a full production-shaped application (asset inventory, portfolio
and task management, issue/risk register, provisioning, repairs and decommissioning workflows) and
both of its files are published, so every layer can be recovered mechanically.

## What was recovered, and how

`tools/extract.sh` reproduces the whole pipeline; `docs/reverse-engineering.md` explains it.

1. **Front-end objects** — `mdb-export openslim.mdb MSysObjects` lists every object in the Access
   file. It showed the tables are not local: each one carries
   `Connect = DSN=OpenSLIM-current;… ForeignName = dbo.TblNodes`, i.e. the `.mdb` is a pure front
   end over SQL Server. The full inventory is in [`docs/access_objects.md`](docs/access_objects.md).
2. **Business logic** — `mdb-queries` recovers the SQL of all 586 saved queries into
   [`docs/access_queries.sql`](docs/access_queries.sql). These are the application's real logic:
   `Nodes_Summary_NodesByEnvironment`, `Tasks_OpenedButPending`, `_IssuesBasicList`, and so on.
3. **Back end** — the shipped `.bak` was restored into a `mcr.microsoft.com/mssql/server:2022`
   container, exposing the true DDL (72 tables, 133 foreign keys, defaults, identity columns) and
   the original reference data.
4. **Conversion** — `tools/convert.py` translates SQL Server DDL and rows into PostgreSQL:
   `bit → boolean`, `money → numeric(19,4)`, `nvarchar(n)` byte lengths halved, `IDENTITY → serial`,
   `getdate() → now()`, `TblNodes → nodes`, `RelNodes2Roles → rel_nodes_roles`, `NodeIsDeleted →
   node_is_deleted`. Foreign keys are emitted `deferrable initially deferred` because the original
   data contains circular references between placeholder rows.

Behavioural rules carried over from the Access front end:

- Nodes are **soft-deleted** (`NodeIsDeleted`); every summary query filters on it, so all node
  reads in `src/lib/queries.ts` go through the same predicate.
- Issues and risks share one table, separated by `IsARisk`.
- Progress of 100% closes a task by stamping `EndDate`.
- Status is expressed with the `TblKpiStatus` palette (Green/Yellow/Orange/Red), which the UI
  renders as KPI badges.

## Database layout

| File | Contents |
| --- | --- |
| `db/001_schema.sql` | Generated PostgreSQL DDL — all 72 tables and 133 FKs |
| `db/002_reference_data.sql` | Generated inserts — the original OpenSLIM reference data (node types, system types, CPU types, statuses, suppliers, …) |
| `db/003_demo_data.sql` | **Synthetic** demo estate (17 nodes, 4 projects, 8 tasks, 5 issues). The upstream backup only ships placeholder rows for operational tables, so this makes the UI explorable. Optional. |

## Running it

```bash
docker run -d --name pg -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=openslim -p 5432:5432 postgres:16
npm install
npm run db:reset          # loads 001 + 002 + 003
cp .env.example .env.local
npm run dev               # http://localhost:3000
```

`DATABASE_URL` defaults to `postgres://postgres:postgres@localhost:5432/openslim`.

## Screens

| Route | Rebuilt from |
| --- | --- |
| `/` | `MainMenu` switchboard + the `Nodes_Summary_*`, `Tasks_*` and `Issues_*` saved queries |
| `/nodes` | `Infrastructure Node Quick Management` / `_NodesBasicList` — search and filter by environment, project, role, status and type |
| `/nodes/[id]` | `Infrastructure Node Management` — identity, assignment, location, technical profile, networking, 17-point operational readiness, security and audit |
| `/nodes/[id]/edit`, `/nodes/new` | The editable tabs of the same form, validated with zod and written through Server Actions |
| `/projects`, `/projects/[id]` | `Portfolio Management` — KPI scorecard, CAPEX/OPEX, related nodes and tasks |
| `/tasks` | `Tasks Management` / `Tasks_OpenedButPending`, with inline progress updates |
| `/issues` | `Issues & Risks Management` / `_IssuesBasicList` |
| `/reference` | The `_EntityData_*` subforms — every lookup table behind the combo boxes |

## Scope

The rebuild covers the inventory, portfolio, task and issue/risk areas of the original. The
provisioning, repairs and decommissioning workflows are migrated at the **database** level (tables,
reference data and workflow status values are all present) but do not yet have screens; the
`*History` audit tables are migrated but not yet written to.
