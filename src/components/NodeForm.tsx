"use client";

import Link from "next/link";
import { useActionState } from "react";

import { Card } from "@/components/ui";
import type { ActionState } from "@/lib/actions";
import type { NodeInput } from "@/lib/nodeForm";
import type { Lookup } from "@/lib/types";

export type NodeFormLookups = Record<string, Lookup[]>;

type SelectField = { name: keyof NodeInput; label: string; lookup: string };

/** Grouped exactly like the tabs of the Access "Infrastructure Node Management" form. */
const IDENTITY: SelectField[] = [
  { name: "node_type_id", label: "Node type", lookup: "node_types" },
  { name: "system_type_id", label: "System type", lookup: "system_type" },
  { name: "major_patch_level_id", label: "Major patch level", lookup: "major_patch_levels" },
  { name: "supplier_id", label: "Supplier", lookup: "suppliers" },
  { name: "main_dns_zone_id", label: "Main DNS zone", lookup: "dns_zones" },
  { name: "security_domain_id", label: "Security domain", lookup: "security_domains" },
  { name: "parent_node_id", label: "Parent node", lookup: "nodes" },
];

const ASSIGNMENT: SelectField[] = [
  { name: "main_project_id", label: "Main project", lookup: "projects" },
  { name: "main_environment_id", label: "Main environment", lookup: "environments" },
  { name: "main_role_id", label: "Main role", lookup: "roles" },
  { name: "production_scope_id", label: "Production scope", lookup: "production_scopes" },
  { name: "service_manager_id", label: "Service manager", lookup: "updaters" },
  { name: "node_status_id", label: "Node status", lookup: "node_status" },
  { name: "delivery_status_id", label: "Delivery status", lookup: "delivery_status" },
];

const LOCATION: SelectField[] = [
  { name: "data_center_location_id", label: "Data center", lookup: "data_center_locations" },
  { name: "virtual_data_center_id", label: "Virtual data center", lookup: "virtual_data_centers" },
  { name: "rack_location_id", label: "Rack location", lookup: "rack_locations" },
];

const TECHNICAL: SelectField[] = [
  { name: "architecture_type_id", label: "Architecture", lookup: "architecture_types" },
  { name: "cpu_type_id", label: "CPU type", lookup: "cpu_types" },
  { name: "cluster_type_id", label: "Cluster type", lookup: "cluster_types" },
];

const SECURITY: SelectField[] = [
  { name: "security_class_id", label: "Security class", lookup: "security_class" },
  { name: "required_security_level_id", label: "Required level", lookup: "security_level" },
  { name: "current_security_level_id", label: "Current level", lookup: "security_level" },
];

const CAPACITY: { name: keyof NodeInput; label: string; step?: string }[] = [
  { name: "assigned_system_cores", label: "Assigned cores" },
  { name: "max_system_cores", label: "Max cores" },
  { name: "assigned_system_memory", label: "Assigned memory (GB)", step: "0.1" },
  { name: "max_system_memory", label: "Max memory (GB)", step: "0.1" },
  { name: "assigned_hba_ports", label: "Assigned HBA ports" },
  { name: "max_hba_ports", label: "Max HBA ports" },
  { name: "assigned_nic_ports", label: "Assigned NIC ports" },
  { name: "max_nic_ports", label: "Max NIC ports" },
  { name: "assigned_slots", label: "Assigned slots" },
  { name: "max_slots", label: "Max slots" },
];

const NETWORK: { name: keyof NodeInput; label: string }[] = [
  { name: "service_ip", label: "Service IP" },
  { name: "admin_ip", label: "Admin IP" },
  { name: "hardware_admin_ip", label: "Hardware admin IP" },
  { name: "storage_ip", label: "Storage IP" },
  { name: "heart_beat_ip", label: "Heartbeat IP" },
];

const STORAGE: { name: keyof NodeInput; label: string }[] = [
  { name: "has_internal_storage", label: "Internal" },
  { name: "has_nas_storage", label: "NAS" },
  { name: "has_san_storage", label: "SAN" },
  { name: "has_das_storage", label: "DAS" },
  { name: "has_cas_storage", label: "CAS" },
];

const inputClass =
  "rounded border border-slate-300 px-2 py-1 text-sm dark:border-slate-700 dark:bg-slate-800";

function Selects({
  fields,
  lookups,
  values,
}: {
  fields: SelectField[];
  lookups: NodeFormLookups;
  values: Partial<NodeInput>;
}) {
  return (
    <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
      {fields.map((field) => (
        <label key={field.name} className="flex flex-col gap-1">
          <span className="text-xs font-medium text-slate-500 uppercase">{field.label}</span>
          <select
            name={field.name}
            defaultValue={String(values[field.name] ?? lookups[field.lookup]?.[0]?.id ?? "")}
            className={inputClass}
          >
            {(lookups[field.lookup] ?? []).map((option) => (
              <option key={option.id} value={option.id}>
                {option.name}
              </option>
            ))}
          </select>
        </label>
      ))}
    </div>
  );
}

export function NodeForm({
  action,
  lookups,
  values: initialValues = {},
  submitLabel,
  cancelHref,
}: {
  action: (state: ActionState, formData: FormData) => Promise<ActionState>;
  lookups: NodeFormLookups;
  values?: Partial<NodeInput>;
  submitLabel: string;
  cancelHref: string;
}) {
  const [state, formAction, pending] = useActionState(action, {});
  // A rejected submission echoes back what the user typed; the key re-mounts the uncontrolled
  // inputs so their defaultValues are applied again instead of keeping the browser's state.
  const values = { ...initialValues, ...(state.values as Partial<NodeInput> | undefined) };

  return (
    <form action={formAction} className="space-y-4" key={state.error ?? "clean"}>
      {state.error && (
        <p className="rounded border border-red-300 bg-red-50 px-3 py-2 text-sm text-red-700">
          {state.error}
        </p>
      )}

      <Card title="Identity">
        <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
          <label className="flex flex-col gap-1">
            <span className="text-xs font-medium text-slate-500 uppercase">Node name *</span>
            <input name="node_name" required defaultValue={values.node_name ?? ""} className={inputClass} />
          </label>
          <label className="flex flex-col gap-1">
            <span className="text-xs font-medium text-slate-500 uppercase">Description</span>
            <input
              name="node_description"
              defaultValue={values.node_description ?? ""}
              className={inputClass}
            />
          </label>
          <label className="flex flex-col gap-1">
            <span className="text-xs font-medium text-slate-500 uppercase">Serial number</span>
            <input
              name="node_serial_number"
              defaultValue={values.node_serial_number ?? "Unknown"}
              className={inputClass}
            />
          </label>
          <label className="flex flex-col gap-1">
            <span className="text-xs font-medium text-slate-500 uppercase">Model</span>
            <input name="node_model" defaultValue={values.node_model ?? "Unknown"} className={inputClass} />
          </label>
          <label className="flex items-center gap-2 pt-5 text-sm">
            <input
              type="checkbox"
              name="node_is_active"
              defaultChecked={values.node_is_active ?? true}
            />
            Active
          </label>
        </div>
        <div className="mt-3">
          <Selects fields={IDENTITY} lookups={lookups} values={values} />
        </div>
      </Card>

      <Card title="Assignment">
        <Selects fields={ASSIGNMENT} lookups={lookups} values={values} />
      </Card>

      <Card title="Location">
        <Selects fields={LOCATION} lookups={lookups} values={values} />
      </Card>

      <Card title="Technical profile">
        <Selects fields={TECHNICAL} lookups={lookups} values={values} />
        <div className="mt-3 grid gap-3 sm:grid-cols-3 lg:grid-cols-5">
          {CAPACITY.map((field) => (
            <label key={field.name} className="flex flex-col gap-1">
              <span className="text-xs font-medium text-slate-500 uppercase">{field.label}</span>
              <input
                type="number"
                min="0"
                step={field.step ?? "1"}
                name={field.name}
                defaultValue={String(values[field.name] ?? 0)}
                className={inputClass}
              />
            </label>
          ))}
        </div>
        <fieldset className="mt-3">
          <legend className="text-xs font-medium text-slate-500 uppercase">Storage</legend>
          <div className="mt-1 flex flex-wrap gap-4">
            {STORAGE.map((field) => (
              <label key={field.name} className="flex items-center gap-2 text-sm">
                <input
                  type="checkbox"
                  name={field.name}
                  defaultChecked={Boolean(values[field.name])}
                />
                {field.label}
              </label>
            ))}
          </div>
        </fieldset>
      </Card>

      <Card title="Networking">
        <div className="grid gap-3 sm:grid-cols-3 lg:grid-cols-5">
          {NETWORK.map((field) => (
            <label key={field.name} className="flex flex-col gap-1">
              <span className="text-xs font-medium text-slate-500 uppercase">{field.label}</span>
              <input
                name={field.name}
                defaultValue={String(values[field.name] ?? "0.0.0.0")}
                className={`${inputClass} font-mono`}
              />
            </label>
          ))}
        </div>
      </Card>

      <Card title="Security & notes">
        <Selects fields={SECURITY} lookups={lookups} values={values} />
        <label className="mt-3 flex flex-col gap-1">
          <span className="text-xs font-medium text-slate-500 uppercase">Notes</span>
          <textarea name="notes" rows={4} defaultValue={values.notes ?? ""} className={inputClass} />
        </label>
      </Card>

      <div className="flex items-center gap-3">
        <button
          type="submit"
          disabled={pending}
          className="rounded bg-sky-600 px-4 py-2 text-sm font-medium text-white hover:bg-sky-700 disabled:opacity-50"
        >
          {pending ? "Saving…" : submitLabel}
        </button>
        <Link href={cancelHref} className="text-sm text-slate-500 hover:underline">
          Cancel
        </Link>
      </div>
    </form>
  );
}
