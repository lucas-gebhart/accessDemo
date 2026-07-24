import Link from "next/link";

import { BarList, Card, KpiBadge, Progress, Stat, Table } from "@/components/ui";
import {
  capacityTotals,
  listIssues,
  listProjects,
  listTasks,
  nodeTotals,
  nodesByDimension,
} from "@/lib/queries";

export const dynamic = "force-dynamic";

export default async function DashboardPage() {
  const [totals, capacity, byEnvironment, byRole, byProject, byType, projects, openTasks, risks] =
    await Promise.all([
      nodeTotals(),
      capacityTotals(),
      nodesByDimension("environment"),
      nodesByDimension("role"),
      nodesByDimension("project"),
      nodesByDimension("type"),
      listProjects(),
      listTasks({ openOnly: true }),
      listIssues({ openOnly: true }),
    ]);

  const blockedTasks = openTasks.filter((task) => task.is_blocked);

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-semibold">Infrastructure Dashboard</h1>
        <p className="text-sm text-slate-500">
          Ports of the <code>Nodes_Summary_*</code>, <code>Tasks_*</code> and{" "}
          <code>Issues_*</code> saved queries from the Access front end.
        </p>
      </div>

      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        <Stat label="Nodes" value={totals?.total ?? 0} hint="excluding soft-deleted" href="/nodes" />
        <Stat
          label="Active nodes"
          value={totals?.active ?? 0}
          hint={`${totals?.inactive ?? 0} inactive`}
          href="/nodes?active=1"
        />
        <Stat label="Open tasks" value={openTasks.length} hint={`${blockedTasks.length} blocked`} href="/tasks" />
        <Stat label="Open issues & risks" value={risks.length} href="/issues" />
      </div>

      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        <Stat
          label="Assigned cores"
          value={capacity?.assigned_cores ?? 0}
          hint={`of ${capacity?.max_cores ?? 0} installed`}
        />
        <Stat
          label="Assigned memory"
          value={`${(capacity?.assigned_memory ?? 0).toFixed(0)} GB`}
          hint={`of ${(capacity?.max_memory ?? 0).toFixed(0)} GB installed`}
        />
        <Stat label="Free chassis slots" value={capacity?.free_slots ?? 0} />
        <Stat label="Projects & services" value={projects.length} href="/projects" />
      </div>

      <div className="grid gap-4 lg:grid-cols-2">
        <Card title="Nodes by environment">
          <BarList rows={byEnvironment} />
        </Card>
        <Card title="Nodes by role">
          <BarList rows={byRole} />
        </Card>
        <Card title="Nodes by project">
          <BarList rows={byProject} />
        </Card>
        <Card title="Nodes by type">
          <BarList rows={byType} />
        </Card>
      </div>

      <Card
        title="Portfolio status"
        action={
          <Link className="text-sm text-sky-600 hover:underline" href="/projects">
            All projects
          </Link>
        }
      >
        <Table head={["Project", "Owner", "Status", "Progress", "Global KPI", "Nodes", "Open tasks"]}>
          {projects.map((project) => (
            <tr key={project.project_id}>
              <td className="px-3 py-2">
                <Link className="hover:underline" href={`/projects/${project.project_id}`}>
                  {project.project_name}
                </Link>
              </td>
              <td className="px-3 py-2">{project.service_manager}</td>
              <td className="px-3 py-2">{project.project_status}</td>
              <td className="px-3 py-2">
                <Progress value={project.current_progress} />
              </td>
              <td className="px-3 py-2">
                <KpiBadge status={project.global_status_kpi} />
              </td>
              <td className="px-3 py-2 tabular-nums">{project.node_count}</td>
              <td className="px-3 py-2 tabular-nums">{project.open_task_count}</td>
            </tr>
          ))}
        </Table>
      </Card>
    </div>
  );
}
