import type { LookupName } from "@/lib/queries";

/** Every lookup list the node editor needs to render its combo boxes. */
export const NODE_FORM_LOOKUPS = [
  "node_types",
  "system_type",
  "major_patch_levels",
  "suppliers",
  "dns_zones",
  "security_domains",
  "nodes",
  "projects",
  "environments",
  "roles",
  "production_scopes",
  "updaters",
  "node_status",
  "delivery_status",
  "data_center_locations",
  "virtual_data_centers",
  "rack_locations",
  "architecture_types",
  "cpu_types",
  "cluster_types",
  "security_class",
  "security_level",
] as const satisfies readonly LookupName[];
