-- Generated from the OpenSLIM Microsoft Access / SQL Server back end.
-- Source: https://github.com/cveira/openslim (openslim-v373b0.mdb + OpenSLIM-v373b0-20100509-0.bak)

create table "rel_closed_progress_reports_issues" (
  "progress_report_id" integer not null default 0,
  "issue_id" integer not null default 0,
  "creation_date" timestamp not null default now(),
  "resolution_date" timestamp,
  "last_update_date" timestamp not null default now(),
  "occurence_probability" real,
  "severity_status_kpi" integer not null default 1,
  "action_status_id" integer not null default 1,
  primary key ("progress_report_id", "issue_id")
);

create table "rel_closed_progress_reports_tasks" (
  "progress_report_id" integer not null default 0,
  "task_id" integer not null default 0,
  "is_unplanned" boolean not null default false,
  "is_blocked" boolean not null default false,
  "is_freezed" boolean not null default false,
  "assigned_execution_order" integer not null default 0,
  "priority_id" integer not null default 5,
  "visibility_id" integer not null default 1,
  "impact_id" integer not null default 1,
  "current_progress" real not null default 0,
  "creation_date" timestamp not null default now(),
  "last_update_date" timestamp not null default now(),
  "start_date" timestamp not null default now(),
  "scheduled_end_date" timestamp not null default now(),
  "end_date" timestamp,
  "rescheduling_count" integer not null default 0,
  "global_status_kpi" integer not null default 1,
  "risk_status_kpi" integer not null default 1,
  "execution_status_kpi" integer not null default 1,
  "scope_status_kpi" integer not null default 1,
  "budget_status_kpi" integer not null default 1,
  "resources_status_kpi" integer not null default 1,
  "effort_and_dedication_status_kpi" integer not null default 1,
  primary key ("progress_report_id", "task_id")
);

create table "rel_nodes_environments" (
  "node_id" integer not null default 0,
  "environment_id" integer not null default 0,
  "notes" varchar(50),
  primary key ("node_id", "environment_id")
);

create table "rel_nodes_environments_history" (
  "record_id" serial not null,
  "record_date" timestamp not null default now(),
  "node_id" integer not null default 0,
  "environment_id" integer not null default 0,
  "notes" varchar(50),
  primary key ("record_id")
);

create table "rel_nodes_nodes" (
  "node_id" integer not null default 0,
  "related_node_id" integer not null default 0,
  "last_update_date" timestamp not null default now(),
  "connected_services" boolean not null default false,
  "coupled_components" boolean not null default false,
  "hosted_together" boolean not null default false,
  "hosted_by" boolean not null default false,
  "supported_by" boolean not null default false,
  "hosting" boolean not null default false,
  "supporting" boolean not null default false,
  "notes" varchar(50),
  primary key ("node_id", "related_node_id")
);

create table "rel_nodes_nodes_history" (
  "record_id" serial not null,
  "record_date" timestamp not null default now(),
  "node_id" integer not null default 0,
  "related_node_id" integer not null default 0,
  "last_update_date" timestamp not null default now(),
  "connected_services" boolean not null default false,
  "coupled_components" boolean not null default false,
  "hosted_together" boolean not null default false,
  "hosted_by" boolean not null default false,
  "supported_by" boolean not null default false,
  "hosting" boolean not null default false,
  "supporting" boolean not null default false,
  "notes" varchar(50),
  primary key ("record_id")
);

create table "rel_nodes_roles" (
  "node_id" integer not null default 0,
  "role_id" integer not null default 0,
  "notes" varchar(50),
  primary key ("node_id", "role_id")
);

create table "rel_nodes_roles_history" (
  "record_id" serial not null,
  "record_date" timestamp not null default now(),
  "node_id" integer not null default 0,
  "role_id" integer not null default 0,
  "notes" varchar(50),
  primary key ("record_id")
);

create table "rel_progress_reports_issues" (
  "progress_report_id" integer not null default 0,
  "issue_id" integer not null default 0,
  primary key ("progress_report_id", "issue_id")
);

create table "rel_progress_reports_issues_history" (
  "record_id" serial not null,
  "record_date" timestamp not null default now(),
  "progress_report_id" integer not null default 0,
  "issue_id" integer not null default 0,
  primary key ("record_id")
);

create table "rel_progress_reports_tasks" (
  "progress_report_id" integer not null default 0,
  "task_id" integer not null default 0,
  "is_unplanned" boolean not null default false,
  "assigned_execution_order" integer not null default 0,
  primary key ("progress_report_id", "task_id")
);

create table "rel_progress_reports_tasks_history" (
  "record_id" serial not null,
  "record_date" timestamp not null default now(),
  "progress_report_id" integer not null default 0,
  "task_id" integer not null default 0,
  "is_unplanned" boolean not null default false,
  "assigned_execution_order" integer not null default 0,
  primary key ("record_id")
);

create table "rel_projects_environments" (
  "project_id" integer not null default 0,
  "environment_id" integer not null default 0,
  "storage_nas_gb_capacity" integer not null default 0,
  "storage_san_gb_capacity" integer not null default 0,
  "storage_das_gb_capacity" integer not null default 0,
  "notes" integer default 0,
  primary key ("project_id", "environment_id")
);

create table "rel_projects_environments_history" (
  "record_id" serial not null,
  "record_date" timestamp not null default now(),
  "project_id" integer not null default 0,
  "environment_id" integer not null default 0,
  "storage_nas_gb_capacity" integer not null default 0,
  "storage_san_gb_capacity" integer not null default 0,
  "storage_das_gb_capacity" integer not null default 0,
  "notes" integer default 0,
  primary key ("record_id")
);

create table "rel_projects_nodes" (
  "project_id" integer not null default 0,
  "node_id" integer not null default 0,
  "notes" varchar(50),
  primary key ("project_id", "node_id")
);

create table "rel_projects_nodes_history" (
  "record_id" serial not null,
  "record_date" timestamp not null default now(),
  "project_id" integer not null default 0,
  "node_id" integer not null default 0,
  "notes" varchar(50),
  primary key ("record_id")
);

create table "action_status" (
  "status_id" serial not null,
  "status_name" varchar(50) not null,
  "status_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("status_id")
);

create table "architecture_types" (
  "architecture_type_id" serial not null,
  "architecture_type_name" varchar(50) not null,
  "architecture_type_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("architecture_type_id")
);

create table "business_areas" (
  "business_area_id" serial not null,
  "business_area_name" varchar(50),
  "business_area_description" varchar(50),
  "creation_date" timestamp not null default now(),
  "display_order_index" integer not null default 0,
  primary key ("business_area_id")
);

create table "cluster_types" (
  "cluster_type_id" serial not null,
  "cluster_type_name" varchar(50) not null,
  "cluster_type_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("cluster_type_id")
);

create table "cpu_types" (
  "cpu_type_id" serial not null,
  "cpu_type_name" varchar(50) not null,
  "cpu_type_description" varchar(50),
  "architecture_type_id" integer default 0,
  "display_order_index" integer not null default 0,
  primary key ("cpu_type_id")
);

create table "data_center_locations" (
  "data_center_location_id" serial not null,
  "data_center_location_name" varchar(50) not null,
  "data_center_location_description" varchar(50),
  "creation_date" timestamp not null default now(),
  "display_order_index" integer not null default 0,
  primary key ("data_center_location_id")
);

create table "decommissioning" (
  "decommissioning_id" serial not null,
  "node_id" integer not null default 1,
  "is_deleted" boolean not null default false,
  "owner_id" integer not null default 1,
  "parent_node_id" integer,
  "start_date" timestamp not null default now(),
  "scheduled_end_date" timestamp not null default now(),
  "end_date" timestamp,
  "priority_id" integer not null default 5,
  "visibility_id" integer not null default 1,
  "impact_id" integer not null default 1,
  "work_flow_status_id" integer not null default 1,
  "current_progress" real not null default 0,
  "is_blocked" boolean not null default false,
  "is_frozen" boolean not null default false,
  "global_status_kpi" integer not null default 1,
  "risk_status_kpi" integer not null default 1,
  "execution_status_kpi" integer not null default 1,
  "scope_status_kpi" integer not null default 1,
  "budget_status_kpi" integer not null default 1,
  "resources_status_kpi" integer not null default 1,
  "effort_and_dedication_status_kpi" integer not null default 1,
  "work_time" real not null default 0,
  "resources_involved" real not null default 0,
  "last_update_date" timestamp not null default now(),
  "rescheduling_count" integer not null default 0,
  "description" varchar(100),
  "notes" text,
  primary key ("decommissioning_id")
);

create table "decommissioning_history" (
  "record_id" serial not null,
  "record_date" timestamp not null default now(),
  "decommissioning_id" integer not null,
  "node_id" integer not null default 1,
  "is_deleted" boolean not null default false,
  "owner_id" integer not null default 1,
  "parent_node_id" integer,
  "start_date" timestamp not null default now(),
  "scheduled_end_date" timestamp not null default now(),
  "end_date" timestamp,
  "priority_id" integer not null default 5,
  "visibility_id" integer not null default 1,
  "impact_id" integer not null default 1,
  "work_flow_status_id" integer not null default 1,
  "current_progress" real not null default 0,
  "is_blocked" boolean not null default false,
  "is_frozen" boolean not null default false,
  "global_status_kpi" integer not null default 1,
  "risk_status_kpi" integer not null default 1,
  "execution_status_kpi" integer not null default 1,
  "scope_status_kpi" integer not null default 1,
  "budget_status_kpi" integer not null default 1,
  "resources_status_kpi" integer not null default 1,
  "effort_and_dedication_status_kpi" integer not null default 1,
  "work_time" real not null default 0,
  "resources_involved" real not null default 0,
  "last_update_date" timestamp not null default now(),
  "rescheduling_count" integer not null default 0,
  "description" varchar(100),
  "notes" text,
  primary key ("record_id")
);

create table "decommissioning_workflow_status" (
  "status_id" serial not null,
  "status_name" varchar(50) not null,
  "status_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("status_id")
);

create table "delivery_status" (
  "status_id" serial not null,
  "status_name" varchar(50) not null,
  "status_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("status_id")
);

create table "dns_zones" (
  "dns_zone_id" serial not null,
  "dns_zone_name" varchar(50) not null,
  "dns_zone_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("dns_zone_id")
);

create table "environments" (
  "environment_id" serial not null,
  "environment_name" varchar(50) not null,
  "environment_description" varchar(50),
  "creation_date" timestamp not null default now(),
  "display_order_index" integer not null default 0,
  primary key ("environment_id")
);

create table "impacts" (
  "impact_id" serial not null,
  "impact_name" varchar(50),
  "impact_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("impact_id")
);

create table "issues" (
  "issue_id" serial not null,
  "description" varchar(200) not null,
  "is_deleted" boolean not null default false,
  "is_active" boolean not null default false,
  "is_a_risk" boolean not null default false,
  "creation_date" timestamp not null default now(),
  "resolution_date" timestamp,
  "last_update_date" timestamp not null default now(),
  "related_with_id" integer not null default 1,
  "relationship_type_id" integer not null default 1,
  "owner_id" integer not null default 1,
  "owner_team_id" integer not null default 1,
  "project_id" integer not null default 4,
  "risk_type_id" integer not null default 1,
  "tags" varchar(100),
  "occurence_probability" real,
  "severity_status_kpi" integer not null default 1,
  "action_status_id" integer not null default 1,
  "action_description" text,
  primary key ("issue_id")
);

create table "issues_history" (
  "record_id" serial not null,
  "record_date" timestamp not null default now(),
  "issue_id" integer not null default 0,
  "description" varchar(200) not null,
  "is_deleted" boolean not null default false,
  "is_active" boolean not null default false,
  "is_a_risk" boolean not null default false,
  "creation_date" timestamp not null default now(),
  "resolution_date" timestamp,
  "last_update_date" timestamp not null default now(),
  "related_with_id" integer not null default 1,
  "relationship_type_id" integer not null default 1,
  "owner_id" integer not null default 1,
  "owner_team_id" integer not null default 1,
  "project_id" integer not null default 4,
  "risk_type_id" integer not null default 1,
  "tags" varchar(100),
  "occurence_probability" real,
  "severity_status_kpi" integer not null default 1,
  "action_status_id" integer not null default 1,
  "action_description" text,
  primary key ("record_id")
);

create table "kpi_status" (
  "status_id" serial not null,
  "status_name" varchar(50) not null,
  "status_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("status_id")
);

create table "major_patch_levels" (
  "major_patch_level_id" serial not null,
  "major_patch_level_name" varchar(50) not null,
  "major_patch_level_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("major_patch_level_id")
);

create table "maturity_status" (
  "maturity_status_id" serial not null,
  "maturity_status_name" varchar(50) not null,
  "maturity_status_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("maturity_status_id")
);

create table "networks" (
  "network_id" serial not null,
  "network_vlan_id" integer not null default 0,
  "network_name" varchar(50) not null,
  "network_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("network_id")
);

create table "nodes" (
  "node_id" serial not null,
  "node_name" varchar(50) not null,
  "main_dns_zone_id" integer not null default 1,
  "node_is_deleted" boolean not null default true,
  "node_is_active" boolean not null default true,
  "parent_node_id" integer not null default 34,
  "security_domain_id" integer not null default 1,
  "node_serial_number" varchar(100) not null default 'Unknown',
  "node_type_id" integer not null default 1,
  "system_type_id" integer not null default 1,
  "major_patch_level_id" integer not null default 1,
  "supplier_id" integer not null default 1,
  "node_model" varchar(50) not null default 'Unknown',
  "has_internal_storage" boolean not null default true,
  "has_nas_storage" boolean not null default false,
  "has_san_storage" boolean not null default false,
  "has_das_storage" boolean not null default false,
  "has_cas_storage" boolean not null default false,
  "hba_links_info" text default 'Unknown',
  "cluster_type_id" integer not null default 1,
  "architecture_type_id" integer not null default 1,
  "cpu_type_id" integer not null default 1,
  "assigned_system_cores" integer not null default 0,
  "max_system_cores" integer not null default 0,
  "max_speed_per_core" real not null default 0,
  "speed_per_core_is_system_invariant" boolean not null default true,
  "assigned_system_memory" real not null default 0,
  "max_system_memory" real not null default 0,
  "assigned_hba_ports" integer not null default 0,
  "max_hba_ports" integer not null default 0,
  "max_speed_per_hba" real not null default 0,
  "speed_per_hba_is_system_invariant" boolean not null default true,
  "assigned_nic_ports" integer not null default 0,
  "max_nic_ports" integer not null default 0,
  "max_speed_per_nic" real not null default 0,
  "speed_per_nic_is_system_invariant" boolean not null default true,
  "assigned_serial_ports" integer not null default 0,
  "max_serial_ports" integer not null default 0,
  "max_speed_per_serial_port" real not null default 0,
  "speed_per_serial_port_is_system_invariant" boolean not null default true,
  "assigned_slots" integer not null default 0,
  "max_slots" integer not null default 0,
  "computing_capacity_index" integer,
  "storage_capacity_index" integer,
  "main_project_id" integer not null default 4,
  "main_environment_id" integer not null default 1,
  "main_role_id" integer not null default 12,
  "data_center_location_id" integer not null default 1,
  "virtual_data_center_id" integer not null default 1,
  "rack_location_id" integer not null default 1,
  "service_ip" varchar(50) not null default '0.0.0.0',
  "admin_ip" varchar(50) not null default '0.0.0.0',
  "hardware_admin_ip" varchar(50) not null default '0.0.0.0',
  "storage_ip" varchar(50) not null default '0.0.0.0',
  "heart_beat_ip" varchar(50) not null default '0.0.0.0',
  "service_vlan_id" integer not null default 1,
  "admin_vlan_id" integer not null default 1,
  "hardware_admin_vlan_id" integer not null default 1,
  "storage_vlan_id" integer not null default 1,
  "heart_beat_vlan_id" integer not null default 1,
  "node_status_id" integer not null default 1,
  "delivery_status_id" integer not null default 1,
  "service_manager_id" integer not null default 1,
  "production_scope_id" integer not null default 1,
  "responsibility_degree" real default 1,
  "data_center_is_operational" boolean not null default false,
  "hardware_is_operational" boolean not null default false,
  "networks_are_operational" boolean not null default false,
  "routing_is_operational" boolean not null default false,
  "dns_is_operational" boolean not null default false,
  "windows_domain_is_operational" boolean not null default false,
  "firewall_rules_are_operational" boolean not null default false,
  "operating_system_is_operational" boolean not null default false,
  "services_are_operational" boolean not null default false,
  "technical_users_are_operational" boolean not null default false,
  "security_services_are_operational" boolean not null default false,
  "service_users_are_operational" boolean not null default false,
  "storage_is_operational" boolean not null default false,
  "backup_is_operational" boolean not null default false,
  "monitoring_is_operational" boolean not null default false,
  "scheduling_is_operational" boolean not null default false,
  "cluster_is_operational" boolean not null default false,
  "foreign_cmdb_id" varchar(50),
  "foreign_cmdb_update_count" integer not null default 0,
  "foreign_cmdb_last_update_date" timestamp,
  "service_board_has_been_updated" boolean not null default false,
  "service_board_update_count" integer not null default 0,
  "maintenance_windows_are_defined" boolean not null default false,
  "maintenance_system_stop_window" varchar(50),
  "maintenance_system_restart_window" varchar(50),
  "maintenance_cluster_balance_window" varchar(50),
  "maintenance_service_stop_window" varchar(50),
  "maintenance_service_restart_window" varchar(50),
  "node_scheduled_delivery_date" timestamp,
  "node_delivery_date" timestamp,
  "hardware_last_update_date" timestamp,
  "firmware_last_update_date" timestamp,
  "operating_system_last_update_date" timestamp,
  "services_last_update_date" timestamp,
  "security_class_id" integer not null default 1,
  "required_security_level_id" integer not null default 1,
  "current_security_level_id" integer not null default 1,
  "risk_status_id" integer not null default 1,
  "last_security_audit_date" timestamp,
  "last_system_audit_date" timestamp,
  "security_audit_report" text,
  "system_audit_report" text,
  "monitoring_audit_exception" boolean not null default false,
  "backup_audit_exception" boolean not null default false,
  "system_audit_exception" boolean not null default false,
  "security_audit_exception" boolean not null default false,
  "audit_exceptions_are_approved" boolean not null default false,
  "audit_exceptions_last_approver_id" integer not null default 1,
  "audit_exceptions_last_review_date" timestamp,
  "audit_exceptions_description" text,
  "inventory_updater_id" integer not null default 1,
  "inventory_creation_date" timestamp not null default now(),
  "inventory_last_update_date" timestamp not null default now(),
  "node_description" varchar(50),
  "assigned_licenses" varchar(50) default 'N/A',
  "system_information_dump" text,
  "notes" text,
  primary key ("node_id")
);

create table "nodes_history" (
  "record_id" serial not null,
  "record_date" timestamp not null default now(),
  "node_id" integer not null default 0,
  "node_name" varchar(50) not null,
  "main_dns_zone_id" integer not null default 1,
  "node_is_deleted" boolean not null default true,
  "node_is_active" boolean not null default true,
  "parent_node_id" integer not null default 12,
  "security_domain_id" integer not null default 1,
  "node_serial_number" varchar(100) not null default 'Unknown',
  "node_type_id" integer not null default 1,
  "system_type_id" integer not null default 1,
  "major_patch_level_id" integer not null default 1,
  "supplier_id" integer not null default 1,
  "node_model" varchar(50) not null default 'Unknown',
  "has_internal_storage" boolean not null default true,
  "has_nas_storage" boolean not null default false,
  "has_san_storage" boolean not null default false,
  "has_das_storage" boolean not null default false,
  "has_cas_storage" boolean not null default false,
  "hba_links_info" text default 'Unknown',
  "cluster_type_id" integer not null default 1,
  "architecture_type_id" integer not null default 1,
  "cpu_type_id" integer not null default 1,
  "assigned_system_cores" integer not null default 0,
  "max_system_cores" integer not null default 0,
  "max_speed_per_core" real not null default 0,
  "speed_per_core_is_system_invariant" boolean not null default true,
  "assigned_system_memory" real not null default 0,
  "max_system_memory" real not null default 0,
  "assigned_hba_ports" integer not null default 0,
  "max_hba_ports" integer not null default 0,
  "max_speed_per_hba" real not null default 0,
  "speed_per_hba_is_system_invariant" boolean not null default true,
  "assigned_nic_ports" integer not null default 0,
  "max_nic_ports" integer not null default 0,
  "max_speed_per_nic" real not null default 0,
  "speed_per_nic_is_system_invariant" boolean not null default true,
  "assigned_serial_ports" integer not null default 0,
  "max_serial_ports" integer not null default 0,
  "max_speed_per_serial_port" real not null default 0,
  "speed_per_serial_port_is_system_invariant" boolean not null default true,
  "assigned_slots" integer not null default 0,
  "max_slots" integer not null default 0,
  "computing_capacity_index" integer,
  "storage_capacity_index" integer,
  "main_project_id" integer not null default 4,
  "main_environment_id" integer not null default 1,
  "main_role_id" integer not null default 12,
  "data_center_location_id" integer not null default 1,
  "virtual_data_center_id" integer not null default 1,
  "rack_location_id" integer not null default 1,
  "service_ip" varchar(50) not null default '0.0.0.0',
  "admin_ip" varchar(50) not null default '0.0.0.0',
  "hardware_admin_ip" varchar(50) not null default '0.0.0.0',
  "storage_ip" varchar(50) not null default '0.0.0.0',
  "heart_beat_ip" varchar(50) not null default '0.0.0.0',
  "service_vlan_id" integer not null default 1,
  "admin_vlan_id" integer not null default 1,
  "hardware_admin_vlan_id" integer not null default 1,
  "storage_vlan_id" integer not null default 1,
  "heart_beat_vlan_id" integer not null default 1,
  "node_status_id" integer not null default 1,
  "delivery_status_id" integer not null default 1,
  "service_manager_id" integer not null default 1,
  "production_scope_id" integer not null default 1,
  "responsibility_degree" real default 1,
  "data_center_is_operational" boolean not null default false,
  "hardware_is_operational" boolean not null default false,
  "networks_are_operational" boolean not null default false,
  "routing_is_operational" boolean not null default false,
  "dns_is_operational" boolean not null default false,
  "windows_domain_is_operational" boolean not null default false,
  "firewall_rules_are_operational" boolean not null default false,
  "operating_system_is_operational" boolean not null default false,
  "services_are_operational" boolean not null default false,
  "technical_users_are_operational" boolean not null default false,
  "security_services_are_operational" boolean not null default false,
  "service_users_are_operational" boolean not null default false,
  "storage_is_operational" boolean not null default false,
  "backup_is_operational" boolean not null default false,
  "monitoring_is_operational" boolean not null default false,
  "scheduling_is_operational" boolean not null default false,
  "cluster_is_operational" boolean not null default false,
  "foreign_cmdb_id" varchar(50),
  "foreign_cmdb_update_count" integer not null default 0,
  "foreign_cmdb_last_update_date" timestamp,
  "service_board_has_been_updated" boolean not null default false,
  "service_board_update_count" integer not null default 0,
  "maintenance_windows_are_defined" boolean not null default false,
  "maintenance_system_stop_window" varchar(50),
  "maintenance_system_restart_window" varchar(50),
  "maintenance_cluster_balance_window" varchar(50),
  "maintenance_service_stop_window" varchar(50),
  "maintenance_service_restart_window" varchar(50),
  "node_scheduled_delivery_date" timestamp,
  "node_delivery_date" timestamp,
  "hardware_last_update_date" timestamp,
  "firmware_last_update_date" timestamp,
  "operating_system_last_update_date" timestamp,
  "services_last_update_date" timestamp,
  "security_class_id" integer not null default 1,
  "required_security_level_id" integer not null default 1,
  "current_security_level_id" integer not null default 1,
  "risk_status_id" integer not null default 1,
  "last_security_audit_date" timestamp,
  "last_system_audit_date" timestamp,
  "security_audit_report" text,
  "system_audit_report" text,
  "monitoring_audit_exception" boolean not null default false,
  "backup_audit_exception" boolean not null default false,
  "system_audit_exception" boolean not null default false,
  "security_audit_exception" boolean not null default false,
  "audit_exceptions_are_approved" boolean not null default false,
  "audit_exceptions_last_approver_id" integer not null default 1,
  "audit_exceptions_last_review_date" timestamp,
  "audit_exceptions_description" text,
  "inventory_updater_id" integer not null default 1,
  "inventory_creation_date" timestamp not null default now(),
  "inventory_last_update_date" timestamp not null default now(),
  "node_description" varchar(50),
  "assigned_licenses" varchar(50) default 'N/A',
  "system_information_dump" text,
  "notes" text,
  primary key ("record_id")
);

create table "node_status" (
  "status_id" serial not null,
  "status_name" varchar(50) not null,
  "status_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("status_id")
);

create table "node_types" (
  "node_type_id" serial not null,
  "node_type_name" varchar(50) not null,
  "node_type_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("node_type_id")
);

create table "priorities" (
  "priority_id" serial not null,
  "priority_name" varchar(50),
  "priority_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("priority_id")
);

create table "production_scopes" (
  "production_scope_id" serial not null,
  "production_scope_name" varchar(50) not null,
  "production_scope_description" varchar(50),
  "creation_date" timestamp default now(),
  "display_order_index" integer not null default 0,
  primary key ("production_scope_id")
);

create table "progress_reports" (
  "progress_report_id" serial not null,
  "report_is_deleted" boolean not null default false,
  "report_is_closed" boolean not null default false,
  "owner_id" integer not null default 1,
  "start_date" timestamp not null default now(),
  "end_date" timestamp not null default now(),
  "is_project_report" boolean default true,
  "team_id" integer not null default 1,
  "project_id" integer not null default 4,
  "available_res_count" integer not null default 0,
  "report_update_count" integer not null default 0,
  primary key ("progress_report_id")
);

create table "progress_reports_history" (
  "record_id" serial not null,
  "record_date" timestamp not null default now(),
  "progress_report_id" integer not null default 0,
  "report_is_deleted" boolean not null default false,
  "report_is_closed" boolean not null default false,
  "owner_id" integer not null default 1,
  "start_date" timestamp not null default now(),
  "end_date" timestamp not null default now(),
  "is_project_report" boolean default true,
  "team_id" integer not null default 1,
  "project_id" integer not null default 4,
  "available_res_count" integer not null default 0,
  "report_update_count" integer not null default 0,
  primary key ("record_id")
);

create table "projects" (
  "project_id" serial not null,
  "project_name" varchar(50) not null,
  "project_cycle_label" varchar(50),
  "parent_project_id" integer not null default 6,
  "is_service" boolean not null default false,
  "project_creation_date" timestamp not null default now(),
  "project_last_update_date" timestamp not null default now(),
  "service_manager_id" integer not null default 1,
  "business_area_id" integer not null default 1,
  "priority_id" integer not null default 1,
  "visibility_id" integer not null default 1,
  "has_project_plan" boolean not null default false,
  "has_cost_benefit_analysis" boolean not null default false,
  "has_business_case" boolean not null default false,
  "has_approved_budget" boolean not null default false,
  "has_architecture_design" boolean not null default false,
  "has_deployment_doc" boolean not null default false,
  "has_operations_doc" boolean not null default false,
  "has_deployment_qa_doc" boolean not null default false,
  "has_upgrade_qa_doc" boolean not null default false,
  "has_change_qa_doc" boolean not null default false,
  "has_governance_system" boolean not null default false,
  "has_service_support_process" boolean not null default false,
  "has_ol_as" boolean not null default false,
  "has_slo" boolean not null default false,
  "has_sla" boolean not null default false,
  "has_satisfaction_survey" boolean not null default false,
  "is_the_final_solution" boolean not null default false,
  "service_coverage_id" integer default 1,
  "network_doc_repository" text,
  "web_doc_repository" text,
  "scheduled_sla" real default 0,
  "current_sla" real default 0,
  "scheduled_capex_budget" numeric(19,4) not null default 0,
  "consumed_capex_budget" numeric(19,4) not null default 0,
  "scheduled_opex_budget" numeric(19,4) not null default 0,
  "consumed_opex_budget" numeric(19,4) not null default 0,
  "forecasted_capacity_growth" integer not null default 0,
  "project_status_id" integer not null default 1,
  "current_progress" real not null default 0,
  "scheduled_delivery_date" timestamp,
  "delivery_date" timestamp,
  "project_goal_change_count" integer not null default 0,
  "project_scope_change_count" integer not null default 0,
  "project_rescheduling_count" integer not null default 0,
  "global_status_kpi" integer not null default 1,
  "risk_status_kpi" integer not null default 1,
  "execution_status_kpi" integer not null default 1,
  "scope_status_kpi" integer not null default 1,
  "budget_status_kpi" integer not null default 1,
  "resources_status_kpi" integer not null default 1,
  "effort_and_dedication_status_kpi" integer not null default 1,
  "global_maturity_evaluation_id" integer not null default 1,
  "description" varchar(100),
  "project_goals" varchar(200),
  "current_situation_report" varchar(200),
  "next_project_steps" varchar(200),
  "notes" text,
  primary key ("project_id")
);

create table "projects_history" (
  "record_id" serial not null,
  "record_date" timestamp not null default now(),
  "project_id" integer not null default 0,
  "project_name" varchar(50) not null,
  "project_cycle_label" varchar(50),
  "parent_project_id" integer not null default 6,
  "is_service" boolean not null default false,
  "project_creation_date" timestamp not null default now(),
  "project_last_update_date" timestamp not null default now(),
  "service_manager_id" integer not null default 1,
  "business_area_id" integer not null default 1,
  "priority_id" integer not null default 1,
  "visibility_id" integer not null default 1,
  "has_project_plan" boolean not null default false,
  "has_cost_benefit_analysis" boolean not null default false,
  "has_business_case" boolean not null default false,
  "has_approved_budget" boolean not null default false,
  "has_architecture_design" boolean not null default false,
  "has_deployment_doc" boolean not null default false,
  "has_operations_doc" boolean not null default false,
  "has_deployment_qa_doc" boolean not null default false,
  "has_upgrade_qa_doc" boolean not null default false,
  "has_change_qa_doc" boolean not null default false,
  "has_governance_system" boolean not null default false,
  "has_service_support_process" boolean not null default false,
  "has_ol_as" boolean not null default false,
  "has_slo" boolean not null default false,
  "has_sla" boolean not null default false,
  "has_satisfaction_survey" boolean not null default false,
  "is_the_final_solution" boolean not null default false,
  "service_coverage_id" integer default 1,
  "network_doc_repository" text,
  "web_doc_repository" text,
  "scheduled_sla" real default 0,
  "current_sla" real default 0,
  "scheduled_capex_budget" numeric(19,4) not null default 0,
  "consumed_capex_budget" numeric(19,4) not null default 0,
  "scheduled_opex_budget" numeric(19,4) not null default 0,
  "consumed_opex_budget" numeric(19,4) not null default 0,
  "forecasted_capacity_growth" integer not null default 0,
  "project_status_id" integer not null default 1,
  "current_progress" real not null default 0,
  "scheduled_delivery_date" timestamp,
  "delivery_date" timestamp,
  "project_goal_change_count" integer not null default 0,
  "project_scope_change_count" integer not null default 0,
  "project_rescheduling_count" integer not null default 0,
  "global_status_kpi" integer not null default 1,
  "risk_status_kpi" integer not null default 1,
  "execution_status_kpi" integer not null default 1,
  "scope_status_kpi" integer not null default 1,
  "budget_status_kpi" integer not null default 1,
  "resources_status_kpi" integer not null default 1,
  "effort_and_dedication_status_kpi" integer not null default 1,
  "global_maturity_evaluation_id" integer not null default 1,
  "description" varchar(100),
  "project_goals" varchar(200),
  "current_situation_report" varchar(200),
  "next_project_steps" varchar(200),
  "notes" text,
  primary key ("record_id")
);

create table "project_status" (
  "status_id" serial not null,
  "status_name" varchar(50) not null,
  "status_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("status_id")
);

create table "provisioning_project_details" (
  "provisioning_project_id" integer not null,
  "node_id" integer not null default 1,
  "is_deleted" boolean not null default false,
  "priority_id" integer not null default 5,
  "impact_id" integer not null default 1,
  "current_progress" real not null default 0,
  "is_blocked" boolean not null default false,
  "is_freezed" boolean not null default false,
  "risk_status_kpi" integer not null default 1,
  "effort_and_dedication_status_kpi" integer not null default 1,
  "work_time" real not null default 0,
  "resources_involved" real not null default 0,
  "data_center_requirements_request" timestamp,
  "data_center_requirements" timestamp,
  "networking_requirements_request" timestamp,
  "networking_requirements" timestamp,
  "hardware_requirements_request" timestamp,
  "hardware_requirements" timestamp,
  "storage_requirements_request" timestamp,
  "storage_requirements" timestamp,
  "system_deployment_date" timestamp,
  "post_deployment_requirements_request" timestamp,
  "post_deployment_requirements" timestamp,
  "post_deployment_date" timestamp,
  "products_requirements_request" timestamp,
  "products_requirements" timestamp,
  "products_deployment_date" timestamp,
  "application_requirements_request" timestamp,
  "application_requirements" timestamp,
  "application_deployment_date" timestamp,
  "delivery_date" timestamp,
  "last_update_date" timestamp not null default now(),
  "update_count" integer not null default 0,
  "rescheduling_count" integer not null default 0,
  "description" varchar(100),
  "notes" text,
  primary key ("provisioning_project_id", "node_id")
);

create table "provisioning_project_details_history" (
  "record_id" serial not null,
  "record_date" timestamp not null default now(),
  "provisioning_project_id" integer not null,
  "node_id" integer not null default 1,
  "is_deleted" boolean not null default false,
  "priority_id" integer not null default 5,
  "impact_id" integer not null default 1,
  "current_progress" real not null default 0,
  "is_blocked" boolean not null default false,
  "is_freezed" boolean not null default false,
  "risk_status_kpi" integer not null default 1,
  "effort_and_dedication_status_kpi" integer not null default 1,
  "work_time" real not null default 0,
  "resources_involved" real not null default 0,
  "data_center_requirements_request" timestamp,
  "data_center_requirements" timestamp,
  "networking_requirements_request" timestamp,
  "networking_requirements" timestamp,
  "hardware_requirements_request" timestamp,
  "hardware_requirements" timestamp,
  "storage_requirements_request" timestamp,
  "storage_requirements" timestamp,
  "system_deployment_date" timestamp,
  "post_deployment_requirements_request" timestamp,
  "post_deployment_requirements" timestamp,
  "post_deployment_date" timestamp,
  "products_requirements_request" timestamp,
  "products_requirements" timestamp,
  "products_deployment_date" timestamp,
  "application_requirements_request" timestamp,
  "application_requirements" timestamp,
  "application_deployment_date" timestamp,
  "delivery_date" timestamp,
  "last_update_date" timestamp not null default now(),
  "update_count" integer not null default 0,
  "rescheduling_count" integer not null default 0,
  "description" varchar(100),
  "notes" text,
  primary key ("record_id")
);

create table "provisioning_projects" (
  "provisioning_project_id" serial not null,
  "provisioning_project_name" varchar(50) not null,
  "provisioning_project_label" varchar(50),
  "is_deleted" boolean not null default false,
  "project_id" integer not null default 1,
  "owner_id" integer not null default 1,
  "priority_id" integer not null default 5,
  "visibility_id" integer not null default 1,
  "impact_id" integer not null default 1,
  "current_progress" real not null default 0,
  "is_blocked" boolean not null default false,
  "is_freezed" boolean not null default false,
  "start_date" timestamp not null default now(),
  "proposal_approval_date" timestamp,
  "acquisition_date" timestamp,
  "supplier_delivery_date" timestamp,
  "scheduled_end_date" timestamp not null default now(),
  "end_date" timestamp,
  "global_status_kpi" integer not null default 1,
  "risk_status_kpi" integer not null default 1,
  "execution_status_kpi" integer not null default 1,
  "scope_status_kpi" integer not null default 1,
  "budget_status_kpi" integer not null default 1,
  "resources_status_kpi" integer not null default 1,
  "effort_and_dedication_status_kpi" integer not null default 1,
  "work_time" real not null default 0,
  "resources_involved" real not null default 0,
  "last_update_date" timestamp not null default now(),
  "update_count" integer not null default 0,
  "rescheduling_count" integer not null default 0,
  "description" varchar(100),
  "notes" text,
  primary key ("provisioning_project_id")
);

create table "provisioning_projects_history" (
  "record_id" serial not null,
  "record_date" timestamp not null default now(),
  "provisioning_project_id" integer not null,
  "provisioning_project_name" varchar(50) not null,
  "provisioning_project_label" varchar(50),
  "is_deleted" boolean not null default false,
  "project_id" integer not null default 1,
  "owner_id" integer not null default 1,
  "priority_id" integer not null default 5,
  "visibility_id" integer not null default 1,
  "impact_id" integer not null default 1,
  "current_progress" real not null default 0,
  "is_blocked" boolean not null default false,
  "is_freezed" boolean not null default false,
  "start_date" timestamp not null default now(),
  "proposal_approval_date" timestamp,
  "acquisition_date" timestamp,
  "supplier_delivery_date" timestamp,
  "scheduled_end_date" timestamp not null default now(),
  "end_date" timestamp,
  "global_status_kpi" integer not null default 1,
  "risk_status_kpi" integer not null default 1,
  "execution_status_kpi" integer not null default 1,
  "scope_status_kpi" integer not null default 1,
  "budget_status_kpi" integer not null default 1,
  "resources_status_kpi" integer not null default 1,
  "effort_and_dedication_status_kpi" integer not null default 1,
  "work_time" real not null default 0,
  "resources_involved" real not null default 0,
  "last_update_date" timestamp not null default now(),
  "update_count" integer not null default 0,
  "rescheduling_count" integer not null default 0,
  "description" varchar(100),
  "notes" text,
  primary key ("record_id")
);

create table "rack_locations" (
  "rack_location_id" serial not null,
  "rack_location_name" varchar(50) not null,
  "rack_location_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("rack_location_id")
);

create table "relationship_type" (
  "relationship_type_id" serial not null,
  "relationship_type_name" varchar(50) not null,
  "relationship_type_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("relationship_type_id")
);

create table "repairs" (
  "repair_id" serial not null,
  "node_id" integer not null default 1,
  "is_deleted" boolean not null default false,
  "owner_id" integer not null default 1,
  "delivered_node_id" integer not null default 1,
  "parent_node_id" integer not null default 1,
  "start_date" timestamp not null default now(),
  "scheduled_end_date" timestamp not null default now(),
  "end_date" timestamp,
  "priority_id" integer not null default 5,
  "visibility_id" integer not null default 1,
  "impact_id" integer not null default 1,
  "work_flow_status_id" integer not null default 1,
  "current_progress" real not null default 0,
  "is_blocked" boolean not null default false,
  "is_freezed" boolean not null default false,
  "supplier_repair_id" varchar(50),
  "global_status_kpi" integer not null default 1,
  "risk_status_kpi" integer not null default 1,
  "execution_status_kpi" integer not null default 1,
  "scope_status_kpi" integer not null default 1,
  "budget_status_kpi" integer not null default 1,
  "resources_status_kpi" integer not null default 1,
  "effort_and_dedication_status_kpi" integer not null default 1,
  "work_time" real not null default 0,
  "resources_involved" real not null default 0,
  "last_update_date" timestamp not null default now(),
  "rescheduling_count" integer not null default 0,
  "description" varchar(100),
  "notes" text,
  primary key ("repair_id")
);

create table "repairs_history" (
  "record_id" serial not null,
  "record_date" timestamp not null default now(),
  "repair_id" integer not null default 1,
  "node_id" integer not null default 1,
  "is_deleted" boolean not null default false,
  "owner_id" integer not null default 1,
  "delivered_node_id" integer not null default 1,
  "parent_node_id" integer not null default 1,
  "start_date" timestamp not null default now(),
  "scheduled_end_date" timestamp not null default now(),
  "end_date" timestamp,
  "priority_id" integer not null default 5,
  "visibility_id" integer not null default 1,
  "impact_id" integer not null default 1,
  "work_flow_status_id" integer not null default 1,
  "current_progress" real not null default 0,
  "is_blocked" boolean not null default false,
  "is_freezed" boolean not null default false,
  "supplier_repair_id" varchar(50),
  "global_status_kpi" integer not null default 1,
  "risk_status_kpi" integer not null default 1,
  "execution_status_kpi" integer not null default 1,
  "scope_status_kpi" integer not null default 1,
  "budget_status_kpi" integer not null default 1,
  "resources_status_kpi" integer not null default 1,
  "effort_and_dedication_status_kpi" integer not null default 1,
  "work_time" real not null default 0,
  "resources_involved" real not null default 0,
  "last_update_date" timestamp not null default now(),
  "rescheduling_count" integer not null default 0,
  "description" varchar(100),
  "notes" text,
  primary key ("record_id")
);

create table "repair_workflow_status" (
  "status_id" serial not null,
  "status_name" varchar(50) not null,
  "status_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("status_id")
);

create table "risk_type" (
  "risk_type_id" serial not null,
  "risk_type_name" varchar(50) not null,
  "risk_type_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("risk_type_id")
);

create table "roles" (
  "role_id" serial not null,
  "role_name" varchar(50) not null,
  "role_description" varchar(50),
  "creation_date" timestamp not null default now(),
  "display_order_index" integer not null default 0,
  primary key ("role_id")
);

create table "security_class" (
  "security_class_id" serial not null,
  "security_class_name" varchar(50) not null,
  "security_class_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("security_class_id")
);

create table "security_domains" (
  "domain_id" serial not null,
  "domain_name" varchar(50) not null,
  "domain_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("domain_id")
);

create table "security_level" (
  "security_level_id" serial not null,
  "security_level_name" varchar(50),
  "security_level_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("security_level_id")
);

create table "service_coverage" (
  "coverage_id" serial not null,
  "coverage_name" varchar(50) not null,
  "coverage_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("coverage_id")
);

create table "suppliers" (
  "supplier_id" serial not null,
  "supplier_name" varchar(50) not null,
  "supplier_description" varchar(50),
  "creation_date" timestamp not null default now(),
  "supplier_support_site" varchar(50),
  "supplier_e_mail" varchar(50),
  "supplier_phone" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("supplier_id")
);

create table "system_type" (
  "system_type_id" serial not null,
  "system_type_name" varchar(50) not null,
  "system_type_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("system_type_id")
);

create table "task_categories" (
  "category_id" serial not null,
  "category_name" varchar(50),
  "category_description" varchar(50),
  "creation_date" timestamp not null default now(),
  "display_order_index" integer not null default 0,
  primary key ("category_id")
);

create table "tasks" (
  "task_id" serial not null,
  "task_name" varchar(50) not null,
  "related_with_id" integer not null default 1,
  "relationship_type_id" integer not null default 1,
  "project_id" integer not null default 6,
  "work_stream_id" integer not null default 2,
  "priority_id" integer not null default 5,
  "visibility_id" integer not null default 1,
  "impact_id" integer not null default 1,
  "current_progress" real not null default 0,
  "is_blocked" boolean not null default false,
  "is_freezed" boolean not null default false,
  "updater_id" integer not null default 1,
  "updater_team_id" integer not null default 1,
  "creation_date" timestamp not null default now(),
  "last_update_date" timestamp not null default now(),
  "start_date" timestamp not null default now(),
  "scheduled_end_date" timestamp not null default now(),
  "end_date" timestamp,
  "task_category_id" integer not null default 1,
  "tags" varchar(100),
  "rescheduling_count" integer not null default 0,
  "global_status_kpi" integer not null default 1,
  "risk_status_kpi" integer not null default 1,
  "execution_status_kpi" integer not null default 1,
  "scope_status_kpi" integer not null default 1,
  "budget_status_kpi" integer not null default 1,
  "resources_status_kpi" integer not null default 1,
  "effort_and_dedication_status_kpi" integer not null default 1,
  "work_time" real not null default 0,
  "resources_involved" real not null default 0,
  "description" varchar(100),
  "notes" text,
  primary key ("task_id")
);

create table "tasks_history" (
  "record_id" serial not null,
  "record_date" timestamp not null default now(),
  "task_id" integer not null default 0,
  "task_name" varchar(50) not null,
  "related_with_id" integer not null default 1,
  "relationship_type_id" integer not null default 1,
  "project_id" integer not null default 6,
  "work_stream_id" integer not null default 2,
  "priority_id" integer not null default 5,
  "visibility_id" integer not null default 1,
  "impact_id" integer not null default 1,
  "current_progress" real not null default 0,
  "is_blocked" boolean not null default false,
  "is_freezed" boolean not null default false,
  "updater_id" integer not null default 1,
  "updater_team_id" integer not null default 1,
  "creation_date" timestamp not null default now(),
  "last_update_date" timestamp not null default now(),
  "start_date" timestamp not null default now(),
  "scheduled_end_date" timestamp not null default now(),
  "end_date" timestamp,
  "task_category_id" integer not null default 1,
  "tags" varchar(100),
  "rescheduling_count" integer not null default 0,
  "global_status_kpi" integer not null default 1,
  "risk_status_kpi" integer not null default 1,
  "execution_status_kpi" integer not null default 1,
  "scope_status_kpi" integer not null default 1,
  "budget_status_kpi" integer not null default 1,
  "resources_status_kpi" integer not null default 1,
  "effort_and_dedication_status_kpi" integer not null default 1,
  "work_time" real not null default 0,
  "resources_involved" real not null default 0,
  "description" varchar(100),
  "notes" text,
  primary key ("record_id")
);

create table "teams" (
  "team_id" serial not null,
  "team_name" varchar(50) not null,
  "team_description" varchar(50),
  "creation_date" timestamp not null default now(),
  "team_goal_change_count" integer not null default 0,
  "team_goals" varchar(200),
  "display_order_index" integer not null default 0,
  primary key ("team_id")
);

create table "updaters" (
  "user_id" serial not null,
  "windows_login_id" varchar(50),
  "user_full_name" varchar(50) not null,
  "team_id" integer not null default 1,
  "role_name" varchar(50),
  "role_description" varchar(50),
  "contact_e_mail1" varchar(50),
  "contact_e_mail2" varchar(50),
  "contact_phone1" varchar(50),
  "contact_phone2" varchar(50),
  "contact_messenger1" varchar(50),
  "contact_messenger2" varchar(50),
  "is_operational" boolean not null default true,
  "creation_date" timestamp not null default now(),
  "last_updated" timestamp not null default now(),
  "notes" text,
  "display_order_index" integer not null default 4,
  primary key ("user_id")
);

create table "updaters_history" (
  "record_id" serial not null,
  "record_date" timestamp not null default now(),
  "user_id" integer default 0,
  "windows_login_id" varchar(50),
  "user_full_name" varchar(50) not null,
  "team_id" integer not null default 1,
  "role_name" varchar(50),
  "role_description" varchar(50),
  "contact_e_mail1" varchar(50),
  "contact_e_mail2" varchar(50),
  "contact_phone1" varchar(50),
  "contact_phone2" varchar(50),
  "contact_messenger1" varchar(50),
  "contact_messenger2" varchar(50),
  "is_operational" boolean not null default true,
  "creation_date" timestamp not null default now(),
  "last_updated" timestamp not null default now(),
  "notes" text,
  "display_order_index" integer not null default 4,
  primary key ("record_id")
);

create table "virtual_data_centers" (
  "virtual_data_center_id" serial not null,
  "virtual_data_center_name" varchar(50) not null,
  "virtual_data_center_description" varchar(50),
  "creation_date" timestamp not null default now(),
  "display_order_index" integer not null default 0,
  primary key ("virtual_data_center_id")
);

create table "visibilities" (
  "visibility_id" serial not null,
  "visibility_name" varchar(50),
  "visibility_description" varchar(50),
  "display_order_index" integer not null default 0,
  primary key ("visibility_id")
);

create table "work_streams" (
  "work_stream_id" serial not null,
  "work_stream_name" varchar(50) not null,
  "work_stream_description" varchar(50),
  "project_id" integer not null default 4,
  "record_date" timestamp not null default now(),
  "display_order_index" integer not null,
  primary key ("work_stream_id")
);

alter table "rel_closed_progress_reports_tasks" add constraint "fk_rel_closed_progress_reports_tasks_task_id" foreign key ("task_id") references "tasks" ("task_id") deferrable initially deferred;
alter table "rel_progress_reports_tasks" add constraint "fk_rel_progress_reports_tasks_task_id" foreign key ("task_id") references "tasks" ("task_id") deferrable initially deferred;
alter table "provisioning_project_details" add constraint "fk_provisioning_project_details_provisioning_project_id" foreign key ("provisioning_project_id") references "provisioning_projects" ("provisioning_project_id") deferrable initially deferred;
alter table "tasks" add constraint "fk_tasks_budget_status_kpi" foreign key ("budget_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "tasks" add constraint "fk_tasks_effort_and_dedication_status_kpi" foreign key ("effort_and_dedication_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "tasks" add constraint "fk_tasks_execution_status_kpi" foreign key ("execution_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "tasks" add constraint "fk_tasks_global_status_kpi" foreign key ("global_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "tasks" add constraint "fk_tasks_resources_status_kpi" foreign key ("resources_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "tasks" add constraint "fk_tasks_risk_status_kpi" foreign key ("risk_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_risk_status_id" foreign key ("risk_status_id") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "issues" add constraint "fk_issues_severity_status_kpi" foreign key ("severity_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "provisioning_project_details" add constraint "fk_provisioning_project_details_effort_and_dedication_status_kp" foreign key ("effort_and_dedication_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "provisioning_project_details" add constraint "fk_provisioning_project_details_risk_status_kpi" foreign key ("risk_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "rel_closed_progress_reports_issues" add constraint "fk_rel_closed_progress_reports_issues_severity_status_kpi" foreign key ("severity_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "projects" add constraint "fk_projects_execution_status_kpi" foreign key ("execution_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "projects" add constraint "fk_projects_global_status_kpi" foreign key ("global_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "projects" add constraint "fk_projects_resources_status_kpi" foreign key ("resources_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "projects" add constraint "fk_projects_risk_status_kpi" foreign key ("risk_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "projects" add constraint "fk_projects_scope_status_kpi" foreign key ("scope_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "rel_closed_progress_reports_tasks" add constraint "fk_rel_closed_progress_reports_tasks_global_status_kpi" foreign key ("global_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "rel_closed_progress_reports_tasks" add constraint "fk_rel_closed_progress_reports_tasks_resources_status_kpi" foreign key ("resources_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "rel_closed_progress_reports_tasks" add constraint "fk_rel_closed_progress_reports_tasks_risk_status_kpi" foreign key ("risk_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "rel_closed_progress_reports_tasks" add constraint "fk_rel_closed_progress_reports_tasks_scope_status_kpi" foreign key ("scope_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "projects" add constraint "fk_projects_budget_status_kpi" foreign key ("budget_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "projects" add constraint "fk_projects_effort_and_dedication_status_kpi" foreign key ("effort_and_dedication_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "repairs" add constraint "fk_repairs_resources_status_kpi" foreign key ("resources_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "repairs" add constraint "fk_repairs_risk_status_kpi" foreign key ("risk_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "repairs" add constraint "fk_repairs_scope_status_kpi" foreign key ("scope_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "rel_closed_progress_reports_tasks" add constraint "fk_rel_closed_progress_reports_tasks_budget_status_kpi" foreign key ("budget_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "rel_closed_progress_reports_tasks" add constraint "fk_rel_closed_progress_reports_tasks_effort_and_dedication_stat" foreign key ("effort_and_dedication_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "rel_closed_progress_reports_tasks" add constraint "fk_rel_closed_progress_reports_tasks_execution_status_kpi" foreign key ("execution_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "provisioning_projects" add constraint "fk_provisioning_projects_risk_status_kpi" foreign key ("risk_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "provisioning_projects" add constraint "fk_provisioning_projects_scope_status_kpi" foreign key ("scope_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "repairs" add constraint "fk_repairs_budget_status_kpi" foreign key ("budget_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "repairs" add constraint "fk_repairs_effort_and_dedication_status_kpi" foreign key ("effort_and_dedication_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "repairs" add constraint "fk_repairs_execution_status_kpi" foreign key ("execution_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "repairs" add constraint "fk_repairs_global_status_kpi" foreign key ("global_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "tasks" add constraint "fk_tasks_scope_status_kpi" foreign key ("scope_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "provisioning_projects" add constraint "fk_provisioning_projects_budget_status_kpi" foreign key ("budget_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "provisioning_projects" add constraint "fk_provisioning_projects_effort_and_dedication_status_kpi" foreign key ("effort_and_dedication_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "provisioning_projects" add constraint "fk_provisioning_projects_execution_status_kpi" foreign key ("execution_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "provisioning_projects" add constraint "fk_provisioning_projects_global_status_kpi" foreign key ("global_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "provisioning_projects" add constraint "fk_provisioning_projects_resources_status_kpi" foreign key ("resources_status_kpi") references "kpi_status" ("status_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_major_patch_level_id" foreign key ("major_patch_level_id") references "major_patch_levels" ("major_patch_level_id") deferrable initially deferred;
alter table "tasks" add constraint "fk_tasks_work_stream_id" foreign key ("work_stream_id") references "work_streams" ("work_stream_id") deferrable initially deferred;
alter table "projects" add constraint "fk_projects_global_maturity_evaluation_id" foreign key ("global_maturity_evaluation_id") references "maturity_status" ("maturity_status_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_admin_vlan_id" foreign key ("admin_vlan_id") references "networks" ("network_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_service_vlan_id" foreign key ("service_vlan_id") references "networks" ("network_id") deferrable initially deferred;
alter table "tasks" add constraint "fk_tasks_updater_team_id" foreign key ("updater_team_id") references "teams" ("team_id") deferrable initially deferred;
alter table "issues" add constraint "fk_issues_owner_team_id" foreign key ("owner_team_id") references "teams" ("team_id") deferrable initially deferred;
alter table "progress_reports" add constraint "fk_progress_reports_team_id" foreign key ("team_id") references "teams" ("team_id") deferrable initially deferred;
alter table "updaters" add constraint "fk_updaters_team_id" foreign key ("team_id") references "teams" ("team_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_virtual_data_center_id" foreign key ("virtual_data_center_id") references "virtual_data_centers" ("virtual_data_center_id") deferrable initially deferred;
alter table "tasks" add constraint "fk_tasks_project_id" foreign key ("project_id") references "projects" ("project_id") deferrable initially deferred;
alter table "provisioning_projects" add constraint "fk_provisioning_projects_project_id" foreign key ("project_id") references "projects" ("project_id") deferrable initially deferred;
alter table "work_streams" add constraint "fk_work_streams_project_id" foreign key ("project_id") references "projects" ("project_id") deferrable initially deferred;
alter table "issues" add constraint "fk_issues_project_id" foreign key ("project_id") references "projects" ("project_id") deferrable initially deferred;
alter table "rel_projects_environments" add constraint "fk_rel_projects_environments_project_id" foreign key ("project_id") references "projects" ("project_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_main_project_id" foreign key ("main_project_id") references "projects" ("project_id") deferrable initially deferred;
alter table "rel_projects_nodes" add constraint "fk_rel_projects_nodes_project_id" foreign key ("project_id") references "projects" ("project_id") deferrable initially deferred;
alter table "progress_reports" add constraint "fk_progress_reports_project_id" foreign key ("project_id") references "projects" ("project_id") deferrable initially deferred;
alter table "tasks" add constraint "fk_tasks_visibility_id" foreign key ("visibility_id") references "visibilities" ("visibility_id") deferrable initially deferred;
alter table "provisioning_projects" add constraint "fk_provisioning_projects_visibility_id" foreign key ("visibility_id") references "visibilities" ("visibility_id") deferrable initially deferred;
alter table "repairs" add constraint "fk_repairs_visibility_id" foreign key ("visibility_id") references "visibilities" ("visibility_id") deferrable initially deferred;
alter table "rel_closed_progress_reports_tasks" add constraint "fk_rel_closed_progress_reports_tasks_visibility_id" foreign key ("visibility_id") references "visibilities" ("visibility_id") deferrable initially deferred;
alter table "projects" add constraint "fk_projects_visibility_id" foreign key ("visibility_id") references "visibilities" ("visibility_id") deferrable initially deferred;
alter table "rel_progress_reports_issues" add constraint "fk_rel_progress_reports_issues_issue_id" foreign key ("issue_id") references "issues" ("issue_id") deferrable initially deferred;
alter table "rel_closed_progress_reports_issues" add constraint "fk_rel_closed_progress_reports_issues_issue_id" foreign key ("issue_id") references "issues" ("issue_id") deferrable initially deferred;
alter table "repairs" add constraint "fk_repairs_work_flow_status_id" foreign key ("work_flow_status_id") references "repair_workflow_status" ("status_id") deferrable initially deferred;
alter table "projects" add constraint "fk_projects_project_status_id" foreign key ("project_status_id") references "project_status" ("status_id") deferrable initially deferred;
alter table "repairs" add constraint "fk_repairs_node_id" foreign key ("node_id") references "nodes" ("node_id") deferrable initially deferred;
alter table "rel_nodes_environments" add constraint "fk_rel_nodes_environments_node_id" foreign key ("node_id") references "nodes" ("node_id") deferrable initially deferred;
alter table "rel_nodes_roles" add constraint "fk_rel_nodes_roles_node_id" foreign key ("node_id") references "nodes" ("node_id") deferrable initially deferred;
alter table "provisioning_project_details" add constraint "fk_provisioning_project_details_node_id" foreign key ("node_id") references "nodes" ("node_id") deferrable initially deferred;
alter table "rel_projects_nodes" add constraint "fk_rel_projects_nodes_node_id" foreign key ("node_id") references "nodes" ("node_id") deferrable initially deferred;
alter table "rel_nodes_nodes" add constraint "fk_rel_nodes_nodes_node_id" foreign key ("node_id") references "nodes" ("node_id") deferrable initially deferred;
alter table "rel_nodes_nodes" add constraint "fk_rel_nodes_nodes_related_node_id" foreign key ("related_node_id") references "nodes" ("node_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_rack_location_id" foreign key ("rack_location_id") references "rack_locations" ("rack_location_id") deferrable initially deferred;
alter table "tasks" add constraint "fk_tasks_relationship_type_id" foreign key ("relationship_type_id") references "relationship_type" ("relationship_type_id") deferrable initially deferred;
alter table "issues" add constraint "fk_issues_relationship_type_id" foreign key ("relationship_type_id") references "relationship_type" ("relationship_type_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_node_status_id" foreign key ("node_status_id") references "node_status" ("status_id") deferrable initially deferred;
alter table "issues" add constraint "fk_issues_risk_type_id" foreign key ("risk_type_id") references "risk_type" ("risk_type_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_node_type_id" foreign key ("node_type_id") references "node_types" ("node_type_id") deferrable initially deferred;
alter table "rel_nodes_roles" add constraint "fk_rel_nodes_roles_role_id" foreign key ("role_id") references "roles" ("role_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_main_role_id" foreign key ("main_role_id") references "roles" ("role_id") deferrable initially deferred;
alter table "tasks" add constraint "fk_tasks_priority_id" foreign key ("priority_id") references "priorities" ("priority_id") deferrable initially deferred;
alter table "provisioning_projects" add constraint "fk_provisioning_projects_priority_id" foreign key ("priority_id") references "priorities" ("priority_id") deferrable initially deferred;
alter table "repairs" add constraint "fk_repairs_priority_id" foreign key ("priority_id") references "priorities" ("priority_id") deferrable initially deferred;
alter table "rel_closed_progress_reports_tasks" add constraint "fk_rel_closed_progress_reports_tasks_priority_id" foreign key ("priority_id") references "priorities" ("priority_id") deferrable initially deferred;
alter table "projects" add constraint "fk_projects_priority_id" foreign key ("priority_id") references "priorities" ("priority_id") deferrable initially deferred;
alter table "provisioning_project_details" add constraint "fk_provisioning_project_details_priority_id" foreign key ("priority_id") references "priorities" ("priority_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_security_class_id" foreign key ("security_class_id") references "security_class" ("security_class_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_production_scope_id" foreign key ("production_scope_id") references "production_scopes" ("production_scope_id") deferrable initially deferred;
alter table "rel_closed_progress_reports_tasks" add constraint "fk_rel_closed_progress_reports_tasks_progress_report_id" foreign key ("progress_report_id") references "progress_reports" ("progress_report_id") deferrable initially deferred;
alter table "rel_progress_reports_issues" add constraint "fk_rel_progress_reports_issues_progress_report_id" foreign key ("progress_report_id") references "progress_reports" ("progress_report_id") deferrable initially deferred;
alter table "rel_progress_reports_tasks" add constraint "fk_rel_progress_reports_tasks_progress_report_id" foreign key ("progress_report_id") references "progress_reports" ("progress_report_id") deferrable initially deferred;
alter table "rel_closed_progress_reports_issues" add constraint "fk_rel_closed_progress_reports_issues_progress_report_id" foreign key ("progress_report_id") references "progress_reports" ("progress_report_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_current_security_level_id" foreign key ("current_security_level_id") references "security_level" ("security_level_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_required_security_level_id" foreign key ("required_security_level_id") references "security_level" ("security_level_id") deferrable initially deferred;
alter table "projects" add constraint "fk_projects_service_coverage_id" foreign key ("service_coverage_id") references "service_coverage" ("coverage_id") deferrable initially deferred;
alter table "issues" add constraint "fk_issues_action_status_id" foreign key ("action_status_id") references "action_status" ("status_id") deferrable initially deferred;
alter table "rel_closed_progress_reports_issues" add constraint "fk_rel_closed_progress_reports_issues_action_status_id" foreign key ("action_status_id") references "action_status" ("status_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_supplier_id" foreign key ("supplier_id") references "suppliers" ("supplier_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_architecture_type_id" foreign key ("architecture_type_id") references "architecture_types" ("architecture_type_id") deferrable initially deferred;
alter table "cpu_types" add constraint "fk_cpu_types_architecture_type_id" foreign key ("architecture_type_id") references "architecture_types" ("architecture_type_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_system_type_id" foreign key ("system_type_id") references "system_type" ("system_type_id") deferrable initially deferred;
alter table "projects" add constraint "fk_projects_business_area_id" foreign key ("business_area_id") references "business_areas" ("business_area_id") deferrable initially deferred;
alter table "tasks" add constraint "fk_tasks_task_category_id" foreign key ("task_category_id") references "task_categories" ("category_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_cluster_type_id" foreign key ("cluster_type_id") references "cluster_types" ("cluster_type_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_cpu_type_id" foreign key ("cpu_type_id") references "cpu_types" ("cpu_type_id") deferrable initially deferred;
alter table "tasks" add constraint "fk_tasks_updater_id" foreign key ("updater_id") references "updaters" ("user_id") deferrable initially deferred;
alter table "provisioning_projects" add constraint "fk_provisioning_projects_owner_id" foreign key ("owner_id") references "updaters" ("user_id") deferrable initially deferred;
alter table "repairs" add constraint "fk_repairs_owner_id" foreign key ("owner_id") references "updaters" ("user_id") deferrable initially deferred;
alter table "projects" add constraint "fk_projects_service_manager_id" foreign key ("service_manager_id") references "updaters" ("user_id") deferrable initially deferred;
alter table "issues" add constraint "fk_issues_owner_id" foreign key ("owner_id") references "updaters" ("user_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_inventory_updater_id" foreign key ("inventory_updater_id") references "updaters" ("user_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_service_manager_id" foreign key ("service_manager_id") references "updaters" ("user_id") deferrable initially deferred;
alter table "progress_reports" add constraint "fk_progress_reports_owner_id" foreign key ("owner_id") references "updaters" ("user_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_data_center_location_id" foreign key ("data_center_location_id") references "data_center_locations" ("data_center_location_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_delivery_status_id" foreign key ("delivery_status_id") references "delivery_status" ("status_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_main_dns_zone_id" foreign key ("main_dns_zone_id") references "dns_zones" ("dns_zone_id") deferrable initially deferred;
alter table "rel_nodes_environments" add constraint "fk_rel_nodes_environments_environment_id" foreign key ("environment_id") references "environments" ("environment_id") deferrable initially deferred;
alter table "rel_projects_environments" add constraint "fk_rel_projects_environments_environment_id" foreign key ("environment_id") references "environments" ("environment_id") deferrable initially deferred;
alter table "nodes" add constraint "fk_nodes_main_environment_id" foreign key ("main_environment_id") references "environments" ("environment_id") deferrable initially deferred;
alter table "tasks" add constraint "fk_tasks_impact_id" foreign key ("impact_id") references "impacts" ("impact_id") deferrable initially deferred;
alter table "provisioning_projects" add constraint "fk_provisioning_projects_impact_id" foreign key ("impact_id") references "impacts" ("impact_id") deferrable initially deferred;
alter table "repairs" add constraint "fk_repairs_impact_id" foreign key ("impact_id") references "impacts" ("impact_id") deferrable initially deferred;
alter table "rel_closed_progress_reports_tasks" add constraint "fk_rel_closed_progress_reports_tasks_impact_id" foreign key ("impact_id") references "impacts" ("impact_id") deferrable initially deferred;
alter table "provisioning_project_details" add constraint "fk_provisioning_project_details_impact_id" foreign key ("impact_id") references "impacts" ("impact_id") deferrable initially deferred;
