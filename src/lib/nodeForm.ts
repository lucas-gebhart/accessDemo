import { z } from "zod";

const numeric = z.coerce.number().int().nonnegative();

/**
 * Mirrors the editable fields of the Access "Infrastructure Node Management" form.
 * Defaults match the DEFAULT constraints of the original SQL Server table.
 */
export const nodeSchema = z.object({
  node_name: z.string().trim().min(1, "Node name is required").max(100),
  node_description: z.string().trim().max(100).optional().or(z.literal("")),
  node_serial_number: z.string().trim().min(1).max(200).default("Unknown"),
  node_model: z.string().trim().min(1).max(100).default("Unknown"),
  node_is_active: z.coerce.boolean().default(true),
  node_type_id: numeric,
  system_type_id: numeric,
  major_patch_level_id: numeric,
  supplier_id: numeric,
  main_dns_zone_id: numeric,
  security_domain_id: numeric,
  cluster_type_id: numeric,
  architecture_type_id: numeric,
  cpu_type_id: numeric,
  main_project_id: numeric,
  main_environment_id: numeric,
  main_role_id: numeric,
  data_center_location_id: numeric,
  virtual_data_center_id: numeric,
  rack_location_id: numeric,
  node_status_id: numeric,
  delivery_status_id: numeric,
  service_manager_id: numeric,
  production_scope_id: numeric,
  security_class_id: numeric,
  required_security_level_id: numeric,
  current_security_level_id: numeric,
  parent_node_id: numeric,
  assigned_system_cores: numeric.default(0),
  max_system_cores: numeric.default(0),
  assigned_system_memory: z.coerce.number().nonnegative().default(0),
  max_system_memory: z.coerce.number().nonnegative().default(0),
  assigned_hba_ports: numeric.default(0),
  max_hba_ports: numeric.default(0),
  assigned_nic_ports: numeric.default(0),
  max_nic_ports: numeric.default(0),
  assigned_slots: numeric.default(0),
  max_slots: numeric.default(0),
  service_ip: z.string().trim().max(100).default("0.0.0.0"),
  admin_ip: z.string().trim().max(100).default("0.0.0.0"),
  hardware_admin_ip: z.string().trim().max(100).default("0.0.0.0"),
  storage_ip: z.string().trim().max(100).default("0.0.0.0"),
  heart_beat_ip: z.string().trim().max(100).default("0.0.0.0"),
  has_internal_storage: z.coerce.boolean().default(false),
  has_nas_storage: z.coerce.boolean().default(false),
  has_san_storage: z.coerce.boolean().default(false),
  has_das_storage: z.coerce.boolean().default(false),
  has_cas_storage: z.coerce.boolean().default(false),
  notes: z.string().trim().optional().or(z.literal("")),
});

export type NodeInput = z.infer<typeof nodeSchema>;

export const NODE_FIELDS = Object.keys(nodeSchema.shape) as (keyof NodeInput)[];

const CHECKBOX_FIELDS = NODE_FIELDS.filter(
  (field) => field.startsWith("has_") || field === "node_is_active",
);

/** HTML checkboxes are absent from FormData when unchecked; normalise to booleans. */
export function parseNodeForm(formData: FormData) {
  const raw: Record<string, unknown> = {};
  for (const field of NODE_FIELDS) {
    const value = formData.get(field);
    raw[field] = CHECKBOX_FIELDS.includes(field) ? value === "on" || value === "true" : value;
  }
  return nodeSchema.safeParse(raw);
}
