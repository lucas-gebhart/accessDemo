import Link from "next/link";

import { Badge, Card, Table } from "@/components/ui";
import { getLookups, listNodes } from "@/lib/queries";

export const dynamic = "force-dynamic";

const FILTERS = [
  { param: "environment", lookup: "environments", label: "Environment" },
  { param: "project", lookup: "projects", label: "Project" },
  { param: "role", lookup: "roles", label: "Role" },
  { param: "status", lookup: "node_status", label: "Status" },
  { param: "type", lookup: "node_types", label: "Type" },
] as const;

function toNumber(value: string | undefined) {
  if (!value) return undefined;
  const parsed = Number(value);
  return Number.isNaN(parsed) ? undefined : parsed;
}

export default async function NodesPage({
  searchParams,
}: {
  searchParams: Promise<Record<string, string | string[] | undefined>>;
}) {
  const params = await searchParams;
  const get = (key: string) => (Array.isArray(params[key]) ? params[key][0] : params[key]);

  const filters = {
    search: get("q") ?? undefined,
    environmentId: toNumber(get("environment")),
    projectId: toNumber(get("project")),
    roleId: toNumber(get("role")),
    statusId: toNumber(get("status")),
    nodeTypeId: toNumber(get("type")),
    activeOnly: get("active") === "1",
  };

  const [nodes, lookups] = await Promise.all([
    listNodes(filters),
    getLookups(FILTERS.map((filter) => filter.lookup)),
  ]);

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-semibold">Infrastructure Nodes</h1>
          <p className="text-sm text-slate-500">{nodes.length} node(s) matching the filter.</p>
        </div>
        <Link
          href="/nodes/new"
          className="rounded bg-sky-600 px-3 py-2 text-sm font-medium text-white hover:bg-sky-700"
        >
          New node
        </Link>
      </div>

      <Card>
        <form className="flex flex-wrap items-end gap-3" method="get">
          <label className="flex flex-col gap-1">
            <span className="text-xs font-medium text-slate-500 uppercase">Search</span>
            <input
              name="q"
              defaultValue={filters.search ?? ""}
              placeholder="name, serial, IP, model"
              className="w-56 rounded border border-slate-300 px-2 py-1 text-sm dark:border-slate-700 dark:bg-slate-800"
            />
          </label>
          {FILTERS.map((filter) => (
            <label key={filter.param} className="flex flex-col gap-1">
              <span className="text-xs font-medium text-slate-500 uppercase">{filter.label}</span>
              <select
                name={filter.param}
                defaultValue={get(filter.param) ?? ""}
                className="w-44 rounded border border-slate-300 px-2 py-1 text-sm dark:border-slate-700 dark:bg-slate-800"
              >
                <option value="">All</option>
                {lookups[filter.lookup].map((option) => (
                  <option key={option.id} value={option.id}>
                    {option.name}
                  </option>
                ))}
              </select>
            </label>
          ))}
          <label className="flex items-center gap-2 pb-1 text-sm">
            <input type="checkbox" name="active" value="1" defaultChecked={filters.activeOnly} />
            Active only
          </label>
          <button
            type="submit"
            className="rounded border border-slate-300 px-3 py-1.5 text-sm hover:bg-slate-100 dark:border-slate-700 dark:hover:bg-slate-800"
          >
            Apply
          </button>
          <Link href="/nodes" className="pb-1 text-sm text-slate-500 hover:underline">
            Reset
          </Link>
        </form>
      </Card>

      <Card>
        <Table
          head={[
            "Node",
            "Type",
            "System",
            "Environment",
            "Project",
            "Role",
            "Status",
            "Location",
            "Service IP",
            "Cores",
            "Memory",
            "Active",
          ]}
        >
          {nodes.map((node) => (
            <tr key={node.node_id}>
              <td className="px-3 py-2">
                <Link className="font-medium hover:underline" href={`/nodes/${node.node_id}`}>
                  {node.node_name}
                </Link>
                <div className="text-xs text-slate-500">{node.node_model}</div>
              </td>
              <td className="px-3 py-2">{node.node_type}</td>
              <td className="px-3 py-2">{node.system_type}</td>
              <td className="px-3 py-2">{node.environment}</td>
              <td className="px-3 py-2">{node.project}</td>
              <td className="px-3 py-2">{node.role}</td>
              <td className="px-3 py-2">{node.node_status}</td>
              <td className="px-3 py-2">{node.data_center}</td>
              <td className="px-3 py-2 font-mono text-xs">{node.service_ip}</td>
              <td className="px-3 py-2 tabular-nums">{node.assigned_system_cores}</td>
              <td className="px-3 py-2 tabular-nums">{node.assigned_system_memory} GB</td>
              <td className="px-3 py-2">
                <Badge tone={node.node_is_active ? "green" : "slate"}>
                  {node.node_is_active ? "Active" : "Inactive"}
                </Badge>
              </td>
            </tr>
          ))}
        </Table>
        {nodes.length === 0 && <p className="p-3 text-sm text-slate-500">No nodes found.</p>}
      </Card>
    </div>
  );
}
