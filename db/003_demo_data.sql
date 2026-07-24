-- Synthetic demo data.
-- The original OpenSLIM backup ships a complete set of reference/lookup values but only
-- placeholder rows ("Unknown", "N/A", ...) for the operational tables, so this file adds a
-- small fictional estate to make the rebuilt UI explorable. It is NOT part of the original
-- database; load 001 + 002 only if you want the untouched upstream content.

begin;
set constraints all deferred;

insert into teams (team_id, team_name, team_description) values
  (100, 'Platform Engineering', 'Compute, storage and virtualisation'),
  (101, 'Network & Security', 'Networking, firewalls and security operations'),
  (102, 'Service Management', 'Service delivery and vendor management');

insert into updaters (user_id, user_full_name, team_id, role_name, contact_e_mail1, is_operational) values
  (100, 'Ada Okafor', 100, 'Infrastructure Lead', 'ada.okafor@example.com', true),
  (101, 'Bruno Lindqvist', 100, 'Systems Engineer', 'bruno.lindqvist@example.com', true),
  (102, 'Chen Wei', 101, 'Network Engineer', 'chen.wei@example.com', true),
  (103, 'Dara Mensah', 102, 'Service Manager', 'dara.mensah@example.com', true);

insert into business_areas (business_area_id, business_area_name, business_area_description) values
  (100, 'Retail Banking', 'Customer facing banking services'),
  (101, 'Payments', 'Card and transfer processing'),
  (102, 'Corporate IT', 'Internal platforms');

insert into data_center_locations (data_center_location_id, data_center_location_name, data_center_location_description) values
  (100, 'DC1 Frankfurt', 'Primary data centre'),
  (101, 'DC2 Dublin', 'Secondary / DR data centre');

insert into virtual_data_centers (virtual_data_center_id, virtual_data_center_name, virtual_data_center_description) values
  (100, 'VDC-CORE', 'Core virtualisation cluster'),
  (101, 'VDC-EDGE', 'Edge virtualisation cluster');

insert into dns_zones (dns_zone_id, dns_zone_name, dns_zone_description) values
  (100, 'corp.example.com', 'Corporate zone'),
  (101, 'dmz.example.com', 'DMZ zone');

insert into security_domains (domain_id, domain_name, domain_description) values
  (100, 'CORP', 'Corporate Windows domain'),
  (101, 'DMZ', 'Isolated DMZ domain');

insert into production_scopes (production_scope_id, production_scope_name, production_scope_description) values
  (100, 'Business critical', '24x7 revenue impacting'),
  (101, 'Business support', 'Office hours');

insert into roles (role_id, role_name, role_description) values
  (100, 'Web front end', 'HTTP entry point'),
  (101, 'Application server', 'Business logic tier'),
  (102, 'Database server', 'Relational data tier'),
  (103, 'Message broker', 'Async messaging'),
  (104, 'Hypervisor', 'Virtualisation host'),
  (105, 'Backup server', 'Backup and restore');

insert into projects (project_id, project_name, project_cycle_label, description, business_area_id,
                      service_manager_id, priority_id, project_status_id, current_progress,
                      is_service, scheduled_capex_budget, consumed_capex_budget,
                      scheduled_opex_budget, consumed_opex_budget, global_status_kpi,
                      risk_status_kpi, execution_status_kpi, budget_status_kpi,
                      scheduled_delivery_date, parent_project_id, project_goals) values
  (100, 'Core Banking Platform', 'FY10-Q2', 'Primary retail banking application estate', 100, 103, 6, 9, 82, true,
   1200000, 940000, 350000, 210000, 5, 6, 5, 5, '2010-09-30', 6, 'Keep the retail banking estate at 99.95% availability'),
  (101, 'Payments Gateway', 'FY10-Q2', 'Card authorisation and settlement gateway', 101, 100, 8, 7, 47, false,
   800000, 520000, 180000, 96000, 6, 7, 6, 6, '2010-12-15', 6, 'Deliver PCI compliant gateway'),
  (102, 'Virtualisation Programme', 'FY10-Q3', 'Consolidate physical servers onto VMware', 102, 101, 6, 6, 25, false,
   450000, 96000, 120000, 34000, 6, 6, 7, 5, '2011-03-31', 6, 'Reduce physical footprint by 40%'),
  (103, 'DR Site Refresh', 'FY10-Q4', 'Rebuild the Dublin disaster recovery site', 102, 102, 5, 5, 8, false,
   600000, 25000, 90000, 8000, 7, 8, 7, 6, '2011-06-30', 6, 'Achieve 4h RTO for tier-1 services');

insert into work_streams (work_stream_id, work_stream_name, work_stream_description, project_id, display_order_index) values
  (100, 'Build & deploy', 'Provisioning and deployment work', 100, 1),
  (101, 'Operations', 'Run and maintain', 100, 2),
  (102, 'Compliance', 'PCI and audit work', 101, 3),
  (103, 'Migration', 'P2V migration waves', 102, 4),
  (104, 'Design', 'Architecture and planning', 103, 5);

insert into nodes (node_name, node_description, node_serial_number, node_model, node_is_deleted,
                   node_is_active, main_dns_zone_id, security_domain_id, parent_node_id,
                   node_type_id, system_type_id, major_patch_level_id, supplier_id,
                   cluster_type_id, architecture_type_id, cpu_type_id,
                   assigned_system_cores, max_system_cores, assigned_system_memory, max_system_memory,
                   assigned_nic_ports, max_nic_ports, assigned_slots, max_slots,
                   main_project_id, main_environment_id, main_role_id,
                   data_center_location_id, virtual_data_center_id, rack_location_id,
                   service_ip, admin_ip, node_status_id, delivery_status_id, service_manager_id,
                   production_scope_id, security_class_id, required_security_level_id,
                   current_security_level_id, has_internal_storage, has_san_storage,
                   data_center_is_operational, hardware_is_operational, networks_are_operational,
                   dns_is_operational, operating_system_is_operational, services_are_operational,
                   storage_is_operational, backup_is_operational, monitoring_is_operational,
                   node_delivery_date, notes)
values
  ('fra-web-01', 'Retail banking web front end', 'SN-FRA-0001', 'ProLiant DL380 G6', false, true, 101, 101, 34, 4, 20, 27, 5, 2, 4, 12, 8, 8, 32, 64, 4, 4, 0, 2, 100, 4, 100, 100, 1, 3, '10.20.1.11', '10.99.1.11', 3, 10, 100, 100, 6, 7, 7, true, false, true, true, true, true, true, true, true, true, true, '2009-11-02', 'Behind the F5 load balancer pair.'),
  ('fra-web-02', 'Retail banking web front end', 'SN-FRA-0002', 'ProLiant DL380 G6', false, true, 101, 101, 34, 4, 20, 27, 5, 2, 4, 12, 8, 8, 32, 64, 4, 4, 0, 2, 100, 4, 100, 100, 1, 3, '10.20.1.12', '10.99.1.12', 3, 10, 100, 100, 6, 7, 7, true, false, true, true, true, true, true, true, true, true, true, '2009-11-02', null),
  ('fra-app-01', 'Core banking application server', 'SN-FRA-0011', 'System x3650 M2', false, true, 100, 100, 34, 4, 15, 25, 4, 2, 4, 13, 16, 16, 96, 128, 4, 6, 0, 4, 100, 4, 101, 100, 1, 4, '10.20.2.11', '10.99.2.11', 3, 10, 100, 100, 6, 8, 7, true, true, true, true, true, true, true, true, true, true, true, '2009-11-20', null),
  ('fra-app-02', 'Core banking application server', 'SN-FRA-0012', 'System x3650 M2', false, true, 100, 100, 34, 4, 15, 25, 4, 2, 4, 13, 16, 16, 96, 128, 4, 6, 0, 4, 100, 4, 101, 100, 1, 4, '10.20.2.12', '10.99.2.12', 3, 10, 100, 100, 6, 8, 7, true, true, true, true, true, true, true, true, true, true, true, '2009-11-20', null),
  ('fra-db-01', 'Core banking primary database', 'SN-FRA-0021', 'Sun Fire T5240', false, true, 100, 100, 34, 4, 10, 24, 3, 6, 6, 7, 32, 32, 256, 256, 4, 8, 0, 4, 100, 4, 102, 100, 1, 4, '10.20.3.11', '10.99.3.11', 3, 10, 100, 100, 8, 9, 8, true, true, true, true, true, true, true, true, true, true, true, '2009-08-14', 'Sun Cluster primary node.'),
  ('fra-db-02', 'Core banking standby database', 'SN-FRA-0022', 'Sun Fire T5240', false, true, 100, 100, 34, 4, 10, 24, 3, 6, 6, 7, 32, 32, 256, 256, 4, 8, 0, 4, 100, 4, 102, 100, 1, 4, '10.20.3.12', '10.99.3.12', 3, 10, 100, 100, 8, 9, 8, true, true, true, true, true, true, true, true, true, true, true, '2009-08-14', 'Sun Cluster standby node.'),
  ('fra-mq-01', 'Message broker', 'SN-FRA-0031', 'System p550', false, true, 100, 100, 34, 4, 13, 36, 4, 7, 7, 9, 8, 12, 48, 64, 2, 4, 0, 4, 100, 4, 103, 100, 1, 4, '10.20.4.11', '10.99.4.11', 3, 10, 101, 100, 6, 7, 6, true, true, true, true, true, true, true, true, true, true, false, '2009-06-01', 'Monitoring agent pending upgrade.'),
  ('fra-esx-01', 'VMware hypervisor host', 'SN-FRA-0041', 'ProLiant BL460c G6', false, true, 100, 100, 34, 5, 26, 24, 5, 13, 4, 12, 24, 24, 192, 192, 6, 6, 0, 0, 102, 4, 104, 100, 100, 4, '10.20.5.11', '10.99.5.11', 3, 10, 101, 100, 6, 7, 7, true, true, true, true, true, true, true, true, true, true, true, '2010-02-10', null),
  ('fra-esx-02', 'VMware hypervisor host', 'SN-FRA-0042', 'ProLiant BL460c G6', false, true, 100, 100, 34, 5, 26, 24, 5, 13, 4, 12, 24, 24, 192, 192, 6, 6, 0, 0, 102, 4, 104, 100, 100, 4, '10.20.5.12', '10.99.5.12', 3, 10, 101, 100, 6, 7, 7, true, true, true, true, true, true, true, true, true, true, true, '2010-02-10', null),
  ('fra-pay-01', 'Payment gateway node', 'SN-FRA-0051', 'ProLiant DL360 G6', false, true, 101, 101, 34, 4, 21, 26, 5, 2, 4, 13, 8, 8, 32, 32, 4, 4, 0, 2, 101, 4, 101, 100, 1, 7, '10.30.1.11', '10.99.6.11', 3, 10, 100, 100, 8, 9, 7, true, false, true, true, true, true, true, true, false, true, true, '2010-04-05', 'PCI scope — quarterly ASV scan required.'),
  ('fra-pay-02', 'Payment gateway node', 'SN-FRA-0052', 'ProLiant DL360 G6', false, true, 101, 101, 34, 4, 21, 26, 5, 2, 4, 13, 8, 8, 32, 32, 4, 4, 0, 2, 101, 5, 101, 100, 1, 7, '10.30.1.12', '10.99.6.12', 3, 9, 100, 100, 8, 9, 7, true, false, true, true, true, true, true, false, false, false, false, '2010-05-18', 'Awaiting final security hardening.'),
  ('fra-bkp-01', 'Backup master server', 'SN-FRA-0061', 'System x3650 M3', false, true, 100, 100, 34, 4, 15, 25, 4, 2, 4, 13, 8, 16, 48, 96, 4, 6, 0, 4, 102, 4, 105, 100, 1, 8, '10.20.9.11', '10.99.9.11', 3, 10, 101, 101, 6, 6, 6, true, true, true, true, true, true, true, true, true, true, true, '2009-03-11', null),
  ('dub-web-01', 'DR web front end', 'SN-DUB-0001', 'ProLiant DL380 G6', false, true, 101, 101, 34, 4, 20, 27, 5, 2, 4, 12, 8, 8, 32, 64, 4, 4, 0, 2, 103, 6, 100, 101, 1, 6, '10.40.1.11', '10.98.1.11', 8, 7, 102, 101, 6, 6, 5, true, false, true, true, true, true, true, false, false, false, false, '2010-06-21', 'Powered off outside DR tests.'),
  ('dub-db-01', 'DR database node', 'SN-DUB-0011', 'Sun Fire T5240', false, true, 100, 100, 34, 4, 10, 24, 3, 6, 6, 7, 32, 32, 256, 256, 4, 8, 0, 4, 103, 6, 102, 101, 1, 6, '10.40.3.11', '10.98.3.11', 8, 7, 102, 101, 8, 9, 6, true, true, true, true, true, true, true, false, true, false, false, '2010-06-21', 'Log shipping target.'),
  ('fra-dev-01', 'Shared development VM', 'SN-VM-0001', 'VMware Virtual Platform', false, true, 100, 100, 34, 6, 15, 25, 11, 2, 4, 13, 4, 4, 16, 16, 2, 2, 0, 0, 102, 8, 101, 100, 100, 4, '10.60.1.11', '10.97.1.11', 3, 10, 101, 101, 5, 5, 5, false, true, true, true, true, true, true, true, true, false, true, '2010-03-02', null),
  ('fra-qa-01', 'QA application VM', 'SN-VM-0002', 'VMware Virtual Platform', false, true, 100, 100, 34, 6, 15, 25, 11, 2, 4, 13, 4, 4, 16, 16, 2, 2, 0, 0, 100, 6, 101, 100, 100, 4, '10.61.1.11', '10.97.2.11', 3, 10, 101, 101, 5, 5, 5, false, true, true, true, true, true, true, true, true, false, true, '2010-03-02', null),
  ('fra-old-01', 'Retired file server', 'SN-FRA-9001', 'ProLiant DL360 G4', true, false, 100, 100, 34, 4, 5, 28, 5, 2, 3, 12, 2, 2, 4, 8, 2, 2, 0, 2, 102, 4, 101, 100, 1, 3, '10.20.8.11', '10.99.8.11', 11, 10, 101, 101, 5, 5, 5, true, false, false, false, false, false, false, false, false, false, false, '2005-01-10', 'Decommissioned in 2010; kept for audit trail.');

insert into rel_nodes_roles (node_id, role_id, notes)
select n.node_id, 105, 'Also runs the backup agent proxy'
  from nodes n where n.node_name in ('fra-db-01', 'fra-app-01');

insert into rel_nodes_environments (node_id, environment_id, notes)
select n.node_id, 7, 'Shared with the integration environment'
  from nodes n where n.node_name = 'fra-qa-01';

insert into rel_nodes_nodes (node_id, related_node_id, hosting, hosted_by, supporting, supported_by, notes)
select h.node_id, g.node_id, true, false, false, false, 'Guest VM'
  from nodes h, nodes g
 where h.node_name = 'fra-esx-01' and g.node_name in ('fra-dev-01', 'fra-qa-01');

insert into tasks (task_name, description, project_id, work_stream_id, priority_id, visibility_id,
                   impact_id, current_progress, is_blocked, is_freezed, updater_id, updater_team_id,
                   start_date, scheduled_end_date, end_date, task_category_id, rescheduling_count,
                   global_status_kpi, risk_status_kpi, execution_status_kpi, work_time,
                   resources_involved, tags) values
  ('Patch app tier to SP2', 'Roll out the quarterly patch bundle to fra-app-0x', 100, 101, 6, 5, 6, 60, false, false, 101, 100, '2010-04-01', '2010-05-15', null, 18, 1, 6, 5, 6, 24, 2, 'patching'),
  ('Rotate service account credentials', 'Rotate the core banking service accounts', 100, 101, 8, 5, 7, 20, true, false, 102, 101, '2010-04-12', '2010-05-01', null, 13, 2, 7, 7, 7, 6, 1, 'security'),
  ('PCI segmentation review', 'Validate the DMZ firewall rule set for the gateway', 101, 102, 8, 5, 7, 40, false, false, 102, 101, '2010-03-20', '2010-06-30', null, 16, 0, 6, 7, 6, 40, 3, 'pci,security'),
  ('P2V wave 1', 'Migrate 12 physical servers onto VDC-CORE', 102, 103, 6, 4, 6, 75, false, false, 101, 100, '2010-02-01', '2010-05-30', null, 15, 1, 5, 5, 5, 120, 4, 'migration'),
  ('P2V wave 2', 'Migrate the remaining application servers', 102, 103, 5, 4, 5, 0, false, true, 101, 100, '2010-06-01', '2010-09-30', null, 15, 0, 6, 6, 6, 0, 4, 'migration'),
  ('DR site low level design', 'Produce the Dublin rack and network design', 103, 104, 6, 5, 6, 30, false, false, 100, 100, '2010-05-01', '2010-08-31', null, 23, 0, 6, 7, 6, 32, 2, 'design'),
  ('Backup catalogue clean up', 'Remove decommissioned nodes from the backup catalogue', 102, 101, 4, 3, 5, 100, false, false, 101, 100, '2010-01-05', '2010-02-05', '2010-02-03', 12, 0, 5, 5, 5, 8, 1, 'housekeeping'),
  ('Replace failed PSU on fra-mq-01', 'Vendor call raised with IBM', 100, 101, 8, 5, 7, 100, false, false, 103, 102, '2010-03-08', '2010-03-12', '2010-03-11', 10, 0, 5, 5, 5, 4, 1, 'incident');

insert into issues (description, is_deleted, is_active, is_a_risk, project_id, owner_id, owner_team_id,
                    risk_type_id, occurence_probability, severity_status_kpi, action_status_id,
                    action_description, creation_date, resolution_date, tags) values
  ('Single points of failure remain in the DMZ switch layer', false, true, true, 101, 102, 101, 9, 0.35, 7,
   10, 'Second switch ordered, install planned for wave 2', '2010-03-02', null, 'network'),
  ('Core banking database licence renewal not budgeted', false, true, true, 100, 103, 102, 13, 0.6, 8,
   9, 'Escalated to the service board for the FY11 budget', '2010-04-18', null, 'budget'),
  ('fra-pay-02 fails the CIS hardening baseline', false, true, false, 101, 102, 101, 10, 0.9, 7,
   10, 'Hardening scripted, awaiting a maintenance window', '2010-05-20', null, 'security,pci'),
  ('Backup window overruns into business hours', false, true, false, 102, 101, 100, 15, null, 6,
   7, 'Staggered schedules deployed, monitoring for two weeks', '2010-02-11', null, 'backup'),
  ('P2V wave 1 lacked a rollback plan', false, false, false, 102, 101, 100, 16, null, 6,
   5, 'Rollback runbook written and reviewed', '2010-02-20', '2010-03-15', 'migration');

select setval('nodes_node_id_seq', (select max(node_id) from nodes));
select setval('tasks_task_id_seq', (select max(task_id) from tasks));
select setval('issues_issue_id_seq', (select max(issue_id) from issues));
select setval('projects_project_id_seq', (select max(project_id) from projects));
select setval('roles_role_id_seq', (select max(role_id) from roles));
select setval('teams_team_id_seq', (select max(team_id) from teams));
select setval('updaters_user_id_seq', (select max(user_id) from updaters));

commit;
