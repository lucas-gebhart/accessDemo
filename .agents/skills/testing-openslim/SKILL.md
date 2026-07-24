---
name: testing-openslim
description: How to set up, run and end-to-end test the OpenSLIM Next.js + PostgreSQL rebuild (dashboard, nodes, tasks, issues, projects, reference data) with database-backed verification.
---

# Testing the OpenSLIM rebuild

Next.js 15 (App Router + Server Actions) + TypeScript + PostgreSQL (`pg`). No authentication — every page is directly reachable.

## Setup

```bash
docker start pg   # Postgres 16, localhost:5432, db openslim, postgres/postgres
export DATABASE_URL=postgres://postgres:postgres@localhost:5432/openslim
npm ci
npm run db:reset            # 000_reset + 001_schema + 002_reference_data + 003_demo_data
rm -rf .next && npm run build   # stale .next builds cause behaviour that doesn't match source
fuser -k 3000/tcp 2>/dev/null   # an old `next start` is often already listening
npx next start -p 3000 > /tmp/next.log 2>&1 &
```

Clean baseline after `db:reset`: 17 live nodes (all active), 6 open tasks, 4 open issues (2 risks), 8 projects.

## Verifying against the database

Always cross-check the UI with `psql "$DATABASE_URL" -c "..."`. Useful column names (they are *not* what you'd guess):

- Soft delete flag: `nodes.node_is_deleted` (live rows = `not node_is_deleted`); active flag `node_is_active`.
- Node filters map to `main_project_id`, `main_role_id`, `main_environment_id`, `node_status_id`, `node_type_id`.
- Operational readiness = count of 17 booleans named like `data_center_is_operational`, `networks_are_operational`, `firewall_rules_are_operational` (mixed `is_`/`are_` suffixes — run `\d nodes | grep operational` rather than guessing).
- Task closure: `tasks.current_progress`, `tasks.end_date`. Issue closure: `issues.resolution_date`, `issues.is_active`, `issues.is_a_risk`, `issues.is_deleted`.

## Route/query-param cheat sheet

- `/nodes?q=&environment=&project=&role=&status=&type=&active=1` — `active=1` is the active-only toggle.
- `/tasks?all=1` — include closed tasks. `/issues?risks=1`, `/issues?all=1`.
- `/nodes/999999`, `/nodes/abc`, `/projects/999999` should all render the Next.js 404 page.

## Browser-automation gotchas

- Typing into an input **appends** to the existing value instead of replacing it. To replace: click the field, press `Control+a`, then type. Plain `BackSpace` via `press_key` is unreliable on these fields.
- Number inputs have `min`/`max`, so out-of-range values are blocked client-side with native bubbles ("Value must be less than or equal to 100.", "Please enter a number.") before the server action runs. To exercise *server-side* zod, use a value the browser accepts, e.g. a 200-character text field.
- Server-side zod failures surface as a generic `Invalid input` banner at the top of the form, and the form resets to defaults — scroll to the top of the page to screenshot the banner.

## Things worth re-testing on any change

Soft delete must keep the row in Postgres (intentional Access behaviour, not a bug). Setting a task to 100% must stamp `end_date`; resolving an issue must stamp `resolution_date`. Dashboard KPI cards are live queries, so they should visibly drop after you close a task / resolve an issue in the UI — a good end-to-end consistency check.

## Devin Secrets Needed

None — everything is local (Postgres in Docker, no auth in the app).
