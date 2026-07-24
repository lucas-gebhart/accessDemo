export type Lookup = { id: number; name: string };

export type NodeSummaryRow = {
  node_id: number;
  node_name: string;
  node_description: string | null;
  node_serial_number: string;
  node_model: string;
  node_is_active: boolean;
  service_ip: string;
  node_type: string;
  system_type: string;
  environment: string;
  project: string;
  role: string;
  node_status: string;
  data_center: string;
  supplier: string;
  assigned_system_cores: number;
  assigned_system_memory: number;
};

export type NodeDetail = NodeSummaryRow & {
  main_dns_zone: string;
  security_domain: string;
  cluster_type: string;
  architecture_type: string;
  cpu_type: string;
  major_patch_level: string;
  rack_location: string;
  virtual_data_center: string;
  production_scope: string;
  delivery_status: string;
  service_manager: string;
  security_class: string;
  required_security_level: string;
  current_security_level: string;
  parent_node: string | null;
  max_system_cores: number;
  max_system_memory: number;
  max_speed_per_core: number;
  assigned_hba_ports: number;
  max_hba_ports: number;
  assigned_nic_ports: number;
  max_nic_ports: number;
  assigned_slots: number;
  max_slots: number;
  admin_ip: string;
  hardware_admin_ip: string;
  storage_ip: string;
  heart_beat_ip: string;
  has_internal_storage: boolean;
  has_nas_storage: boolean;
  has_san_storage: boolean;
  has_das_storage: boolean;
  has_cas_storage: boolean;
  notes: string | null;
  assigned_licenses: string | null;
  inventory_creation_date: Date;
  inventory_last_update_date: Date;
  node_delivery_date: Date | null;
  last_security_audit_date: Date | null;
  last_system_audit_date: Date | null;
} & Record<OperationalFlag, boolean>;

export const OPERATIONAL_FLAGS = [
  "data_center_is_operational",
  "hardware_is_operational",
  "networks_are_operational",
  "routing_is_operational",
  "dns_is_operational",
  "windows_domain_is_operational",
  "firewall_rules_are_operational",
  "operating_system_is_operational",
  "services_are_operational",
  "technical_users_are_operational",
  "security_services_are_operational",
  "service_users_are_operational",
  "storage_is_operational",
  "backup_is_operational",
  "monitoring_is_operational",
  "scheduling_is_operational",
  "cluster_is_operational",
] as const;

export type OperationalFlag = (typeof OPERATIONAL_FLAGS)[number];

export type ProjectRow = {
  project_id: number;
  project_name: string;
  project_cycle_label: string | null;
  description: string | null;
  is_service: boolean;
  current_progress: number;
  business_area: string;
  service_manager: string;
  priority: string;
  project_status: string;
  global_status_kpi: number;
  risk_status_kpi: number;
  execution_status_kpi: number;
  budget_status_kpi: number;
  scheduled_capex_budget: string;
  consumed_capex_budget: string;
  scheduled_opex_budget: string;
  consumed_opex_budget: string;
  scheduled_delivery_date: Date | null;
  delivery_date: Date | null;
  node_count: number;
  open_task_count: number;
};

export type TaskRow = {
  task_id: number;
  task_name: string;
  description: string | null;
  project: string;
  work_stream: string;
  category: string;
  priority: string;
  impact: string;
  updater: string;
  team: string;
  current_progress: number;
  is_blocked: boolean;
  is_freezed: boolean;
  start_date: Date;
  scheduled_end_date: Date;
  end_date: Date | null;
  rescheduling_count: number;
  global_status_kpi: number;
  work_time: number;
};

export type IssueRow = {
  issue_id: number;
  description: string;
  is_active: boolean;
  is_a_risk: boolean;
  project: string;
  owner: string;
  owner_team: string;
  risk_type: string;
  action_status: string;
  action_description: string | null;
  occurence_probability: number | null;
  severity_status_kpi: number;
  creation_date: Date;
  resolution_date: Date | null;
};

export type CountRow = { label: string; total: number };
