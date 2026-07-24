import Link from "next/link";

import { Badge, Card, KpiBadge, Progress, Table } from "@/components/ui";
import { listProjects } from "@/lib/queries";

export const dynamic = "force-dynamic";

function money(value: string) {
  return Number(value).toLocaleString("en-US", { style: "currency", currency: "USD" });
}

export default async function ProjectsPage() {
  const projects = await listProjects();
  return (
    <div className="space-y-4">
      <div>
        <h1 className="text-2xl font-semibold">Portfolio</h1>
        <p className="text-sm text-slate-500">
          Port of the Access &ldquo;Portfolio Management&rdquo; form: projects and services with
          their KPI scorecard.
        </p>
      </div>
      <Card>
        <Table
          head={[
            "Project",
            "Business area",
            "Owner",
            "Priority",
            "Status",
            "Progress",
            "Global",
            "Risk",
            "Budget",
            "CAPEX used",
            "Nodes",
            "Open tasks",
          ]}
        >
          {projects.map((project) => (
            <tr key={project.project_id}>
              <td className="px-3 py-2">
                <Link className="font-medium hover:underline" href={`/projects/${project.project_id}`}>
                  {project.project_name}
                </Link>
                {project.is_service && (
                  <span className="ml-2">
                    <Badge>Service</Badge>
                  </span>
                )}
              </td>
              <td className="px-3 py-2">{project.business_area}</td>
              <td className="px-3 py-2">{project.service_manager}</td>
              <td className="px-3 py-2">{project.priority}</td>
              <td className="px-3 py-2">{project.project_status}</td>
              <td className="px-3 py-2">
                <Progress value={project.current_progress} />
              </td>
              <td className="px-3 py-2">
                <KpiBadge status={project.global_status_kpi} />
              </td>
              <td className="px-3 py-2">
                <KpiBadge status={project.risk_status_kpi} />
              </td>
              <td className="px-3 py-2">
                <KpiBadge status={project.budget_status_kpi} />
              </td>
              <td className="px-3 py-2 tabular-nums">
                {money(project.consumed_capex_budget)} / {money(project.scheduled_capex_budget)}
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
