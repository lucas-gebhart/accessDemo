import Link from "next/link";
import { notFound } from "next/navigation";

import { Card, Field, KpiBadge, Progress, Table } from "@/components/ui";
import { getProject, listNodes, listTasks } from "@/lib/queries";

export const dynamic = "force-dynamic";

function money(value: string) {
  return Number(value).toLocaleString("en-US", { style: "currency", currency: "USD" });
}

function date(value: Date | null) {
  return value ? new Date(value).toISOString().slice(0, 10) : "—";
}

export default async function ProjectDetailPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const projectId = Number(id);
  if (Number.isNaN(projectId)) notFound();

  const project = await getProject(projectId);
  if (!project) notFound();

  const [nodes, tasks] = await Promise.all([
    listNodes({ projectId }),
    listTasks({ projectId }),
  ]);

  return (
    <div className="space-y-4">
      <div>
        <h1 className="text-2xl font-semibold">{project.project_name}</h1>
        <p className="text-sm text-slate-500">{project.description ?? project.project_cycle_label}</p>
      </div>

      <div className="grid gap-4 lg:grid-cols-2">
        <Card title="Scorecard">
          <div className="grid grid-cols-2 gap-3">
            <Field label="Status">{project.project_status}</Field>
            <Field label="Priority">{project.priority}</Field>
            <Field label="Business area">{project.business_area}</Field>
            <Field label="Service manager">{project.service_manager}</Field>
            <Field label="Progress">
              <Progress value={project.current_progress} />
            </Field>
            <Field label="Global KPI">
              <KpiBadge status={project.global_status_kpi} />
            </Field>
            <Field label="Risk KPI">
              <KpiBadge status={project.risk_status_kpi} />
            </Field>
            <Field label="Execution KPI">
              <KpiBadge status={project.execution_status_kpi} />
            </Field>
          </div>
        </Card>

        <Card title="Budget & dates">
          <div className="grid grid-cols-2 gap-3">
            <Field label="CAPEX scheduled">{money(project.scheduled_capex_budget)}</Field>
            <Field label="CAPEX consumed">{money(project.consumed_capex_budget)}</Field>
            <Field label="OPEX scheduled">{money(project.scheduled_opex_budget)}</Field>
            <Field label="OPEX consumed">{money(project.consumed_opex_budget)}</Field>
            <Field label="Scheduled delivery">{date(project.scheduled_delivery_date)}</Field>
            <Field label="Delivered">{date(project.delivery_date)}</Field>
          </div>
        </Card>
      </div>

      <Card title={`Nodes (${nodes.length})`}>
        <Table head={["Node", "Type", "Environment", "Role", "Status", "Service IP"]}>
          {nodes.map((node) => (
            <tr key={node.node_id}>
              <td className="px-3 py-2">
                <Link className="hover:underline" href={`/nodes/${node.node_id}`}>
                  {node.node_name}
                </Link>
              </td>
              <td className="px-3 py-2">{node.node_type}</td>
              <td className="px-3 py-2">{node.environment}</td>
              <td className="px-3 py-2">{node.role}</td>
              <td className="px-3 py-2">{node.node_status}</td>
              <td className="px-3 py-2 font-mono text-xs">{node.service_ip}</td>
            </tr>
          ))}
        </Table>
        {nodes.length === 0 && <p className="text-sm text-slate-500">No nodes assigned.</p>}
      </Card>

      <Card title={`Tasks (${tasks.length})`}>
        <Table head={["Task", "Work stream", "Owner", "Progress", "Scheduled end", "KPI"]}>
          {tasks.map((task) => (
            <tr key={task.task_id}>
              <td className="px-3 py-2">{task.task_name}</td>
              <td className="px-3 py-2">{task.work_stream}</td>
              <td className="px-3 py-2">{task.updater}</td>
              <td className="px-3 py-2">
                <Progress value={task.current_progress} />
              </td>
              <td className="px-3 py-2">{date(task.scheduled_end_date)}</td>
              <td className="px-3 py-2">
                <KpiBadge status={task.global_status_kpi} />
              </td>
            </tr>
          ))}
        </Table>
        {tasks.length === 0 && <p className="text-sm text-slate-500">No tasks recorded.</p>}
      </Card>
    </div>
  );
}
