import Link from "next/link";
import { notFound } from "next/navigation";

import { Badge, Card, Field } from "@/components/ui";
import { softDeleteNode } from "@/lib/actions";
import { getNode, getNodeRelations } from "@/lib/queries";
import { OPERATIONAL_FLAGS } from "@/lib/types";

export const dynamic = "force-dynamic";

function label(flag: string) {
  return flag.replace(/_/g, " ").replace(/\bis\b|\bare\b/g, "").trim();
}

function date(value: Date | null) {
  return value ? new Date(value).toISOString().slice(0, 10) : "—";
}

export default async function NodeDetailPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const nodeId = Number(id);
  if (Number.isNaN(nodeId)) notFound();

  const node = await getNode(nodeId);
  if (!node) notFound();
  const relations = await getNodeRelations(nodeId);

  const deleteNode = async () => {
    "use server";
    await softDeleteNode(nodeId);
  };

  const operationalCount = OPERATIONAL_FLAGS.filter((flag) => node[flag]).length;

  return (
    <div className="space-y-4">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h1 className="text-2xl font-semibold">{node.node_name}</h1>
          <p className="text-sm text-slate-500">
            {node.node_description || node.node_model} · {node.node_type} · {node.system_type}
          </p>
        </div>
        <div className="flex items-center gap-3">
          <Badge tone={node.node_is_active ? "green" : "slate"}>
            {node.node_is_active ? "Active" : "Inactive"}
          </Badge>
          <Link
            href={`/nodes/${nodeId}/edit`}
            className="rounded bg-sky-600 px-3 py-2 text-sm font-medium text-white hover:bg-sky-700"
          >
            Edit
          </Link>
          <form action={deleteNode}>
            <button
              type="submit"
              className="rounded border border-red-300 px-3 py-2 text-sm text-red-700 hover:bg-red-50"
            >
              Decommission (soft delete)
            </button>
          </form>
        </div>
      </div>

      <div className="grid gap-4 lg:grid-cols-2">
        <Card title="Assignment">
          <div className="grid grid-cols-2 gap-3">
            <Field label="Project">{node.project}</Field>
            <Field label="Environment">{node.environment}</Field>
            <Field label="Role">{node.role}</Field>
            <Field label="Production scope">{node.production_scope}</Field>
            <Field label="Service manager">{node.service_manager}</Field>
            <Field label="Node status">{node.node_status}</Field>
            <Field label="Delivery status">{node.delivery_status}</Field>
            <Field label="Parent node">{node.parent_node ?? "—"}</Field>
          </div>
        </Card>

        <Card title="Location & supply">
          <div className="grid grid-cols-2 gap-3">
            <Field label="Data center">{node.data_center}</Field>
            <Field label="Virtual data center">{node.virtual_data_center}</Field>
            <Field label="Rack">{node.rack_location}</Field>
            <Field label="Supplier">{node.supplier}</Field>
            <Field label="Serial number">{node.node_serial_number}</Field>
            <Field label="Model">{node.node_model}</Field>
            <Field label="Delivered">{date(node.node_delivery_date)}</Field>
            <Field label="Licenses">{node.assigned_licenses ?? "—"}</Field>
          </div>
        </Card>

        <Card title="Technical profile">
          <div className="grid grid-cols-2 gap-3">
            <Field label="Architecture">{node.architecture_type}</Field>
            <Field label="CPU">{node.cpu_type}</Field>
            <Field label="Cluster">{node.cluster_type}</Field>
            <Field label="Patch level">{node.major_patch_level}</Field>
            <Field label="Cores">
              {node.assigned_system_cores} / {node.max_system_cores}
            </Field>
            <Field label="Memory (GB)">
              {node.assigned_system_memory} / {node.max_system_memory}
            </Field>
            <Field label="HBA ports">
              {node.assigned_hba_ports} / {node.max_hba_ports}
            </Field>
            <Field label="NIC ports">
              {node.assigned_nic_ports} / {node.max_nic_ports}
            </Field>
            <Field label="Slots">
              {node.assigned_slots} / {node.max_slots}
            </Field>
            <Field label="Storage">
              {[
                node.has_internal_storage && "Internal",
                node.has_nas_storage && "NAS",
                node.has_san_storage && "SAN",
                node.has_das_storage && "DAS",
                node.has_cas_storage && "CAS",
              ]
                .filter(Boolean)
                .join(", ") || "—"}
            </Field>
          </div>
        </Card>

        <Card title="Networking">
          <div className="grid grid-cols-2 gap-3 font-mono text-sm">
            <Field label="Service IP">{node.service_ip}</Field>
            <Field label="Admin IP">{node.admin_ip}</Field>
            <Field label="Hardware admin IP">{node.hardware_admin_ip}</Field>
            <Field label="Storage IP">{node.storage_ip}</Field>
            <Field label="Heartbeat IP">{node.heart_beat_ip}</Field>
            <Field label="DNS zone">{node.main_dns_zone}</Field>
          </div>
        </Card>

        <Card title={`Operational readiness (${operationalCount}/${OPERATIONAL_FLAGS.length})`}>
          <ul className="grid grid-cols-2 gap-1 text-sm">
            {OPERATIONAL_FLAGS.map((flag) => (
              <li key={flag} className="flex items-center gap-2">
                <span
                  className={`inline-block h-2 w-2 rounded-full ${
                    node[flag] ? "bg-emerald-500" : "bg-slate-300"
                  }`}
                />
                <span className="capitalize">{label(flag)}</span>
              </li>
            ))}
          </ul>
        </Card>

        <Card title="Security & audit">
          <div className="grid grid-cols-2 gap-3">
            <Field label="Security domain">{node.security_domain}</Field>
            <Field label="Security class">{node.security_class}</Field>
            <Field label="Required level">{node.required_security_level}</Field>
            <Field label="Current level">{node.current_security_level}</Field>
            <Field label="Last security audit">{date(node.last_security_audit_date)}</Field>
            <Field label="Last system audit">{date(node.last_system_audit_date)}</Field>
            <Field label="Created">{date(node.inventory_creation_date)}</Field>
            <Field label="Updated">{date(node.inventory_last_update_date)}</Field>
          </div>
        </Card>

        <Card title="Additional roles & environments">
          <div className="grid grid-cols-2 gap-3">
            <Field label="Roles">
              {relations.roles.map((role) => role.name).join(", ") || "—"}
            </Field>
            <Field label="Environments">
              {relations.environments.map((environment) => environment.name).join(", ") || "—"}
            </Field>
          </div>
          {relations.related.length > 0 && (
            <ul className="mt-3 space-y-1 text-sm">
              {relations.related.map((related) => (
                <li key={related.id}>
                  <Link className="hover:underline" href={`/nodes/${related.id}`}>
                    {related.name}
                  </Link>
                  <span className="text-slate-500"> — {related.relationship || "related"}</span>
                </li>
              ))}
            </ul>
          )}
        </Card>

        <Card title="Notes">
          <p className="text-sm whitespace-pre-wrap">{node.notes || "—"}</p>
        </Card>
      </div>
    </div>
  );
}
