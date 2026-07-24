#!/usr/bin/env bash
# Reproduces the reverse-engineering pipeline that produced db/001_schema.sql and
# db/002_reference_data.sql from the published OpenSLIM Access application.
#
# Requires: docker, curl, mdbtools, python3 (pymssql).
set -euo pipefail

WORKDIR="${WORKDIR:-$(cd "$(dirname "$0")/.." && pwd)/.extract}"
RAW="https://raw.githubusercontent.com/cveira/openslim/master/OpenSLIM"
SA_PASSWORD="${SA_PASSWORD:-Str0ng!Passw0rd}"

mkdir -p "$WORKDIR/out"
cd "$WORKDIR"

# 1. The published artifacts: the Access front end and the SQL Server backup it links to.
[ -f openslim.mdb ] || curl -sL "$RAW/openslim-v373b0.mdb" -o openslim.mdb
[ -f openslim.bak ] || curl -sL "$RAW/OpenSLIM-v373b0-20100509-0.bak" -o openslim.bak

# 2. Front-end objects: 72 ODBC-linked tables, 586 saved queries, 60 forms, 4 reports, 2 modules.
mdb-export openslim.mdb MSysObjects > msys_objects.csv
mdb-queries -1 openslim.mdb > query_names.txt
: > access_queries.sql
while read -r name; do
  printf -- '-- %s\n' "$name" >> access_queries.sql
  mdb-queries openslim.mdb "$name" >> access_queries.sql 2>/dev/null || true
  printf '\n' >> access_queries.sql
done < query_names.txt

# 3. Restore the back end so the real schema and reference data can be read.
if ! docker ps --format '{{.Names}}' | grep -qx mssql; then
  docker run -d --name mssql -e ACCEPT_EULA=Y -e "MSSQL_SA_PASSWORD=$SA_PASSWORD" \
    -p 1433:1433 mcr.microsoft.com/mssql/server:2022-latest
  sleep 25
fi
docker cp openslim.bak mssql:/var/opt/mssql/openslim.bak
sql() { docker exec mssql /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C "$@"; }
sql -Q "RESTORE DATABASE OpenSLIM FROM DISK='/var/opt/mssql/openslim.bak' WITH REPLACE,
        MOVE 'OpenSLIM' TO '/var/opt/mssql/data/OpenSLIM.mdf',
        MOVE 'OpenSLIM_log' TO '/var/opt/mssql/data/OpenSLIM_log.ldf'"

meta() { docker exec mssql /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C \
  -d OpenSLIM -h-1 -W -s'|' -Q "SET NOCOUNT ON; $1"; }

meta "SELECT t.name+'|'+c.name+'|'+ty.name+'|'+CAST(c.max_length AS varchar)+'|'
        +CAST(c.is_nullable AS varchar)+'|'+CAST(c.is_identity AS varchar)+'|'+ISNULL(dc.definition,'')
      FROM sys.tables t
      JOIN sys.columns c ON c.object_id=t.object_id
      JOIN sys.types ty ON ty.user_type_id=c.user_type_id
      LEFT JOIN sys.default_constraints dc ON dc.object_id=c.default_object_id
      ORDER BY t.name, c.column_id" > schema_cols.txt

meta "SELECT OBJECT_NAME(fk.parent_object_id)+'|'+pc.name+'|'+OBJECT_NAME(fk.referenced_object_id)+'|'+rc.name
      FROM sys.foreign_keys fk
      JOIN sys.foreign_key_columns fkc ON fkc.constraint_object_id=fk.object_id
      JOIN sys.columns pc ON pc.object_id=fkc.parent_object_id AND pc.column_id=fkc.parent_column_id
      JOIN sys.columns rc ON rc.object_id=fkc.referenced_object_id AND rc.column_id=fkc.referenced_column_id" > fks.txt

meta "SELECT t.name+'|'+c.name
      FROM sys.tables t
      JOIN sys.indexes i ON i.object_id=t.object_id AND i.is_primary_key=1
      JOIN sys.index_columns ic ON ic.object_id=i.object_id AND ic.index_id=i.index_id
      JOIN sys.columns c ON c.object_id=t.object_id AND c.column_id=ic.column_id" > pks.txt

# 4. Convert SQL Server DDL + data into PostgreSQL.
python3 "$(cd "$(dirname "$0")" && pwd)/convert.py"
echo "Wrote $WORKDIR/out/schema.sql and $WORKDIR/out/seed.sql"
