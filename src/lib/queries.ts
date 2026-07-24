import { query, queryOne } from "@/lib/db";
import type {
  CountRow,
  IssueRow,
  Lookup,
  NodeDetail,
  NodeSummaryRow,
  ProjectRow,
  TaskRow,
} from "@/lib/types";

/**
 * The Access front end soft-deletes nodes (`TblNodes.NodeIsDeleted`) and every
 * summary query filters on it, so all node reads go through this predicate.
 */
const LIVE_NODES = "n.node_is_deleted = false";

const NODE_JOINS = `
  from nodes n
  join node_types nt on nt.node_type_id = n.node_type_id
  join system_type st on st.system_type_id = n.system_type_id
  join environments e on e.environment_id = n.main_environment_id
  join projects p on p.project_id = n.main_project_id
  join roles r on r.role_id = n.main_role_id
  join node_status ns on ns.status_id = n.node_status_id
  join data_center_locations dc on dc.data_center_location_id = n.data_center_location_id
  join suppliers s on s.supplier_id = n.supplier_id
`;

const NODE_SUMMARY_COLUMNS = `
  n.node_id, n.node_name, n.node_description, n.node_serial_number, n.node_model,
  n.node_is_active, n.service_ip, n.assigned_system_cores, n.assigned_system_memory,
  nt.node_type_name as node_type, st.system_type_name as system_type,
  e.environment_name as environment, p.project_name as project, r.role_name as role,
  ns.status_name as node_status, dc.data_center_location_name as data_center,
  s.supplier_name as supplier
`;

export type NodeFilters = {
  search?: string;
  environmentId?: number;
  projectId?: number;
  roleId?: number;
  statusId?: number;
  nodeTypeId?: number;
  activeOnly?: boolean;
};

function nodeFilterClauses(filters: NodeFilters) {
  const clauses: string[] = [LIVE_NODES];
  const params: unknown[] = [];
  if (filters.search) {
    params.push(`%${filters.search}%`);
    clauses.push(
      `(n.node_name ilike $${params.length} or n.node_serial_number ilike $${params.length}
        or n.service_ip ilike $${params.length} or n.node_model ilike $${params.length})`,
    );
  }
  const eq = (column: string, value?: number) => {
    if (value === undefined || Number.isNaN(value)) return;
    params.push(value);
    clauses.push(`${column} = $${params.length}`);
  };
  eq("n.main_environment_id", filters.environmentId);
  eq("n.main_project_id", filters.projectId);
  eq("n.main_role_id", filters.roleId);
  eq("n.node_status_id", filters.statusId);
  eq("n.node_type_id", filters.nodeTypeId);
  if (filters.activeOnly) clauses.push("n.node_is_active = true");
  return { where: clauses.join(" and "), params };
}

export async function listNodes(filters: NodeFilters = {}) {
  const { where, params } = nodeFilterClauses(filters);
  return query<NodeSummaryRow>(
    `select ${NODE_SUMMARY_COLUMNS} ${NODE_JOINS} where ${where} order by n.node_name`,
    params,
  );
}

export async function getNode(nodeId: number) {
  return queryOne<NodeDetail>(
    `select ${NODE_SUMMARY_COLUMNS},
       n.*,
       dz.dns_zone_name as main_dns_zone,
       sd.domain_name as security_domain,
       ct.cluster_type_name as cluster_type,
       at.architecture_type_name as architecture_type,
       cpu.cpu_type_name as cpu_type,
       mpl.major_patch_level_name as major_patch_level,
       rl.rack_location_name as rack_location,
       vdc.virtual_data_center_name as virtual_data_center,
       ps.production_scope_name as production_scope,
       ds.status_name as delivery_status,
       u.user_full_name as service_manager,
       sc.security_class_name as security_class,
       rsl.security_level_name as required_security_level,
       csl.security_level_name as current_security_level,
       parent.node_name as parent_node
     ${NODE_JOINS}
     join dns_zones dz on dz.dns_zone_id = n.main_dns_zone_id
     join security_domains sd on sd.domain_id = n.security_domain_id
     join cluster_types ct on ct.cluster_type_id = n.cluster_type_id
     join architecture_types at on at.architecture_type_id = n.architecture_type_id
     join cpu_types cpu on cpu.cpu_type_id = n.cpu_type_id
     join major_patch_levels mpl on mpl.major_patch_level_id = n.major_patch_level_id
     join rack_locations rl on rl.rack_location_id = n.rack_location_id
     join virtual_data_centers vdc on vdc.virtual_data_center_id = n.virtual_data_center_id
     join production_scopes ps on ps.production_scope_id = n.production_scope_id
     join delivery_status ds on ds.status_id = n.delivery_status_id
     join updaters u on u.user_id = n.service_manager_id
     join security_class sc on sc.security_class_id = n.security_class_id
     join security_level rsl on rsl.security_level_id = n.required_security_level_id
     join security_level csl on csl.security_level_id = n.current_security_level_id
     left join nodes parent on parent.node_id = n.parent_node_id
     where n.node_id = $1`,
    [nodeId],
  );
}

/** Extra roles/environments attached through the Rel* junction tables. */
export async function getNodeRelations(nodeId: number) {
  const [roles, environments, related] = await Promise.all([
    query<Lookup>(
      `select r.role_id as id, r.role_name as name
         from rel_nodes_roles rn join roles r on r.role_id = rn.role_id
        where rn.node_id = $1 order by r.role_name`,
      [nodeId],
    ),
    query<Lookup>(
      `select e.environment_id as id, e.environment_name as name
         from rel_nodes_environments re join environments e on e.environment_id = re.environment_id
        where re.node_id = $1 order by e.environment_name`,
      [nodeId],
    ),
    query<Lookup & { relationship: string }>(
      `select n.node_id as id, n.node_name as name,
              concat_ws(', ',
                case when rn.hosting then 'hosting' end,
                case when rn.hosted_by then 'hosted by' end,
                case when rn.hosted_together then 'hosted together' end,
                case when rn.supporting then 'supporting' end,
                case when rn.supported_by then 'supported by' end,
                case when rn.coupled_components then 'coupled components' end,
                case when rn.connected_services then 'connected services' end) as relationship
         from rel_nodes_nodes rn
         join nodes n on n.node_id = rn.related_node_id
        where rn.node_id = $1 order by n.node_name`,
      [nodeId],
    ),
  ]);
  return { roles, environments, related };
}

/* ------------------------------------------------------------------ */
/* Dashboard: ports of the Nodes_Summary_* saved queries                */
/* ------------------------------------------------------------------ */

export async function nodeTotals() {
  return queryOne<{ total: number; active: number; inactive: number }>(
    `select count(*)::int as total,
            count(*) filter (where n.node_is_active)::int as active,
            count(*) filter (where not n.node_is_active)::int as inactive
       from nodes n where ${LIVE_NODES}`,
  );
}

const DIMENSIONS = {
  environment: {
    table: "environments d",
    on: "d.environment_id = n.main_environment_id",
    label: "d.environment_name",
  },
  project: {
    table: "projects d",
    on: "d.project_id = n.main_project_id",
    label: "d.project_name",
  },
  role: { table: "roles d", on: "d.role_id = n.main_role_id", label: "d.role_name" },
  status: {
    table: "node_status d",
    on: "d.status_id = n.node_status_id",
    label: "d.status_name",
  },
  type: {
    table: "node_types d",
    on: "d.node_type_id = n.node_type_id",
    label: "d.node_type_name",
  },
  supplier: {
    table: "suppliers d",
    on: "d.supplier_id = n.supplier_id",
    label: "d.supplier_name",
  },
  location: {
    table: "data_center_locations d",
    on: "d.data_center_location_id = n.data_center_location_id",
    label: "d.data_center_location_name",
  },
  systemType: {
    table: "system_type d",
    on: "d.system_type_id = n.system_type_id",
    label: "d.system_type_name",
  },
} as const;

export type NodeDimension = keyof typeof DIMENSIONS;

export async function nodesByDimension(dimension: NodeDimension) {
  const d = DIMENSIONS[dimension];
  return query<CountRow>(
    `select ${d.label} as label, count(n.node_id)::int as total
       from nodes n join ${d.table} on ${d.on}
      where ${LIVE_NODES}
      group by ${d.label}
      having count(n.node_id) > 0
      order by total desc, label`,
  );
}

export async function capacityTotals() {
  return queryOne<{
    assigned_cores: number;
    max_cores: number;
    assigned_memory: number;
    max_memory: number;
    free_slots: number;
  }>(
    `select coalesce(sum(n.assigned_system_cores), 0)::int as assigned_cores,
            coalesce(sum(n.max_system_cores), 0)::int as max_cores,
            coalesce(sum(n.assigned_system_memory), 0)::float as assigned_memory,
            coalesce(sum(n.max_system_memory), 0)::float as max_memory,
            coalesce(sum(greatest(n.max_slots - n.assigned_slots, 0)), 0)::int as free_slots
       from nodes n where ${LIVE_NODES}`,
  );
}

/* ------------------------------------------------------------------ */
/* Portfolio / progress management                                      */
/* ------------------------------------------------------------------ */

export async function listProjects() {
  return query<ProjectRow>(
    `select p.project_id, p.project_name, p.project_cycle_label, p.description, p.is_service,
            p.current_progress, p.global_status_kpi, p.risk_status_kpi, p.execution_status_kpi,
            p.budget_status_kpi, p.scheduled_capex_budget, p.consumed_capex_budget,
            p.scheduled_opex_budget, p.consumed_opex_budget, p.scheduled_delivery_date,
            p.delivery_date,
            ba.business_area_name as business_area,
            u.user_full_name as service_manager,
            pr.priority_name as priority,
            ps.status_name as project_status,
            (select count(*) from nodes n
              where n.main_project_id = p.project_id and n.node_is_deleted = false)::int as node_count,
            (select count(*) from tasks t
              where t.project_id = p.project_id and t.end_date is null)::int as open_task_count
       from projects p
       join business_areas ba on ba.business_area_id = p.business_area_id
       join updaters u on u.user_id = p.service_manager_id
       join priorities pr on pr.priority_id = p.priority_id
       join project_status ps on ps.status_id = p.project_status_id
      order by p.project_name`,
  );
}

export async function getProject(projectId: number) {
  const rows = await listProjects();
  return rows.find((row) => row.project_id === projectId) ?? null;
}

/** Port of Tasks_OpenedButPending / _TasksBasicList. */
export async function listTasks(options: { openOnly?: boolean; projectId?: number } = {}) {
  const clauses: string[] = [];
  const params: unknown[] = [];
  if (options.openOnly) clauses.push("t.end_date is null");
  if (options.projectId !== undefined) {
    params.push(options.projectId);
    clauses.push(`t.project_id = $${params.length}`);
  }
  const where = clauses.length ? `where ${clauses.join(" and ")}` : "";
  return query<TaskRow>(
    `select t.task_id, t.task_name, t.description, t.current_progress, t.is_blocked, t.is_freezed,
            t.start_date, t.scheduled_end_date, t.end_date, t.rescheduling_count,
            t.global_status_kpi, t.work_time,
            p.project_name as project,
            ws.work_stream_name as work_stream,
            tc.category_name as category,
            pr.priority_name as priority,
            im.impact_name as impact,
            u.user_full_name as updater,
            tm.team_name as team
       from tasks t
       join projects p on p.project_id = t.project_id
       join work_streams ws on ws.work_stream_id = t.work_stream_id
       join task_categories tc on tc.category_id = t.task_category_id
       join priorities pr on pr.priority_id = t.priority_id
       join impacts im on im.impact_id = t.impact_id
       join updaters u on u.user_id = t.updater_id
       join teams tm on tm.team_id = t.updater_team_id
       ${where}
      order by t.scheduled_end_date`,
    params,
  );
}

/** Port of _IssuesBasicList: issues and risks share one table, split by IsARisk. */
export async function listIssues(options: { risksOnly?: boolean; openOnly?: boolean } = {}) {
  const clauses = ["i.is_deleted = false"];
  if (options.risksOnly) clauses.push("i.is_a_risk = true");
  if (options.openOnly) clauses.push("i.resolution_date is null");
  return query<IssueRow>(
    `select i.issue_id, i.description, i.is_active, i.is_a_risk, i.action_description,
            i.occurence_probability, i.severity_status_kpi, i.creation_date, i.resolution_date,
            p.project_name as project,
            u.user_full_name as owner,
            tm.team_name as owner_team,
            rt.risk_type_name as risk_type,
            a.status_name as action_status
       from issues i
       join projects p on p.project_id = i.project_id
       join updaters u on u.user_id = i.owner_id
       join teams tm on tm.team_id = i.owner_team_id
       join risk_type rt on rt.risk_type_id = i.risk_type_id
       join action_status a on a.status_id = i.action_status_id
      where ${clauses.join(" and ")}
      order by i.severity_status_kpi desc, i.creation_date desc`,
  );
}

/* ------------------------------------------------------------------ */
/* Lookups (the Access "_EntityData_*" forms)                           */
/* ------------------------------------------------------------------ */

export type LookupName =
  | "environments"
  | "projects"
  | "roles"
  | "node_status"
  | "node_types"
  | "system_type"
  | "suppliers"
  | "data_center_locations"
  | "rack_locations"
  | "virtual_data_centers"
  | "dns_zones"
  | "security_domains"
  | "security_class"
  | "security_level"
  | "production_scopes"
  | "cluster_types"
  | "architecture_types"
  | "cpu_types"
  | "major_patch_levels"
  | "delivery_status"
  | "updaters"
  | "teams"
  | "business_areas"
  | "priorities"
  | "impacts"
  | "visibilities"
  | "work_streams"
  | "task_categories"
  | "risk_type"
  | "action_status"
  | "kpi_status"
  | "networks"
  | "nodes";

const LOOKUP_COLUMNS: Record<LookupName, { id: string; name: string }> = {
  environments: { id: "environment_id", name: "environment_name" },
  projects: { id: "project_id", name: "project_name" },
  roles: { id: "role_id", name: "role_name" },
  node_status: { id: "status_id", name: "status_name" },
  node_types: { id: "node_type_id", name: "node_type_name" },
  system_type: { id: "system_type_id", name: "system_type_name" },
  suppliers: { id: "supplier_id", name: "supplier_name" },
  data_center_locations: { id: "data_center_location_id", name: "data_center_location_name" },
  rack_locations: { id: "rack_location_id", name: "rack_location_name" },
  virtual_data_centers: { id: "virtual_data_center_id", name: "virtual_data_center_name" },
  dns_zones: { id: "dns_zone_id", name: "dns_zone_name" },
  security_domains: { id: "domain_id", name: "domain_name" },
  security_class: { id: "security_class_id", name: "security_class_name" },
  security_level: { id: "security_level_id", name: "security_level_name" },
  production_scopes: { id: "production_scope_id", name: "production_scope_name" },
  cluster_types: { id: "cluster_type_id", name: "cluster_type_name" },
  architecture_types: { id: "architecture_type_id", name: "architecture_type_name" },
  cpu_types: { id: "cpu_type_id", name: "cpu_type_name" },
  major_patch_levels: { id: "major_patch_level_id", name: "major_patch_level_name" },
  delivery_status: { id: "status_id", name: "status_name" },
  updaters: { id: "user_id", name: "user_full_name" },
  teams: { id: "team_id", name: "team_name" },
  business_areas: { id: "business_area_id", name: "business_area_name" },
  priorities: { id: "priority_id", name: "priority_name" },
  impacts: { id: "impact_id", name: "impact_name" },
  visibilities: { id: "visibility_id", name: "visibility_name" },
  work_streams: { id: "work_stream_id", name: "work_stream_name" },
  task_categories: { id: "category_id", name: "category_name" },
  risk_type: { id: "risk_type_id", name: "risk_type_name" },
  action_status: { id: "status_id", name: "status_name" },
  kpi_status: { id: "status_id", name: "status_name" },
  networks: { id: "network_id", name: "network_name" },
  nodes: { id: "node_id", name: "node_name" },
};

export const LOOKUP_NAMES = (Object.keys(LOOKUP_COLUMNS) as LookupName[]).filter(
  (name) => name !== "nodes",
);

export async function getLookup(name: LookupName) {
  const columns = LOOKUP_COLUMNS[name];
  const where = name === "nodes" ? "where node_is_deleted = false" : "";
  return query<Lookup>(
    `select ${columns.id} as id, ${columns.name} as name from ${name} ${where} order by ${columns.name}`,
  );
}

export async function getLookups<T extends LookupName>(names: readonly T[]) {
  const results = await Promise.all(names.map((name) => getLookup(name)));
  return Object.fromEntries(names.map((name, index) => [name, results[index]])) as Record<
    T,
    Lookup[]
  >;
}
