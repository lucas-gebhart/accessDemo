"""Convert the restored OpenSLIM SQL Server schema+data into PostgreSQL DDL/seed files."""
import datetime
import decimal
import os
import re

import pymssql
from collections import OrderedDict, defaultdict

HERE = os.environ.get(
    "WORKDIR", os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), ".extract")
)
SA_PASSWORD = os.environ.get("SA_PASSWORD", "Str0ng!Passw0rd")
SKIP_TABLES = {"sysdiagrams"}

TYPE_MAP = {
    "int": "integer",
    "bigint": "bigint",
    "smallint": "smallint",
    "tinyint": "smallint",
    "bit": "boolean",
    "real": "real",
    "float": "double precision",
    "money": "numeric(19,4)",
    "datetime": "timestamp",
    "smalldatetime": "timestamp",
    "date": "date",
    "text": "text",
    "ntext": "text",
    "uniqueidentifier": "uuid",
}


def snake(name: str) -> str:
    name = re.sub(r"([a-z0-9])([A-Z])", r"\1_\2", name)
    name = re.sub(r"([A-Z]+)([A-Z][a-z])", r"\1_\2", name)
    return name.lower()


def table_name(sql_name: str) -> str:
    if sql_name.startswith("Tbl"):
        return snake(sql_name[3:])
    if sql_name.startswith("Rel"):
        rest = sql_name[3:].replace("2", "_")
        return "rel_" + snake(rest)
    return snake(sql_name)


def load(path):
    with open(os.path.join(HERE, path)) as f:
        return [l.rstrip("\n").split("|") for l in f if l.strip()]


def pg_type(ty, max_len):
    if ty in ("nvarchar", "varchar", "nchar", "char"):
        n = int(max_len)
        if n == -1:
            return "text"
        if ty.startswith("n"):
            n //= 2
        return f"varchar({n})"
    return TYPE_MAP.get(ty, "text")


def pg_default(expr, pgty):
    e = expr.strip()
    while e.startswith("(") and e.endswith(")"):
        e = e[1:-1].strip()
    if e.lower() == "getdate()":
        return "now()"
    if pgty == "boolean":
        return "true" if e not in ("0",) else "false"
    return e


def main():
    cols = load("schema_cols.txt")
    pks = defaultdict(list)
    for t, c in load("pks.txt"):
        pks[t].append(c)
    fks = load("fks.txt")

    tables = OrderedDict()
    for t, c, ty, ml, nullable, ident, dflt in cols:
        if t in SKIP_TABLES:
            continue
        tables.setdefault(t, []).append(
            dict(name=c, type=ty, max_length=ml, nullable=nullable == "1",
                 identity=ident == "1", default=dflt)
        )

    ddl = ["-- Generated from the OpenSLIM Microsoft Access / SQL Server back end.",
           "-- Source: https://github.com/cveira/openslim (openslim-v373b0.mdb + OpenSLIM-v373b0-20100509-0.bak)", ""]
    for t, columns in tables.items():
        pt = table_name(t)
        lines = []
        for col in columns:
            pgty = pg_type(col["type"], col["max_length"])
            piece = f'  "{snake(col["name"])}" '
            piece += "serial" if col["identity"] else pgty
            if not col["nullable"]:
                piece += " not null"
            if col["default"] and not col["identity"]:
                piece += f' default {pg_default(col["default"], pgty)}'
            lines.append(piece)
        if pks.get(t):
            lines.append("  primary key (" + ", ".join(f'"{snake(c)}"' for c in pks[t]) + ")")
        ddl.append(f'create table "{pt}" (\n' + ",\n".join(lines) + "\n);\n")

    seen = set()
    for parent, pcol, ref, rcol in fks:
        if parent in SKIP_TABLES or ref in SKIP_TABLES:
            continue
        cname = f"fk_{table_name(parent)}_{snake(pcol)}"[:63]
        if cname in seen:
            continue
        seen.add(cname)
        ddl.append(
            f'alter table "{table_name(parent)}" add constraint "{cname}" '
            f'foreign key ("{snake(pcol)}") references "{table_name(ref)}" ("{snake(rcol)}") '
            f'deferrable initially deferred;'
        )

    with open(os.path.join(HERE, "out", "schema.sql"), "w") as f:
        f.write("\n".join(ddl) + "\n")

    # ---- data ----
    conn = pymssql.connect(server="127.0.0.1", user="sa", password=SA_PASSWORD,
                           database="OpenSLIM", port=1433)
    cur = conn.cursor()

    seed = ["-- Data extracted from the original OpenSLIM database backup.", "begin;", "set constraints all deferred;"]
    order = sorted(tables, key=lambda t: (t.startswith("Rel"), t))
    for t in order:
        columns = tables[t]
        collist = ", ".join(f'[{c["name"]}]' for c in columns)
        cur.execute(f"SELECT {collist} FROM [{t}]")
        rows = cur.fetchall()
        if not rows:
            continue
        pt = table_name(t)
        pgcols = ", ".join(f'"{snake(c["name"])}"' for c in columns)
        for row in rows:
            vals = []
            for c, v in zip(columns, row):
                pgty = pg_type(c["type"], c["max_length"])
                if v is None:
                    vals.append("null")
                elif pgty == "boolean":
                    vals.append("true" if v in (True, 1, "1") else "false")
                elif isinstance(v, bool):
                    vals.append("true" if v else "false")
                elif isinstance(v, (int, float, decimal.Decimal)):
                    vals.append(str(v))
                elif isinstance(v, (datetime.datetime, datetime.date)):
                    vals.append("'" + v.isoformat(sep=" ") + "'")
                elif isinstance(v, bytes):
                    vals.append("'" + v.decode("utf-8", "replace").replace("'", "''") + "'")
                else:
                    vals.append("'" + str(v).replace("'", "''") + "'")
            seed.append(f'insert into "{pt}" ({pgcols}) values ({", ".join(vals)});')
        idcol = next((c for c in columns if c["identity"]), None)
        if idcol:
            seq = f"{pt}_{snake(idcol['name'])}_seq"
            seed.append(
                f"select setval('\"{seq}\"', (select coalesce(max(\"{snake(idcol['name'])}\"), 1) from \"{pt}\"));")
    seed.append("commit;")
    with open(os.path.join(HERE, "out", "seed.sql"), "w") as f:
        f.write("\n".join(seed) + "\n")
    print("tables:", len(tables), "inserts:", sum(1 for l in seed if l.startswith("insert")))


if __name__ == "__main__":
    os.makedirs(os.path.join(HERE, "out"), exist_ok=True)
    main()
