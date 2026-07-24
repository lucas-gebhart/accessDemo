-- _DecommissioningManagement
SELECT TblDecommissioning.*,TblNodes.NodeIsActive,TblNodes.NodeIsDeleted,TblNodes.NodeStatusId,TblNodes.NodeTypeId,TblNodes.SupplierId,TblNodes.ParentNodeId,TblNodes.InventoryUpdaterId,TblNodes.InventoryLastUpdateDate FROM [TblDecommissioning],[TblNodes] 

-- _GetAllForms
SELECT MsysObjects.Name FROM [MsysObjects] WHERE (((MsysObjects.Type)=-32768) And ((Left(MsysObjects.Name,1))<>"~" And (Left(MsysObjects.Name,1))<>"_") And (Left(MsysObjects.Name,6))<>"Tools_") And (MsysObjects.Name<>"MainMenu") ORDER BY MsysObjects.Name

-- _GetAllQueries
SELECT MsysObjects.Name FROM [MsysObjects] WHERE (((MsysObjects.Type)=5) And ((Left(MsysObjects.Name,1))<>"~" And (Left(MsysObjects.Name,1))<>"_")) ORDER BY MsysObjects.Name

-- _GetAllReports
SELECT MsysObjects.Name FROM [MsysObjects] WHERE (((MsysObjects.Type)=-32764) And ((Left(MsysObjects.Name,1))<>"~" And (Left(MsysObjects.Name,1))<>"_")) ORDER BY MsysObjects.Name

-- _GetAllTools
SELECT MsysObjects.Name FROM [MsysObjects] WHERE (((MsysObjects.Type)=-32768) And (Left(MsysObjects.Name,6))="Tools_") ORDER BY MsysObjects.Name

-- _Import_ForeignCmdbId
SELECT Nodes.CmdbId FROM [] 

-- _IssuesBasicList
SELECT  FROM  

-- _NodesBasicList
SELECT  FROM  

-- _ProvisioningProjectDetailsHistoryView
SELECT  FROM  

-- _QueryAllNodes
SELECT TblNodes.NodeId,TblNodes.NodeName,TblNodes.ResponsibilityDegree,TblProjects.ProjectName,TblEnvironments.EnvironmentName,TblRoles.RoleName,TblClusterTypes.ClusterTypeName,TblSystemType.SystemTypeName,TblMajorPatchLevels.MajorPatchLevelName,TblCpuTypes.CpuTypeName,TblNodes.ServiceIP,TblNodes.AdminIP,TblNodes.HardwareAdminIP FROM [TblNodes],[TblEnvironments],[TblRoles],[TblProjects],[TblClusterTypes],[TblSystemType],[TblMajorPatchLevels],[TblCpuTypes] ORDER BY TblProjects.ProjectName

-- _QueryGetProgressReports
SELECT TblProgressReports.ProgressReportId,TblTeams.TeamName,TblProjects.ProjectName FROM [TblProgressReports],[TblTeams],[TblProjects] ORDER BY TblProgressReports.ProgressReportId

-- _QueryRelNodes2Nodes
SELECT TmpRelatedNodes.NodeId,TmpRelatedNodes.RelatedNodeId,TblNodes.NodeName,TmpRelatedNodes.ConnectedServices,TmpRelatedNodes.CoupledComponents,TmpRelatedNodes.HostedTogether,TmpRelatedNodes.HostedBy,TmpRelatedNodes.SupportedBy,TmpRelatedNodes.Hosting,TmpRelatedNodes.Supporting,TmpRelatedNodes.LastUpdateDate FROM [],[TblNodes] 

-- _QueryRelProgressReports2Issues
SELECT RelProgressReports2Issues.ProgressReportId,TblIssues.IssueId,TblIssues.Description,TblIssues.IsARisk,TblIssues.CreationDate,TblIssues.OwnerId,TblIssues.OwnerTeamId,TblIssues.ProjectId,TblIssues.OccurenceProbability,TblIssues.SeverityStatusKPI,TblIssues.ActionStatusId,TblIssues.ResolutionDate,TblIssues.LastUpdateDate FROM [TblIssues],[RelProgressReports2Issues] 

-- _QueryRelProjects2Environments
SELECT RelProjects2Environments.StorageNASGbCapacity,TblEnvironments.EnvironmentName FROM [TblEnvironments],[RelProjects2Environments] WHERE RelProjects2Environments.ProjectId=23 

-- _QueryRelProjects2Nodes
SELECT RelProjects2Nodes.ProjectId,TblProjects.ProjectName FROM [TblProjects],[RelProjects2Nodes] WHERE RelProjects2Nodes.NodeId=[NodeId] 

-- _RepairsManagement
SELECT TblRepairs.*,TblNodes.NodeName,TblNodes.NodeIsDeleted,TblNodes.NodeIsActive,TblNodes.NodeStatusId,TblNodes.MainProjectId,TblNodes.MainEnvironmentId,TblNodes.MainRoleId,TblNodes.MainDnsZoneId,TblNodes.SecurityDomainId,TblNodes.ProductionScopeId,TblNodes.VirtualDataCenterId,TblNodes.InventoryUpdaterId,TblNodes.InventoryLastUpdateDate,AltNodes.NodeIsDeleted,AltNodes.NodeIsActive,AltNodes.NodeStatusId,AltNodes.NodeName,AltNodes.ParentNodeId,AltNodes.MainProjectId,AltNodes.MainEnvironmentId,AltNodes.MainRoleId,AltNodes.MainDnsZoneId,AltNodes.SecurityDomainId,AltNodes.ProductionScopeId,AltNodes.VirtualDataCenterId,AltNodes.NodeTypeId,AltNodes.SupplierId,AltNodes.InventoryUpdaterId,AltNodes.InventoryLastUpdateDate FROM [TblRepairs],[TblNodes],[TblNodes] 

-- _ReportOpenedButPendingTasksList
SELECT Count(RelProgressReports2Tasks.ProgressReportId),TblTasks.TaskId,TblTasks.TaskName,TblTasks.IsBlocked,TblTasks.IsFreezed,TblTasks.CurrentProgress,TblTasks.PriorityId,TblTasks.VisibilityId,TblTasks.ImpactId,TblTasks.UpdaterId,TblTasks.ScheduledEndDate,TblTasks.ReschedulingCount,TblTasks.TaskCategoryId,TblTasks.ProjectId,TblTasks.EndDate,TblTasks.LastUpdateDate FROM [TblTasks],[RelProgressReports2Tasks] WHERE (TblTasks.CurrentProgress<1) ORDER BY TblTasks.ProjectId

-- _ReportRelClosedProgressReports2Tasks
SELECT RelClosedProgressReports2Tasks.ProgressReportId,TblTasks.TaskId,RelClosedProgressReports2Tasks.IsUnplanned,TblTasks.IsBlocked,TblTasks.IsFreezed,RelClosedProgressReports2Tasks.AssignedExecutionOrder,TblTasks.TaskName,TblTasks.CurrentProgress,TblTasks.PriorityId,TblTasks.VisibilityId,TblTasks.ImpactId,TblTasks.UpdaterId,TblTasks.ScheduledEndDate,TblTasks.ReschedulingCount,TblTasks.TaskCategoryId,TblTasks.ProjectId,TblTasks.EndDate,TblTasks.LastUpdateDate FROM [TblTasks],[RelClosedProgressReports2Tasks] WHERE RelClosedProgressReports2Tasks.ProgressReportId=[Progress Report Id] ORDER BY TblTasks.UpdaterId

-- _ReportRelProgressReports2Tasks_TeamMemberTasksList
SELECT RelProgressReports2Tasks.ProgressReportId,TblTasks.TaskId,RelProgressReports2Tasks.IsUnplanned,TblTasks.IsBlocked,TblTasks.IsFreezed,RelProgressReports2Tasks.AssignedExecutionOrder,TblTasks.TaskName,TblTasks.CurrentProgress,TblTasks.PriorityId,TblTasks.VisibilityId,TblTasks.ImpactId,TblUpdaters.UserFullName,TblTasks.ScheduledEndDate,TblTasks.ReschedulingCount,TblTasks.TaskCategoryId,TblTasks.ProjectId,TblTasks.EndDate,TblTasks.LastUpdateDate FROM [TblTasks],[TblUpdaters],[RelProgressReports2Tasks] WHERE RelProgressReports2Tasks.ProgressReportId=[Progress Report Id] And TblUpdaters.UserFullName<>[Exclude Manager Name] ORDER BY TblTasks.UpdaterId

-- _TasksBasicList
SELECT  FROM  

-- ~sq_c_ContactsHistoryView~sq_cTeamId
SELECT TblTeams.TeamId,TblTeams.TeamName,TblTeams.DisplayOrderIndex FROM [TblTeams] ORDER BY TblTeams.DisplayOrderIndex

-- ~sq_c_DecommissioningHistoryView~sq_cExecutionStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_DecommissioningHistoryView~sq_cGlobalStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_DecommissioningHistoryView~sq_cImpactId
SELECT TblImpacts.ImpactId,TblImpacts.ImpactName,TblImpacts.DisplayOrderIndex FROM [TblImpacts] ORDER BY TblImpacts.DisplayOrderIndex

-- ~sq_c_DecommissioningHistoryView~sq_cOwnerId
SELECT TblUpdaters.UserId,TblUpdaters.UserFullName,TblUpdaters.DisplayOrderIndex FROM [TblUpdaters] ORDER BY TblUpdaters.DisplayOrderIndex

-- ~sq_c_DecommissioningHistoryView~sq_cPriorityId
SELECT TblPriorities.PriorityId,TblPriorities.PriorityName,TblPriorities.DisplayOrderIndex FROM [TblPriorities] ORDER BY TblPriorities.DisplayOrderIndex

-- ~sq_c_DecommissioningHistoryView~sq_cRiskStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_DecommissioningHistoryView~sq_cScopeStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_DecommissioningHistoryView~sq_cWorkFlowStatusId
SELECT TblDecommissioningWorkFlowStatus.StatusId,TblDecommissioningWorkFlowStatus.StatusName,TblDecommissioningWorkFlowStatus.DisplayOrderIndex FROM [TblDecommissioningWorkFlowStatus] ORDER BY TblDecommissioningWorkFlowStatus.DisplayOrderIndex

-- ~sq_c_EntityData_WorkStreams~sq_cProjectId
SELECT TblProjects.ProjectId,TblProjects.ProjectName FROM [TblProjects] 

-- ~sq_c_IssuesHistoryView~sq_cActionStatusId
SELECT TblActionStatus.StatusId,TblActionStatus.StatusName,TblActionStatus.DisplayOrderIndex FROM [TblActionStatus] ORDER BY TblActionStatus.DisplayOrderIndex

-- ~sq_c_IssuesHistoryView~sq_cOwnerTeamId
SELECT TblTeams.TeamId,TblTeams.TeamName,TblTeams.DisplayOrderIndex FROM [TblTeams] ORDER BY TblTeams.DisplayOrderIndex

-- ~sq_c_IssuesHistoryView~sq_cProjectId
SELECT TblProjects.ProjectId,TblProjects.ProjectName FROM [TblProjects] 

-- ~sq_c_IssuesHistoryView~sq_cRiskTypeId
SELECT TblRiskType.RiskTypeId,TblRiskType.RiskTypeName,TblRiskType.DisplayOrderIndex FROM [TblRiskType] ORDER BY TblRiskType.DisplayOrderIndex

-- ~sq_c_IssuesHistoryView~sq_cSeverityStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_NodeConfigurationManagement~sq_cArchitecutreTypeId
SELECT TblArchitectureTypes.ArchitectureTypeId,TblArchitectureTypes.ArchitectureTypeName,TblArchitectureTypes.DisplayOrderIndex FROM [TblArchitectureTypes] ORDER BY TblArchitectureTypes.DisplayOrderIndex

-- ~sq_c_NodeConfigurationManagement~sq_cClusterTypeId
SELECT TblClusterTypes.ClusterTypeId,TblClusterTypes.ClusterTypeName,TblClusterTypes.DisplayOrderIndex FROM [TblClusterTypes] ORDER BY TblClusterTypes.DisplayOrderIndex

-- ~sq_c_NodeConfigurationManagement~sq_cDeliveryStatusId
SELECT TblDeliveryStatus.StatusId,TblDeliveryStatus.StatusName,TblDeliveryStatus.DisplayOrderIndex FROM [TblDeliveryStatus] ORDER BY TblDeliveryStatus.DisplayOrderIndex

-- ~sq_c_NodeConfigurationManagement~sq_cHardwareAdminVLANId
SELECT TblNetworks.NetworkId,TblNetworks.NetworkName,TblNetworks.DisplayOrderIndex FROM [TblNetworks] ORDER BY TblNetworks.DisplayOrderIndex

-- ~sq_c_NodeConfigurationManagement~sq_cHardwareStatusId
SELECT TblNodeStatus.StatusId,TblNodeStatus.StatusName,TblNodeStatus.DisplayOrderIndex FROM [TblNodeStatus] ORDER BY TblNodeStatus.DisplayOrderIndex

-- ~sq_c_NodeConfigurationManagement~sq_cInventoryUpdaterId
SELECT TblUpdaters.UserId,TblUpdaters.UserFullName,TblUpdaters.DisplayOrderIndex FROM [TblUpdaters] ORDER BY TblUpdaters.DisplayOrderIndex

-- ~sq_c_NodeConfigurationManagement~sq_cMainEnvironmentId
SELECT TblEnvironments.EnvironmentId,TblEnvironments.EnvironmentName,TblEnvironments.DisplayOrderIndex FROM [TblEnvironments] ORDER BY TblEnvironments.DisplayOrderIndex

-- ~sq_c_NodeConfigurationManagement~sq_cMainRoleId
SELECT TblRoles.RoleId,TblRoles.RoleName,TblRoles.DisplayOrderIndex FROM [TblRoles] ORDER BY TblRoles.DisplayOrderIndex

-- ~sq_c_NodeConfigurationManagement~sq_cNodeTypeId
SELECT TblNodeTypes.NodeTypeId,TblNodeTypes.NodeTypeName,TblNodeTypes.DisplayOrderIndex FROM [TblNodeTypes] ORDER BY TblNodeTypes.DisplayOrderIndex

-- ~sq_c_NodeConfigurationManagement~sq_cParentNodeId
SELECT TblNodes.NodeId,TblNodes.NodeName FROM [TblNodes] 

-- ~sq_c_NodeConfigurationManagement~sq_cServiceManagerId
SELECT TblUpdaters.UserId,TblUpdaters.UserFullName,TblUpdaters.DisplayOrderIndex FROM [TblUpdaters] WHERE TblUpdaters.TeamId IN (1,2,3,4,22,23,24) ORDER BY TblUpdaters.DisplayOrderIndex

-- ~sq_c_NodeConfigurationManagement~sq_cServiceVLANId
SELECT TblNetworks.NetworkId,TblNetworks.NetworkName,TblNetworks.DisplayOrderIndex FROM [TblNetworks] ORDER BY TblNetworks.DisplayOrderIndex

-- ~sq_c_NodeConfigurationManagement~sq_cSupplierId
SELECT TblSuppliers.SupplierId,TblSuppliers.SupplierName,TblSuppliers.DisplayOrderIndex FROM [TblSuppliers] ORDER BY TblSuppliers.DisplayOrderIndex

-- ~sq_c_NodeConfigurationManagement~sq_cSystemTypeId
SELECT TblSystemType.SystemTypeId,TblSystemType.SystemTypeName,TblSystemType.DisplayOrderIndex FROM [TblSystemType] ORDER BY TblSystemType.DisplayOrderIndex

-- ~sq_c_NodeDeliveryManagement~sq_cDeliveryStatusId
SELECT TblDeliveryStatus.StatusId,TblDeliveryStatus.StatusName,TblDeliveryStatus.DisplayOrderIndex FROM [TblDeliveryStatus] ORDER BY TblDeliveryStatus.DisplayOrderIndex

-- ~sq_c_NodeDeliveryManagement~sq_cInventoryUpdaterId
SELECT TblUpdaters.UserId,TblUpdaters.UserFullName,TblUpdaters.DisplayOrderIndex FROM [TblUpdaters] ORDER BY TblUpdaters.DisplayOrderIndex

-- ~sq_c_NodeDeliveryManagement~sq_cMainEnvironmentId
SELECT TblEnvironments.EnvironmentId,TblEnvironments.EnvironmentName,TblEnvironments.DisplayOrderIndex FROM [TblEnvironments] ORDER BY TblEnvironments.DisplayOrderIndex

-- ~sq_c_NodeDeliveryManagement~sq_cMainRoleId
SELECT TblRoles.RoleId,TblRoles.RoleName,TblRoles.DisplayOrderIndex FROM [TblRoles] ORDER BY TblRoles.DisplayOrderIndex

-- ~sq_c_NodeDeliveryManagement~sq_cParentNodeId
SELECT TblNodes.NodeId,TblNodes.NodeName FROM [TblNodes] 

-- ~sq_c_NodeDeliveryManagement~sq_cServiceManagerId
SELECT TblUpdaters.UserId,TblUpdaters.UserFullName,TblUpdaters.DisplayOrderIndex FROM [TblUpdaters] WHERE TblUpdaters.TeamId IN (1,2,3,4,22,23,24) ORDER BY TblUpdaters.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cAdminVLANId
SELECT TblNetworks.NetworkId,TblNetworks.NetworkName,TblNetworks.DisplayOrderIndex FROM [TblNetworks] ORDER BY TblNetworks.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cArchitecutreTypeId
SELECT TblArchitectureTypes.ArchitectureTypeId,TblArchitectureTypes.ArchitectureTypeName,TblArchitectureTypes.DisplayOrderIndex FROM [TblArchitectureTypes] ORDER BY TblArchitectureTypes.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cComboBoxRelNodes2Environments
SELECT TblEnvironments.EnvironmentId,TblEnvironments.EnvironmentName,TblEnvironments.DisplayOrderIndex FROM [TblEnvironments] ORDER BY TblEnvironments.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cComboBoxRelNodes2Roles
SELECT TblRoles.RoleId,TblRoles.RoleName,TblRoles.DisplayOrderIndex FROM [TblRoles] ORDER BY TblRoles.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cCpuTypeId
SELECT TblCpuTypes.CpuTypeId,TblCpuTypes.CpuTypeName,TblCpuTypes.DisplayOrderIndex FROM [TblCpuTypes] ORDER BY TblCpuTypes.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cCurrentSecurityLevelId
SELECT TblSecurityLevel.SecurityLevelId,TblSecurityLevel.SecurityLevelName,TblSecurityLevel.DisplayOrderIndex FROM [TblSecurityLevel] ORDER BY TblSecurityLevel.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cDeliveryStatusId
SELECT TblDeliveryStatus.StatusId,TblDeliveryStatus.StatusName,TblDeliveryStatus.DisplayOrderIndex FROM [TblDeliveryStatus] ORDER BY TblDeliveryStatus.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cHardwareAdminVLANId
SELECT TblNetworks.NetworkId,TblNetworks.NetworkName,TblNetworks.DisplayOrderIndex FROM [TblNetworks] ORDER BY TblNetworks.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cHardwareStatusId
SELECT TblNodeStatus.StatusId,TblNodeStatus.StatusName,TblNodeStatus.DisplayOrderIndex FROM [TblNodeStatus] ORDER BY TblNodeStatus.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cInventoryUpdaterId
SELECT TblUpdaters.UserId,TblUpdaters.UserFullName,TblUpdaters.DisplayOrderIndex FROM [TblUpdaters] ORDER BY TblUpdaters.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cListViewRelNodes2Environments
SELECT RelNodes2Environments.EnvironmentId,TblEnvironments.EnvironmentName FROM [TblEnvironments],[RelNodes2Environments] WHERE RelNodes2Environments.NodeId=34 

-- ~sq_c_NodeHistoryView~sq_cListViewRelProjects2Nodes
SELECT RelProjects2Nodes.ProjectId,TblProjects.ProjectName FROM [TblProjects],[RelProjects2Nodes] WHERE RelProjects2Nodes.NodeId=34 

-- ~sq_c_NodeHistoryView~sq_cMainDnsZoneId
SELECT TblDnsZones.DnsZoneId,TblDnsZones.DnsZoneName,TblDnsZones.DisplayOrderIndex FROM [TblDnsZones] ORDER BY TblDnsZones.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cMainProjectId
SELECT TblProjects.ProjectId,TblProjects.ProjectName FROM [TblProjects] 

-- ~sq_c_NodeHistoryView~sq_cMainRoleId
SELECT TblRoles.RoleId,TblRoles.RoleName,TblRoles.DisplayOrderIndex FROM [TblRoles] ORDER BY TblRoles.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cNodeTypeId
SELECT TblNodeTypes.NodeTypeId,TblNodeTypes.NodeTypeName,TblNodeTypes.DisplayOrderIndex FROM [TblNodeTypes] ORDER BY TblNodeTypes.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cParentNodeId
SELECT TblNodes.NodeId,TblNodes.NodeName FROM [TblNodes] 

-- ~sq_c_NodeHistoryView~sq_cRackLocationId
SELECT TblRackLocations.RackLocationId,TblRackLocations.RackLocationName,TblRackLocations.DisplayOrderIndex FROM [TblRackLocations] ORDER BY TblRackLocations.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cRequiredSecurityLevelId
SELECT TblSecurityLevel.SecurityLevelId,TblSecurityLevel.SecurityLevelName,TblSecurityLevel.DisplayOrderIndex FROM [TblSecurityLevel] ORDER BY TblSecurityLevel.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cRiskStatusId
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cServiceManagerId
SELECT TblUpdaters.UserId,TblUpdaters.UserFullName,TblUpdaters.DisplayOrderIndex FROM [TblUpdaters] WHERE TblUpdaters.TeamId IN (1,2,3,4,22,23,24) ORDER BY TblUpdaters.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cServiceVLANId
SELECT TblNetworks.NetworkId,TblNetworks.NetworkName,TblNetworks.DisplayOrderIndex FROM [TblNetworks] ORDER BY TblNetworks.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cSupplierId
SELECT TblSuppliers.SupplierId,TblSuppliers.SupplierName,TblSuppliers.DisplayOrderIndex FROM [TblSuppliers] ORDER BY TblSuppliers.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cSystemTypeId
SELECT TblSystemType.SystemTypeId,TblSystemType.SystemTypeName,TblSystemType.DisplayOrderIndex FROM [TblSystemType] ORDER BY TblSystemType.DisplayOrderIndex

-- ~sq_c_NodeTechnicalManagement~sq_cAdminVLANId
SELECT TblNetworks.NetworkId,TblNetworks.NetworkName,TblNetworks.DisplayOrderIndex FROM [TblNetworks] ORDER BY TblNetworks.DisplayOrderIndex

-- ~sq_c_NodeTechnicalManagement~sq_cArchitecutreTypeId
SELECT TblArchitectureTypes.ArchitectureTypeId,TblArchitectureTypes.ArchitectureTypeName,TblArchitectureTypes.DisplayOrderIndex FROM [TblArchitectureTypes] ORDER BY TblArchitectureTypes.DisplayOrderIndex

-- ~sq_c_NodeTechnicalManagement~sq_cClusterTypeId
SELECT TblClusterTypes.ClusterTypeId,TblClusterTypes.ClusterTypeName,TblClusterTypes.DisplayOrderIndex FROM [TblClusterTypes] ORDER BY TblClusterTypes.DisplayOrderIndex

-- ~sq_c_NodeTechnicalManagement~sq_cDataCenterLocationId
SELECT TblDataCenterLocations.DataCenterLocationId,TblDataCenterLocations.DataCenterLocationName,TblDataCenterLocations.DisplayOrderIndex FROM [TblDataCenterLocations] ORDER BY TblDataCenterLocations.DisplayOrderIndex

-- ~sq_c_NodeTechnicalManagement~sq_cDeliveryStatusId
SELECT TblDeliveryStatus.StatusId,TblDeliveryStatus.StatusName,TblDeliveryStatus.DisplayOrderIndex FROM [TblDeliveryStatus] ORDER BY TblDeliveryStatus.DisplayOrderIndex

-- ~sq_c_NodeTechnicalManagement~sq_cHeartBeatVLANId
SELECT TblNetworks.NetworkId,TblNetworks.NetworkName,TblNetworks.DisplayOrderIndex FROM [TblNetworks] ORDER BY TblNetworks.DisplayOrderIndex

-- ~sq_c_NodeTechnicalManagement~sq_cInventoryUpdaterId
SELECT TblUpdaters.UserId,TblUpdaters.UserFullName,TblUpdaters.DisplayOrderIndex FROM [TblUpdaters] ORDER BY TblUpdaters.DisplayOrderIndex

-- ~sq_c_NodeTechnicalManagement~sq_cMainEnvironmentId
SELECT TblEnvironments.EnvironmentId,TblEnvironments.EnvironmentName,TblEnvironments.DisplayOrderIndex FROM [TblEnvironments] ORDER BY TblEnvironments.DisplayOrderIndex

-- ~sq_c_NodeTechnicalManagement~sq_cMainProjectId
SELECT TblProjects.ProjectId,TblProjects.ProjectName FROM [TblProjects] 

-- ~sq_c_NodeTechnicalManagement~sq_cMajorPatchLevelId
SELECT TblMajorPatchLevels.MajorPatchLevelId,TblMajorPatchLevels.MajorPatchLevelName,TblMajorPatchLevels.DisplayOrderIndex FROM [TblMajorPatchLevels] ORDER BY TblMajorPatchLevels.DisplayOrderIndex

-- ~sq_c_NodeTechnicalManagement~sq_cNodeStatusId
SELECT TblNodeStatus.StatusId,TblNodeStatus.StatusName,TblNodeStatus.DisplayOrderIndex FROM [TblNodeStatus] ORDER BY TblNodeStatus.DisplayOrderIndex

-- ~sq_c_NodeTechnicalManagement~sq_cNodeTypeId
SELECT TblNodeTypes.NodeTypeId,TblNodeTypes.NodeTypeName,TblNodeTypes.DisplayOrderIndex FROM [TblNodeTypes] ORDER BY TblNodeTypes.DisplayOrderIndex

-- ~sq_c_NodeTechnicalManagement~sq_cProductionScopeId
SELECT TblProductionScopes.ProductionScopeId,TblProductionScopes.ProductionScopeName,TblProductionScopes.DisplayOrderIndex FROM [TblProductionScopes] ORDER BY TblProductionScopes.DisplayOrderIndex

-- ~sq_c_NodeTechnicalManagement~sq_cRackLocationId
SELECT TblRackLocations.RackLocationId,TblRackLocations.RackLocationName,TblRackLocations.DisplayOrderIndex FROM [TblRackLocations] ORDER BY TblRackLocations.DisplayOrderIndex

-- ~sq_c_NodeTechnicalManagement~sq_cSecurityDomainId
SELECT TblSecurityDomains.DomainId,TblSecurityDomains.DomainName,TblSecurityDomains.DisplayOrderIndex FROM [TblSecurityDomains] ORDER BY TblSecurityDomains.DisplayOrderIndex

-- ~sq_c_NodeTechnicalManagement~sq_cStorageVLANId
SELECT TblNetworks.NetworkId,TblNetworks.NetworkName,TblNetworks.DisplayOrderIndex FROM [TblNetworks] ORDER BY TblNetworks.DisplayOrderIndex

-- ~sq_c_NodeTechnicalManagement~sq_cSupplierId
SELECT TblSuppliers.SupplierId,TblSuppliers.SupplierName,TblSuppliers.DisplayOrderIndex FROM [TblSuppliers] ORDER BY TblSuppliers.DisplayOrderIndex

-- ~sq_c_NodeTechnicalManagement~sq_cVirtualDataCenterId
SELECT TblVirtualDataCenters.VirtualDataCenterId,TblVirtualDataCenters.VirtualDataCenterName,TblVirtualDataCenters.DisplayOrderIndex FROM [TblVirtualDataCenters] ORDER BY TblVirtualDataCenters.DisplayOrderIndex

-- ~sq_c_ProjectHistoryView~sq_cBudgetStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_ProjectHistoryView~sq_cBusinessAreaId
SELECT TblBusinessAreas.BusinessAreaId,TblBusinessAreas.BusinessAreaName,TblBusinessAreas.DisplayOrderIndex FROM [TblBusinessAreas] ORDER BY TblBusinessAreas.DisplayOrderIndex

-- ~sq_c_ProjectHistoryView~sq_cEffortAndDedicationStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_ProjectHistoryView~sq_cExecutionStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_ProjectHistoryView~sq_cGlobalStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_ProjectHistoryView~sq_cListViewRelProjects2Environments
SELECT RelProjects2Environments.EnvironmentId,TblEnvironments.EnvironmentName FROM [TblEnvironments],[RelProjects2Environments] WHERE RelProjects2Environments.ProjectId=16 

-- ~sq_c_ProjectHistoryView~sq_cListViewStorageCapacity
SELECT RelProjects2Environments.StorageNASGbCapacity,RelProjects2Environments.StorageSANGbCapacity,RelProjects2Environments.StorageDASGbCapacity FROM [TblEnvironments],[RelProjects2Environments] WHERE RelProjects2Environments.ProjectId=23 And RelProjects2Environments.EnvironmentId=4 

-- ~sq_c_ProjectHistoryView~sq_cPriorityId
SELECT TblPriorities.PriorityId,TblPriorities.PriorityName,TblPriorities.DisplayOrderIndex FROM [TblPriorities] ORDER BY TblPriorities.DisplayOrderIndex

-- ~sq_c_ProjectHistoryView~sq_cProjectStatusId
SELECT TblProjectStatus.StatusId,TblProjectStatus.StatusName,TblProjectStatus.DisplayOrderIndex FROM [TblProjectStatus] ORDER BY TblProjectStatus.DisplayOrderIndex

-- ~sq_c_ProjectHistoryView~sq_cRiskStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_ProjectHistoryView~sq_cScopeStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_ProjectHistoryView~sq_cServiceManagerId
SELECT TblUpdaters.UserId,TblUpdaters.UserFullName,TblUpdaters.DisplayOrderIndex FROM [TblUpdaters] WHERE TblUpdaters.TeamId IN (1,2,3,4,22,23,24) ORDER BY TblUpdaters.DisplayOrderIndex

-- ~sq_c_ProjectHistoryView~sq_cSubFormCurrentIssues
SELECT DISTINCTROW  FROM [_IssuesBasicList] WHERE ([__ProjectId] = ProjectId) 

-- ~sq_c_ProjectHistoryView~sq_cSubFormCurrentTasks
SELECT DISTINCTROW  FROM [_TasksBasicList] WHERE ([__ProjectId] = ProjectId) 

-- ~sq_cPortfolio

-- Quick

-- Management~sq_cProjectStatusId

-- ~sq_cPortfolio

-- Quick

-- Management~sq_cRiskStatusKPI

-- ~sq_cPortfolio

-- Quick

-- Management~sq_cScopeStatusKPI

-- ~sq_cPortfolio

-- Quick

-- Management~sq_cServiceManagerId

-- ~sq_cProgress

-- Management~sq_cOwnerId

-- ~sq_cProgress

-- Management~sq_cProjectId

-- ~sq_cProgress

-- Management~sq_cSubFormCurrentTasks

-- ~sq_cProgress

-- Management~sq_cTeamId

-- ~sq_cProvisioning

-- Management~sq_cBudgetStatusKPI

-- ~sq_cProvisioning

-- Management~sq_cEffortAndDedicationStatusKPI

-- ~sq_cProvisioning

-- Management~sq_cExecutionStatusKPI

-- ~sq_cProvisioning

-- Management~sq_cImpactId

-- ~sq_cProvisioning

-- Management~sq_cOwnerId

-- ~sq_cProvisioning

-- Management~sq_cPriorityId

-- ~sq_cProvisioning

-- Management~sq_cResourcesStatusKPI

-- ~sq_cProvisioning

-- Management~sq_cRiskStatusKPI

-- ~sq_cProvisioning

-- Management~sq_cSubFormProgressView

-- ~sq_cProvisioning

-- Management~sq_cVisibilityId

-- ~sq_c_ProjectHistoryView~sq_cVisibilityId
SELECT TblVisibilities.VisibilityId,TblVisibilities.VisibilityName,TblVisibilities.DisplayOrderIndex FROM [TblVisibilities] ORDER BY TblVisibilities.DisplayOrderIndex

-- ~sq_c_ProvisioningHistoryView~sq_cEffortAndDedicationStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_ProvisioningHistoryView~sq_cExecutionStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_ProvisioningHistoryView~sq_cImpactId
SELECT TblImpacts.ImpactId,TblImpacts.ImpactName,TblImpacts.DisplayOrderIndex FROM [TblImpacts] ORDER BY TblImpacts.DisplayOrderIndex

-- ~sq_c_ProvisioningHistoryView~sq_cOwnerId
SELECT TblUpdaters.UserId,TblUpdaters.UserFullName,TblUpdaters.DisplayOrderIndex FROM [TblUpdaters] ORDER BY TblUpdaters.DisplayOrderIndex

-- ~sq_c_ProvisioningHistoryView~sq_cPriorityId
SELECT TblPriorities.PriorityId,TblPriorities.PriorityName,TblPriorities.DisplayOrderIndex FROM [TblPriorities] ORDER BY TblPriorities.DisplayOrderIndex

-- ~sq_c_ProvisioningHistoryView~sq_cResourcesStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_ProvisioningHistoryView~sq_cRiskStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_ProvisioningHistoryView~sq_cVisibilityId
SELECT TblVisibilities.VisibilityId,TblVisibilities.VisibilityName,TblVisibilities.DisplayOrderIndex FROM [TblVisibilities] ORDER BY TblVisibilities.DisplayOrderIndex

-- ~sq_c_ProvisioningProjectDetails_Notes~sq_cDeliveryStatusId
SELECT TblDeliveryStatus.StatusId,TblDeliveryStatus.StatusName,TblDeliveryStatus.DisplayOrderIndex FROM [TblDeliveryStatus] ORDER BY TblDeliveryStatus.DisplayOrderIndex

-- ~sq_c_ProvisioningProjectDetails_Notes~sq_cMainProjectId
SELECT TblProjects.ProjectId,TblProjects.ProjectName FROM [TblProjects] ORDER BY TblProjects.ProjectName

-- ~sq_c_ProvisioningProjectDetails_Notes~sq_cMainRoleId
SELECT TblRoles.RoleId,TblRoles.RoleName,TblRoles.DisplayOrderIndex FROM [TblRoles] ORDER BY TblRoles.DisplayOrderIndex

-- ~sq_c_ProvisioningProjectDetails_Notes~sq_cNodeId
SELECT TblNodes.NodeId,TblNodes.NodeName FROM [TblNodes] ORDER BY TblNodes.NodeName

-- ~sq_c_ProvisioningProjectDetailsHistoryView~sq_cImpactId
SELECT TblImpacts.ImpactId,TblImpacts.ImpactName,TblImpacts.DisplayOrderIndex FROM [TblImpacts] ORDER BY TblImpacts.DisplayOrderIndex

-- ~sq_c_ProvisioningProjectDetailsHistoryView~sq_cNodeId
SELECT TblNodes.NodeId,TblNodes.NodeName FROM [TblNodes] ORDER BY TblNodes.NodeName

-- ~sq_c_ProvisioningProjectDetailsHistoryView~sq_cRiskStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_ProvisioningProjectsSummary~sq_cSubFormProgressView
SELECT DISTINCTROW  FROM [_ProvisioningProjectDetailsBasicList] WHERE ([__ProvisioningProjectId] = ProvisioningProjectId) 

-- ~sq_c_RepairsHistoryView~sq_cBudgetStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_RepairsHistoryView~sq_cEffortAndDedicationStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_RepairsHistoryView~sq_cExecutionStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_RepairsHistoryView~sq_cImpactId
SELECT TblImpacts.ImpactId,TblImpacts.ImpactName,TblImpacts.DisplayOrderIndex FROM [TblImpacts] ORDER BY TblImpacts.DisplayOrderIndex

-- ~sq_c_RepairsHistoryView~sq_cNodeId
SELECT TblNodes.NodeId,TblNodes.NodeName FROM [TblNodes] ORDER BY TblNodes.NodeName

-- ~sq_c_RepairsHistoryView~sq_cPriorityId
SELECT TblPriorities.PriorityId,TblPriorities.PriorityName,TblPriorities.DisplayOrderIndex FROM [TblPriorities] ORDER BY TblPriorities.DisplayOrderIndex

-- ~sq_c_RepairsHistoryView~sq_cResourcesStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_RepairsHistoryView~sq_cScopeStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_RepairsHistoryView~sq_cVisibilityId
SELECT TblVisibilities.VisibilityId,TblVisibilities.VisibilityName,TblVisibilities.DisplayOrderIndex FROM [TblVisibilities] ORDER BY TblVisibilities.DisplayOrderIndex

-- ~sq_c_TasksHistoryView~sq_cBudgetStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_TasksHistoryView~sq_cEffortAndDedicationStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_TasksHistoryView~sq_cExecutionStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_TasksHistoryView~sq_cImpactId
SELECT TblImpacts.ImpactId,TblImpacts.ImpactName,TblImpacts.DisplayOrderIndex FROM [TblImpacts] ORDER BY TblImpacts.DisplayOrderIndex

-- ~sq_c_TasksHistoryView~sq_cPriorityId
SELECT TblPriorities.PriorityId,TblPriorities.PriorityName,TblPriorities.DisplayOrderIndex FROM [TblPriorities] ORDER BY TblPriorities.DisplayOrderIndex

-- ~sq_c_TasksHistoryView~sq_cRelationshipTypeId
SELECT TblRelationshipType.RelationshipTypeId,TblRelationshipType.RelationshipTypeName,TblRelationshipType.DisplayOrderIndex FROM [TblRelationshipType] ORDER BY TblRelationshipType.DisplayOrderIndex

-- ~sq_c_TasksHistoryView~sq_cResourcesStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_TasksHistoryView~sq_cScopeStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_TasksHistoryView~sq_cTaskCategoryId
SELECT TblTaskCategories.CategoryId,TblTaskCategories.CategoryName,TblTaskCategories.DisplayOrderIndex FROM [TblTaskCategories] ORDER BY TblTaskCategories.DisplayOrderIndex

-- ~sq_c_TasksHistoryView~sq_cUpdaterTeamId
SELECT TblTeams.TeamId,TblTeams.TeamName,TblTeams.DisplayOrderIndex FROM [TblTeams] ORDER BY TblTeams.DisplayOrderIndex

-- ~sq_c_TasksHistoryView~sq_cVisibilityId
SELECT TblVisibilities.VisibilityId,TblVisibilities.VisibilityName,TblVisibilities.DisplayOrderIndex FROM [TblVisibilities] ORDER BY TblVisibilities.DisplayOrderIndex

-- ~sq_cContacts

-- Management~sq_cTeamId

-- ~sq_cDecommissioning

-- Management~sq_cBudgetStatusKPI

-- ~sq_cDecommissioning

-- Management~sq_cExecutionStatusKPI

-- ~sq_cDecommissioning

-- Management~sq_cGlobalStatusKPI

-- ~sq_cDecommissioning

-- Management~sq_cImpactId

-- ~sq_cDecommissioning

-- Management~sq_cOwnerId

-- ~sq_cDecommissioning

-- Management~sq_cPriorityId

-- ~sq_cDecommissioning

-- Management~sq_cRiskStatusKPI

-- ~sq_cDecommissioning

-- Management~sq_cScopeStatusKPI

-- ~sq_cDecommissioning

-- Management~sq_cWorkFlowStatusId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cAdminVLANId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cArchitecutreTypeId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cComboBoxRelNodes2Roles

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cCurrentSecurityLevelId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cDeliveryStatusId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cHardwareAdminVLANId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cHeatBeatVLANId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cInventoryUpdaterId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cMainEnvironmentId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cMainProjectId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cMainRoleId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cNodeTypeId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cParentNodeId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cProductionScopeId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cRequiredSecurityLevelId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cRiskStatusId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cSecurityDomainId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cServiceManagerId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cServiceVLANId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cSubFormRelatedNodes

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cSubFormRepairsBasicList

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cVirtualDataCenterId

-- ~sq_cInfrastructure

-- Node

-- Quick

-- Management~sq_cDeliveryStatusId

-- ~sq_cInfrastructure

-- Node

-- Quick

-- Management~sq_cInventoryUpdaterId

-- ~sq_cInfrastructure

-- Node

-- Quick

-- Management~sq_cMainEnvironmentId

-- ~sq_cInfrastructure

-- Node

-- Quick

-- Management~sq_cMainProjectId

-- ~sq_cInfrastructure

-- Node

-- Quick

-- Management~sq_cProductionScopeId

-- ~sq_cInfrastructure

-- Node

-- Quick

-- Management~sq_cRackLocationId

-- ~sq_cIssues

-- &

-- Risks

-- Management~sq_cActionStatusId

-- ~sq_cIssues

-- &

-- Risks

-- Management~sq_cOwnerId

-- ~sq_cIssues

-- &

-- Risks

-- Management~sq_cOwnerTeamId

-- ~sq_cIssues

-- &

-- Risks

-- Management~sq_cRelationshipTypeId

-- ~sq_cIssues

-- &

-- Risks

-- Management~sq_cRiskTypeId

-- ~sq_cMainMenu~sq_cSessionUserId
SELECT TblUpdaters.UserId,TblUpdaters.UserFullName,TblUpdaters.DisplayOrderIndex FROM [TblUpdaters] ORDER BY TblUpdaters.DisplayOrderIndex

-- ~sq_cPortfolio

-- Management~sq_cBudgetStatusKPI

-- ~sq_cPortfolio

-- Management~sq_cBusinessAreaId

-- ~sq_cPortfolio

-- Management~sq_cEffortAndDedicationStatusKPI

-- ~sq_cPortfolio

-- Management~sq_cExecutionStatusKPI

-- ~sq_cPortfolio

-- Management~sq_cGlobalMaturityEvaluationId

-- ~sq_cPortfolio

-- Management~sq_cGlobalStatusKPI

-- ~sq_cPortfolio

-- Management~sq_cListViewStorageCapacity

-- ~sq_cPortfolio

-- Management~sq_cParentProjectId

-- ~sq_cPortfolio

-- Management~sq_cPriorityId

-- ~sq_cPortfolio

-- Management~sq_cResourcesStatusKPI

-- ~sq_cPortfolio

-- Management~sq_cRiskStatusKPI

-- ~sq_cPortfolio

-- Management~sq_cServiceCoverageId

-- ~sq_cPortfolio

-- Management~sq_cServiceManagerId

-- ~sq_cPortfolio

-- Management~sq_cSubFormCurrentProvisioningProjects

-- ~sq_cPortfolio

-- Management~sq_cSubFormCurrentTasks

-- ~sq_cPortfolio

-- Quick

-- Management~sq_cBudgetStatusKPI

-- ~sq_cPortfolio

-- Quick

-- Management~sq_cBusinessAreaId

-- ~sq_cPortfolio

-- Quick

-- Management~sq_cEffortAndDedicationStatusKPI

-- ~sq_cPortfolio

-- Quick

-- Management~sq_cGlobalMaturityEvaluationId

-- ~sq_cPortfolio

-- Quick

-- Management~sq_cGlobalStatusKPI

-- ~sq_cPortfolio

-- Quick

-- Management~sq_cPriorityId

-- ~sq_cRepairs

-- Management~sq_cDeliveredNodeId

-- ~sq_cRepairs

-- Management~sq_cEffortAndDedicationStatusKPI

-- ~sq_cRepairs

-- Management~sq_cGlobalStatusKPI

-- ~sq_cRepairs

-- Management~sq_cImpactId

-- ~sq_cRepairs

-- Management~sq_cOwnerId

-- ~sq_cRepairs

-- Management~sq_cPriorityId

-- ~sq_cRepairs

-- Management~sq_cRiskStatusKPI

-- ~sq_cRepairs

-- Management~sq_cScopeStatusKPI

-- ~sq_cRepairs

-- Management~sq_cWorkFlowStatusId

-- ~sq_cTasks

-- Management~sq_cBudgetStatusKPI

-- ~sq_cTasks

-- Management~sq_cExecutionStatusKPI

-- ~sq_cTasks

-- Management~sq_cGlobalStatusKPI

-- ~sq_cTasks

-- Management~sq_cImpactId

-- ~sq_cTasks

-- Management~sq_cProjectId

-- ~sq_cTasks

-- Management~sq_cRelationshipTypeId

-- ~sq_cTasks

-- Management~sq_cRiskStatusKPI

-- ~sq_cTasks

-- Management~sq_cScopeStatusKPI

-- ~sq_cTasks

-- Management~sq_cUpdaterId

-- ~sq_cTasks

-- Management~sq_cUpdaterTeamId

-- ~sq_cTasks

-- Management~sq_cWorkStreamId

-- ~sq_dTasks_ClosedProgressReport~sq_dImpactId
SELECT TblImpacts.ImpactId,TblImpacts.ImpactName,TblImpacts.DisplayOrderIndex FROM [TblImpacts] ORDER BY TblImpacts.DisplayOrderIndex

-- ~sq_dTasks_ClosedProgressReport~sq_dProjectId
SELECT TblProjects.ProjectId,TblProjects.ProjectName FROM [TblProjects] 

-- ~sq_dTasks_ClosedProgressReport~sq_dUpdaterId
SELECT TblUpdaters.UserId,TblUpdaters.UserFullName,TblUpdaters.DisplayOrderIndex FROM [TblUpdaters] ORDER BY TblUpdaters.DisplayOrderIndex

-- ~sq_dTasks_OpenedButPending~sq_dImpactId
SELECT TblImpacts.ImpactId,TblImpacts.ImpactName,TblImpacts.DisplayOrderIndex FROM [TblImpacts] ORDER BY TblImpacts.DisplayOrderIndex

-- ~sq_dTasks_OpenedButPending~sq_dPriorityId
SELECT TblPriorities.PriorityId,TblPriorities.PriorityName,TblPriorities.DisplayOrderIndex FROM [TblPriorities] ORDER BY TblPriorities.DisplayOrderIndex

-- ~sq_dTasks_OpenedButPending~sq_dTaskCategoryId
SELECT TblTaskCategories.CategoryId,TblTaskCategories.CategoryName,TblTaskCategories.DisplayOrderIndex FROM [TblTaskCategories] ORDER BY TblTaskCategories.DisplayOrderIndex

-- ~sq_dTasks_OpenedButPending~sq_dVisibilityId
SELECT TblVisibilities.VisibilityId,TblVisibilities.VisibilityName,TblVisibilities.DisplayOrderIndex FROM [TblVisibilities] ORDER BY TblVisibilities.DisplayOrderIndex

-- ~sq_dTasks_ProgressReport_AssignedForThisWeek~sq_dPriorityId
SELECT TblPriorities.PriorityId,TblPriorities.PriorityName,TblPriorities.DisplayOrderIndex FROM [TblPriorities] ORDER BY TblPriorities.DisplayOrderIndex

-- ~sq_dTasks_ProgressReport_AssignedForThisWeek~sq_dProjectId
SELECT TblProjects.ProjectId,TblProjects.ProjectName FROM [TblProjects] 

-- ~sq_dTasks_ProgressReport_AssignedForThisWeek~sq_dVisibilityId
SELECT TblVisibilities.VisibilityId,TblVisibilities.VisibilityName,TblVisibilities.DisplayOrderIndex FROM [TblVisibilities] ORDER BY TblVisibilities.DisplayOrderIndex

-- ~sq_dTasks_ProgressReport~sq_dPriorityId
SELECT TblPriorities.PriorityId,TblPriorities.PriorityName,TblPriorities.DisplayOrderIndex FROM [TblPriorities] ORDER BY TblPriorities.DisplayOrderIndex

-- ~sq_dTasks_ProgressReport~sq_dProjectId
SELECT TblProjects.ProjectId,TblProjects.ProjectName FROM [TblProjects] 

-- ~sq_dTasks_ProgressReport~sq_dVisibilityId
SELECT TblVisibilities.VisibilityId,TblVisibilities.VisibilityName,TblVisibilities.DisplayOrderIndex FROM [TblVisibilities] ORDER BY TblVisibilities.DisplayOrderIndex

-- ~sq_f_ContactsHistoryView
SELECT DISTINCTROW  FROM [TblUpdatersHistory] 

-- ~sq_f_EntityData_BusinessAreas
SELECT DISTINCTROW  FROM [TblBusinessAreas] 

-- ~sq_f_EntityData_DataCenterLocations
SELECT DISTINCTROW  FROM [TblDataCenterLocations] 

-- ~sq_f_EntityData_Environments
SELECT DISTINCTROW  FROM [TblEnvironments] 

-- Nodes_Summary_NodesByNodeStatus
SELECT TblNodeStatus.StatusName,Count(TblNodes.NodeId) FROM [TblNodes],[TblNodeStatus] WHERE TblNodes.NodeIsDeleted=False ORDER BY Count(TblNodes.NodeId)

-- Nodes_Summary_NodesByNodeType
SELECT TblNodeTypes.NodeTypeName,Count(TblNodes.NodeId) FROM [TblNodes],[TblNodeTypes] WHERE TblNodes.NodeIsDeleted=False ORDER BY Count(TblNodes.NodeId)

-- Nodes_Summary_NodesByPotentialSubNets
SELECT Count(TblNodes.NodeName),Left(TblNodes.ServiceIP,9) FROM [TblRoles],[TblProjects],[TblEnvironments],[TblNodes] WHERE TblNodes.NodeName Not Like "TPL*" And TblNodes.NodeIsDeleted=False And TblNodes.NodeIsActive=True ORDER BY Count(TblNodes.NodeName)

-- Nodes_Summary_NodesByProject
SELECT TblProjects.ProjectName,COUNT(TblNodes.NodeId) FROM [TblProjects],[TblNodes] WHERE TblNodes.NodeIsDeleted=False ORDER BY COUNT(TblNodes.NodeId)

-- Nodes_Summary_NodesByRole
SELECT TblRoles.RoleName,COUNT(TblNodes.NodeId) FROM [TblRoles],[TblNodes] WHERE TblNodes.NodeIsDeleted=False ORDER BY COUNT(TblNodes.NodeId)

-- Nodes_Summary_NodesBySystemType
SELECT TblSystemType.SystemTypeName,Count(TblNodes.NodeId) FROM [TblSystemType],[TblNodes] WHERE TblNodes.NodeIsDeleted=False ORDER BY Count(TblNodes.NodeId)

-- Nodes_Summary_TotalNodes
SELECT COUNT(TblNodes.NodeId) FROM [TblNodes] WHERE TblNodes.NodeIsDeleted=False 

-- Nodes_Summary_TotalNodes_QuantizedCreationDate
SELECT Format(CDate(InventoryCreationDate),'mmm'),Count(*) FROM [TblNodes] WHERE TblNodes.NodeIsDeleted=False ORDER BY Format(CDate(InventoryCreationDate),'mmm')

-- Nodes_Summary_TotalRoles
SELECT COUNT(TblRoles.RoleId) FROM [TblRoles] 

-- Nodes_Summary_Wintel_NodesByBusinessArea_Projects
SELECT TblBusinessAreas.BusinessAreaName,TblProjects.ProjectName,COUNT(TblNodes.NodeId) FROM [TblProjects],[TblNodes],[TblBusinessAreas] WHERE TblNodes.NodeIsDeleted=False and TblNodes.SystemTypeId in (3,4,5,6,18,19,20,21,22) ORDER BY COUNT(TblNodes.NodeId)

-- Nodes_Summary_Wintel_NodesByEnvironment
SELECT TblEnvironments.EnvironmentName,Count(TblNodes.NodeId) FROM [TblEnvironments],[TblNodes] WHERE TblNodes.NodeIsDeleted=False and TblNodes.SystemTypeId in (3,4,5,6,18,19,20,21,22) ORDER BY Count(TblNodes.NodeId)

-- Nodes_Summary_Wintel_NodesByPotentialSubNets
SELECT Count(TblNodes.NodeName),Left(TblNodes.ServiceIP,9) FROM [TblRoles],[TblProjects],[TblEnvironments],[TblNodes] WHERE TblNodes.NodeName Not Like "TPL*" And TblNodes.NodeIsDeleted=False And TblNodes.NodeIsActive=True and TblNodes.SystemTypeId in (3,4,5,6,18,19,20,21,22) ORDER BY Count(TblNodes.NodeName)

-- Nodes_Summary_Wintel_NodesByProject
SELECT TblProjects.ProjectName,COUNT(TblNodes.NodeId) FROM [TblProjects],[TblNodes] WHERE TblNodes.NodeIsDeleted=False and TblNodes.SystemTypeId in (3,4,5,6,18,19,20,21,22) ORDER BY COUNT(TblNodes.NodeId)

-- Nodes_Summary_Wintel_NodesByRole
SELECT TblRoles.RoleName,COUNT(TblNodes.NodeId) FROM [TblRoles],[TblNodes] WHERE TblNodes.NodeIsDeleted=False and TblNodes.SystemTypeId in (3,4,5,6,18,19,20,21,22) ORDER BY COUNT(TblNodes.NodeId)

-- Nodes_Summary_Wintel_TotalNodes
SELECT COUNT(TblNodes.NodeId) FROM [TblNodes] WHERE TblNodes.NodeIsDeleted=False and TblNodes.SystemTypeId in (3,4,5,6,18,19,20,21,22) 

-- Nodes_Summary_Wintel_TotalNodes_QuantizedCreationDate
SELECT Format(CDate(InventoryCreationDate),'mmm'),Count(*) FROM [TblNodes] WHERE TblNodes.NodeIsDeleted=False AND TblNodes.SystemTypeId in (3,4,5,6,18,19,20,21,22) ORDER BY Format(CDate(InventoryCreationDate),'mmm')

-- Project_ClosedTasks
SELECT TblProjects.ProjectName,COUNT(TblTasks.TaskId) FROM [TblProjects],[TblTasks] WHERE TblProjects.ProjectName=[Project Name] AND TblTasks.CurrentProgress=1 

-- Project_ClosedTasks_ActivityType
SELECT TblProjects.ProjectName,TblTaskCategories.CategoryName,COUNT(TblTasks.TaskId) FROM [TblProjects],[TblTasks],[TblTaskCategories] WHERE TblProjects.ProjectName=[Project Name] AND TblTasks.CurrentProgress=1 ORDER BY TblTaskCategories.CategoryName

-- Project_ClosedTasks_Relevance
SELECT TblProjects.ProjectName,TblPriorities.PriorityName,TblVisibilities.VisibilityName,TblImpacts.ImpactName,TblKpiStatus.StatusName,COUNT(TblTasks.TaskId) FROM [TblProjects],[TblTasks],[TblPriorities],[TblVisibilities],[TblImpacts],[TblKpiStatus] WHERE TblProjects.ProjectName=[Project Name] AND TblTasks.CurrentProgress=1 ORDER BY TblPriorities.PriorityName

-- Project_ClosedTasks_ResourcesInvolved
SELECT TblProjects.ProjectName,TblTasks.ResourcesInvolved,COUNT(TblTasks.TaskId) FROM [TblProjects],[TblTasks] WHERE TblProjects.ProjectName=[Project Name] AND TblTasks.CurrentProgress=1 ORDER BY TblTasks.ResourcesInvolved

-- Project_ClosedTasks_Status
SELECT TblProjects.ProjectName,AssignedTasks.IsUnplanned,TblTasks.IsBlocked,TblTasks.IsFreezed,COUNT(TblTasks.TaskId) FROM [TblProjects],[TblTasks],[] WHERE TblProjects.ProjectName=[Project Name] AND TblTasks.CurrentProgress=1 ORDER BY TblTasks.IsBlocked

-- Project_ClosedTasks_StatusKPI
SELECT TblProjects.ProjectName,TmpGlobalStatus.StatusName,TmpRiskStatus.StatusName,TmpExecutionStatus.StatusName,TmpScopeStatus.StatusName,TmpBugdetStatus.StatusName,TmpResourcesStatus.StatusName,TmpEffortAndDedicationStatus.StatusName,COUNT(TblTasks.TaskId) FROM [TblProjects],[TblTasks],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus] WHERE TblProjects.ProjectName=[Project Name] AND TblTasks.CurrentProgress=1 ORDER BY TblProjects.ProjectName

-- Project_ClosedTasks_WorkTime
SELECT TblProjects.ProjectName,TblTasks.WorkTime,COUNT(TblTasks.TaskId) FROM [TblProjects],[TblTasks] WHERE TblProjects.ProjectName=[Project Name] AND TblTasks.CurrentProgress=1 ORDER BY TblTasks.WorkTime

-- Project_Tasks
SELECT TblProjects.ProjectName,COUNT(TblTasks.TaskId) FROM [TblProjects],[TblTasks] WHERE TblProjects.ProjectName=[Project Name] 

-- Project_Tasks_Relevance
SELECT TblProjects.ProjectName,TblPriorities.PriorityName,TblVisibilities.VisibilityName,TblImpacts.ImpactName,TblKpiStatus.StatusName,COUNT(TblTasks.TaskId) FROM [TblProjects],[TblTasks],[TblPriorities],[TblVisibilities],[TblImpacts],[TblKpiStatus] WHERE TblProjects.ProjectName=[Project Name] ORDER BY TblPriorities.PriorityName

-- Project_Tasks_ReschedulingCount
SELECT TblProjects.ProjectName,TblTasks.ReschedulingCount,COUNT(TblTasks.TaskId) FROM [TblProjects],[TblTasks] WHERE TblProjects.ProjectName=[Project Name] ORDER BY TblTasks.ReschedulingCount

-- ~sq_f_EntityData_RackLocations
SELECT DISTINCTROW  FROM [TblRackLocations] 

-- ~sq_f_EntityData_Roles
SELECT DISTINCTROW  FROM [TblRoles] 

-- ~sq_f_EntityData_Teams
SELECT DISTINCTROW  FROM [TblTeams] 

-- ~sq_f_EntityData_VirtualDataCenters
SELECT DISTINCTROW  FROM [TblVirtualDataCenters] 

-- ~sq_f_IssuesHistoryView
SELECT DISTINCTROW  FROM [TblIssuesHistory] 

-- ~sq_f_NodeDeliveryManagement
SELECT DISTINCTROW  FROM [TblNodes] 

-- ~sq_f_NodeExpandedFieldView_HbaLinksInfo
SELECT DISTINCTROW  FROM [TblNodes] 

-- ~sq_f_NodeExpandedFieldView_SecurityAuditReport
SELECT DISTINCTROW  FROM [TblNodes] 

-- ~sq_f_NodeExpandedFieldView_SystemAuditReport
SELECT DISTINCTROW  FROM [TblNodes] 

-- ~sq_f_NodeHistoryExpandedFieldView_HbaLinksInfo
SELECT DISTINCTROW  FROM [TblNodesHistory] 

-- ~sq_f_NodeHistoryExpandedFieldView_Notes
SELECT DISTINCTROW  FROM [TblNodesHistory] 

-- ~sq_f_NodeHistoryExpandedFieldView_SystemAuditReport
SELECT DISTINCTROW  FROM [TblNodesHistory] 

-- ~sq_f_NodeHistoryExpandedFieldView_SystemInformationDump
SELECT DISTINCTROW  FROM [TblNodesHistory] 

-- ~sq_f_NodeHistoryView
SELECT DISTINCTROW  FROM [TblNodesHistory] 

-- ~sq_f_ProjectHistoryView
SELECT DISTINCTROW  FROM [TblProjectsHistory] 

-- ~sq_f_ProvisioningHistoryView
SELECT DISTINCTROW  FROM [TblProvisioningProjectsHistory] 

-- ~sq_f_TasksHistoryView
SELECT DISTINCTROW  FROM [TblTasksHistory] 

-- ~sq_fInfrastructure

-- Node

-- Management

-- ~sq_fInfrastructure

-- Node

-- Quick

-- Management

-- ~sq_fPortfolio

-- Management

-- ~sq_fPortfolio

-- Quick

-- Management

-- ~sq_fProgress

-- Management

-- ~sq_fTasks

-- Management

-- Issues_ProgressByPeriod_LiveIssues
SELECT RelProgressReports2Issues.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,TblProjects.ProjectName,TblIssues.IsARisk,TblKpiStatus.StatusName,TblActionStatus.StatusName,count(TblIssues.IssueId) FROM [TblIssues],[TblProgressReports],[RelProgressReports2Issues],[TblTeams],[TblProjects],[TblKpiStatus],[TblActionStatus] WHERE TblIssues.ActionStatusId IN (1,2,3,4,9,10) ORDER BY RelProgressReports2Issues.ProgressReportId

-- Issues_ProgressByPeriod_LiveIssues_Age
SELECT RelProgressReports2Issues.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,TblProjects.ProjectName,TblIssues.IsARisk,TblKpiStatus.StatusName,TblActionStatus.StatusName,Round((TblProgressReports.StartDate-TblIssues.CreationDate),2),Count(TblIssues.IssueId) FROM [TblIssues],[TblProgressReports],[RelProgressReports2Issues],[TblTeams],[TblProjects],[TblKpiStatus],[TblActionStatus] WHERE (((TblIssues.ActionStatusId) In (1,2,3,4,9,10))) ORDER BY RelProgressReports2Issues.ProgressReportId

-- Issues_ProgressByPeriod_RisksAge
SELECT RelProgressReports2Issues.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,TblProjects.ProjectName,TblIssues.IsARisk,Round((TblProgressReports.StartDate-TblIssues.CreationDate),2),Count(TblIssues.IssueId) FROM [TblProgressReports],[TblIssues],[RelProgressReports2Issues],[TblTeams],[TblProjects] ORDER BY RelProgressReports2Issues.ProgressReportId

-- Issues_ProgressByPeriod_Severity
SELECT RelProgressReports2Issues.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,TblProjects.ProjectName,TblIssues.IsARisk,TblKpiStatus.StatusName,count(TblIssues.IssueId) FROM [TblIssues],[TblProgressReports],[RelProgressReports2Issues],[TblTeams],[TblProjects],[TblKpiStatus] ORDER BY RelProgressReports2Issues.ProgressReportId

-- Issues_ProgressByPeriod_Severity_ActionStatus
SELECT RelProgressReports2Issues.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,TblProjects.ProjectName,TblIssues.IsARisk,TblKpiStatus.StatusName,TblActionStatus.StatusName,count(TblIssues.IssueId) FROM [TblIssues],[TblProgressReports],[RelProgressReports2Issues],[TblTeams],[TblProjects],[TblKpiStatus],[TblActionStatus] ORDER BY RelProgressReports2Issues.ProgressReportId

-- Issues_ProgressByPeriod_SeverityAge
SELECT RelProgressReports2Issues.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,TblProjects.ProjectName,TblIssues.IsARisk,TblKpiStatus.StatusName,Round((TblProgressReports.StartDate-TblIssues.CreationDate),2),count(TblIssues.IssueId) FROM [TblIssues],[TblProgressReports],[RelProgressReports2Issues],[TblTeams],[TblProjects],[TblKpiStatus] ORDER BY RelProgressReports2Issues.ProgressReportId

-- Issues_ProgressByPeriod_SeverityAge_ActionStatus
SELECT RelProgressReports2Issues.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,TblProjects.ProjectName,TblIssues.IsARisk,TblKpiStatus.StatusName,TblActionStatus.StatusName,Round((TblProgressReports.StartDate-TblIssues.CreationDate),2),count(TblIssues.IssueId) FROM [TblIssues],[TblProgressReports],[RelProgressReports2Issues],[TblTeams],[TblProjects],[TblKpiStatus],[TblActionStatus] ORDER BY RelProgressReports2Issues.ProgressReportId

-- Nodes_Decommissioning_Completed_Detail
SELECT TblDecommissioning.DecommissioningId,TblNodes.NodeName,TblUpdaters.UserFullName,TblDecommissioning.HasBeenVirtualized,TmpNodes.NodeName,TblPriorities.PriorityName,TblVisibilities.VisibilityName,TblImpacts.ImpactName,TblDecommissioningWorkflowStatus.StatusName,TblDecommissioning.CurrentProgress,TblDecommissioning.IsBlocked,TblDecommissioning.IsFrozen,TmpGlobalStatus.StatusName,TmpRiskStatus.StatusName,TmpExecutionStatus.StatusName,TmpScopeStatus.StatusName,TmpBudgetStatus.StatusName,TmpResourcesStatus.StatusName,TmpEffortAndDedicationStatus.StatusName,TblDecommissioning.WorkTime,TblDecommissioning.ResourcesInvolved,TblDecommissioning.StartDate,TblDecommissioning.ScheduledEndDate,TblDecommissioning.EndDate,TblDecommissioning.LastUpdateDate,TblDecommissioning.ReschedulingCount FROM [TblDecommissioning],[TblNodes],[TblNodes],[TblUpdaters],[TblPriorities],[TblVisibilities],[TblImpacts],[TblDecommissioningWorkflowStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus] WHERE TblDecommissioning.IsDeleted=False And TblDecommissioning.CurrentProgress=1 ORDER BY TblDecommissioning.CurrentProgress

-- Nodes_Decommissioning_Completed_QuantizedEndDate_Owner
SELECT Count(*),Format(CDate(TblDecommissioning.EndDate),'mmm yy'),TblUpdaters.UserFullName FROM [TblDecommissioning],[TblUpdaters] WHERE TblDecommissioning.IsDeleted=False AND TblDecommissioning.CurrentProgress=1 AND NOT IsNull(TblDecommissioning.EndDate) ORDER BY Format(CDate(TblDecommissioning.EndDate),'mmm yy')

-- Nodes_Decommissioning_Completed_QuantizedEndDate_Project
SELECT Count(*),Format(CDate(TblDecommissioning.EndDate),'mmm yy'),TblProjects.ProjectName FROM [TblDecommissioning],[TblNodes],[TblProjects] WHERE TblDecommissioning.IsDeleted=False AND TblDecommissioning.CurrentProgress=1 AND NOT IsNull(TblDecommissioning.EndDate) ORDER BY Format(CDate(TblDecommissioning.EndDate),'mmm yy')

-- Nodes_Decommissioning_Completed_QuantizedStartDate_Owner
SELECT Count(*),Format(CDate(TblDecommissioning.StartDate),'mmm yy'),TblUpdaters.UserFullName FROM [TblDecommissioning],[TblUpdaters] WHERE TblDecommissioning.IsDeleted=False AND TblDecommissioning.CurrentProgress=1 ORDER BY Format(CDate(TblDecommissioning.StartDate),'mmm yy')

-- Nodes_Decommissioning_Completed_QuantizedStartDate_Project
SELECT Count(*),Format(CDate(TblDecommissioning.StartDate),'mmm yy'),TblProjects.ProjectName FROM [TblDecommissioning],[TblNodes],[TblProjects] WHERE TblDecommissioning.IsDeleted=False AND TblDecommissioning.CurrentProgress=1 ORDER BY Format(CDate(TblDecommissioning.StartDate),'mmm yy')

-- Nodes_Decommissioning_Completed_QuantizedStartDate_Supplier
SELECT Count(*),Format(CDate(TblDecommissioning.StartDate),'mmm yy'),TblSuppliers.SupplierName FROM [TblDecommissioning],[TblNodes],[TblSuppliers] WHERE TblDecommissioning.IsDeleted=False AND TblDecommissioning.CurrentProgress=1 ORDER BY Format(CDate(TblDecommissioning.StartDate),'mmm yy')

-- Nodes_Decommissioning_Pending_Detail
SELECT TblDecommissioning.DecommissioningId,TblNodes.NodeName,TblUpdaters.UserFullName,TblDecommissioning.HasBeenVirtualized,TmpNodes.NodeName,TblPriorities.PriorityName,TblVisibilities.VisibilityName,TblImpacts.ImpactName,TblDecommissioningWorkflowStatus.StatusName,TblDecommissioning.CurrentProgress,TblDecommissioning.IsBlocked,TblDecommissioning.IsFrozen,TmpGlobalStatus.StatusName,TmpRiskStatus.StatusName,TmpExecutionStatus.StatusName,TmpScopeStatus.StatusName,TmpBudgetStatus.StatusName,TmpResourcesStatus.StatusName,TmpEffortAndDedicationStatus.StatusName,TblDecommissioning.WorkTime,TblDecommissioning.ResourcesInvolved,TblDecommissioning.StartDate,TblDecommissioning.ScheduledEndDate,TblDecommissioning.EndDate,TblDecommissioning.LastUpdateDate,TblDecommissioning.ReschedulingCount FROM [TblDecommissioning],[TblNodes],[TblNodes],[TblUpdaters],[TblPriorities],[TblVisibilities],[TblImpacts],[TblDecommissioningWorkflowStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus] WHERE TblDecommissioning.IsDeleted=False And TblDecommissioning.CurrentProgress<1 ORDER BY TblDecommissioning.CurrentProgress

-- Nodes_Decommissioning_Pending_QuantizedStartDate_Owner
SELECT Count(*),Format(CDate(TblDecommissioning.StartDate),'mmm yy'),TblUpdaters.UserFullName FROM [TblDecommissioning],[TblUpdaters] WHERE TblDecommissioning.IsDeleted=False AND TblDecommissioning.CurrentProgress<1 ORDER BY Format(CDate(TblDecommissioning.StartDate),'mmm yy')

-- Nodes_Decommissioning_Pending_QuantizedStartDate_Project
SELECT Count(*),Format(CDate(TblDecommissioning.StartDate),'mmm yy'),TblProjects.ProjectName FROM [TblDecommissioning],[TblNodes],[TblProjects] WHERE TblDecommissioning.IsDeleted=False AND TblDecommissioning.CurrentProgress<1 ORDER BY Format(CDate(TblDecommissioning.StartDate),'mmm yy')

-- Nodes_Decommissioning_Pending_QuantizedStartDate_Supplier
SELECT Count(*),Format(CDate(TblDecommissioning.StartDate),'mmm yy'),TblSuppliers.SupplierName FROM [TblDecommissioning],[TblNodes],[TblSuppliers] WHERE TblDecommissioning.IsDeleted=False AND TblDecommissioning.CurrentProgress<1 ORDER BY Format(CDate(TblDecommissioning.StartDate),'mmm yy')

-- Nodes_History_Summary_Status_Decomissioned
SELECT TblNodeStatus.StatusName,Count(TmpDecomissioned.NodeId) FROM [],[TblNodeStatus] ORDER BY Count(TmpDecomissioned.NodeId)

-- Nodes_Repairs_Pending_Detail
SELECT TblRepairs.RepairId,TblNodes.NodeName,TblUpdaters.UserFullName,TblRepairs.HasBeenReplaced,TmpNodes.NodeName,TblPriorities.PriorityName,TblVisibilities.VisibilityName,TblImpacts.ImpactName,TblRepairWorkflowStatus.StatusName,TblRepairs.CurrentProgress,TblRepairs.IsBlocked,TblRepairs.IsFreezed,TblRepairs.SupplierRepairId,TmpGlobalStatus.StatusName,TmpRiskStatus.StatusName,TmpExecutionStatus.StatusName,TmpScopeStatus.StatusName,TmpBudgetStatus.StatusName,TmpResourcesStatus.StatusName,TmpEffortAndDedicationStatus.StatusName,TblRepairs.WorkTime,TblRepairs.ResourcesInvolved,TblRepairs.StartDate,TblRepairs.ScheduledEndDate,TblRepairs.EndDate,TblRepairs.LastUpdateDate,TblRepairs.ReschedulingCount FROM [TblRepairs],[TblNodes],[TblNodes],[TblUpdaters],[TblPriorities],[TblVisibilities],[TblImpacts],[TblRepairWorkflowStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus] WHERE TblRepairs.IsDeleted=False And TblRepairs.CurrentProgress<1 ORDER BY TblRepairs.CurrentProgress

-- Nodes_Repairs_Pending_QuantizedStartDate_Project
SELECT Count(*),Format(CDate(TblRepairs.StartDate),'mmm yy'),TblProjects.ProjectName FROM [TblRepairs],[TblNodes],[TblProjects] WHERE TblRepairs.IsDeleted=False AND TblRepairs.CurrentProgress<1 ORDER BY Format(CDate(TblRepairs.StartDate),'mmm yy')

-- Nodes_Repairs_Pending_QuantizedStartDate_Supplier
SELECT Count(*),Format(CDate(TblRepairs.StartDate),'mmm yy'),TblSuppliers.SupplierName FROM [TblRepairs],[TblNodes],[TblSuppliers] WHERE TblRepairs.IsDeleted=False AND TblRepairs.CurrentProgress<1 ORDER BY Format(CDate(TblRepairs.StartDate),'mmm yy')

-- Nodes_Repairs_Pending_Relevance_ByProject
SELECT Count(*),TblProjects.ProjectName,TblPriorities.PriorityName,TblVisibilities.VisibilityName,TblImpacts.ImpactName FROM [TblRepairs],[TblNodes],[TblProjects],[TblPriorities],[TblVisibilities],[TblImpacts] WHERE TblRepairs.IsDeleted=False AND TblRepairs.CurrentProgress<1 ORDER BY TblProjects.ProjectName

-- Nodes_Repairs_Repaired_Detail
SELECT TblRepairs.RepairId,TblNodes.NodeName,TblUpdaters.UserFullName,TblRepairs.HasBeenReplaced,TmpNodes.NodeName,TblPriorities.PriorityName,TblVisibilities.VisibilityName,TblImpacts.ImpactName,TblRepairWorkflowStatus.StatusName,TblRepairs.CurrentProgress,TblRepairs.IsBlocked,TblRepairs.IsFreezed,TblRepairs.SupplierRepairId,TmpGlobalStatus.StatusName,TmpRiskStatus.StatusName,TmpExecutionStatus.StatusName,TmpScopeStatus.StatusName,TmpBudgetStatus.StatusName,TmpResourcesStatus.StatusName,TmpEffortAndDedicationStatus.StatusName,TblRepairs.WorkTime,TblRepairs.ResourcesInvolved,TblRepairs.StartDate,TblRepairs.ScheduledEndDate,TblRepairs.EndDate,TblRepairs.LastUpdateDate,TblRepairs.ReschedulingCount FROM [TblRepairs],[TblNodes],[TblNodes],[TblUpdaters],[TblPriorities],[TblVisibilities],[TblImpacts],[TblRepairWorkflowStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus] WHERE TblRepairs.IsDeleted=False And TblRepairs.CurrentProgress=1 ORDER BY TblRepairs.CurrentProgress

-- Nodes_Repairs_Repaired_QuantizedEndDate_Owner
SELECT Count(*),Format(CDate(TblRepairs.EndDate),'mmm yy'),TblUpdaters.UserFullName FROM [TblRepairs],[TblUpdaters] WHERE TblRepairs.IsDeleted=False AND TblRepairs.CurrentProgress=1 AND NOT IsNull(TblRepairs.EndDate) ORDER BY Format(CDate(TblRepairs.EndDate),'mmm yy')

-- Nodes_Repairs_Repaired_QuantizedEndDate_Supplier
SELECT Count(*),Format(CDate(TblRepairs.EndDate),'mmm yy'),TblSuppliers.SupplierName FROM [TblRepairs],[TblNodes],[TblSuppliers] WHERE TblRepairs.IsDeleted=False AND TblRepairs.CurrentProgress=1 AND NOT IsNull(TblRepairs.EndDate) ORDER BY Format(CDate(TblRepairs.EndDate),'mmm yy')

-- Nodes_Repairs_Repaired_QuantizedStartDate_Owner
SELECT Count(*),Format(CDate(TblRepairs.StartDate),'mmm yy'),TblUpdaters.UserFullName FROM [TblRepairs],[TblUpdaters] WHERE TblRepairs.IsDeleted=False AND TblRepairs.CurrentProgress=1 ORDER BY Format(CDate(TblRepairs.StartDate),'mmm yy')

-- Nodes_Repairs_Repaired_QuantizedStartDate_Project
SELECT Count(*),Format(CDate(TblRepairs.StartDate),'mmm yy'),TblProjects.ProjectName FROM [TblRepairs],[TblNodes],[TblProjects] WHERE TblRepairs.IsDeleted=False AND TblRepairs.CurrentProgress=1 ORDER BY Format(CDate(TblRepairs.StartDate),'mmm yy')

-- Nodes_Repairs_Repaired_QuantizedStartDate_Supplier
SELECT Count(*),Format(CDate(TblRepairs.StartDate),'mmm yy'),TblSuppliers.SupplierName FROM [TblRepairs],[TblNodes],[TblSuppliers] WHERE TblRepairs.IsDeleted=False AND TblRepairs.CurrentProgress=1 ORDER BY Format(CDate(TblRepairs.StartDate),'mmm yy')

-- Nodes_Storage_SAN_NodesByEnvironment
SELECT IIf(TblNodes.NodeIsActive,'Yes','No'),IIf(TblNodes.HasSANStorage,'Yes','No'),TblEnvironments.EnvironmentName,Count(TblNodes.NodeId) FROM [TblNodes],[TblEnvironments] WHERE TblNodes.NodeIsDeleted=False and TblNodes.NodeIsActive=True ORDER BY Count(TblNodes.NodeId)

-- Nodes_Storage_SAN_NodesByProject
SELECT IIf(TblNodes.NodeIsActive,'Yes','No'),IIf(TblNodes.HasSANStorage,'Yes','No'),TblProjects.ProjectName,Count(TblNodes.NodeId) FROM [TblNodes],[TblProjects] WHERE TblNodes.NodeIsDeleted=False and TblNodes.NodeIsActive=True ORDER BY Count(TblNodes.NodeId)

-- Nodes_Storage_SAN_NodesBySystemType
SELECT IIf(TblNodes.NodeIsActive,'Yes','No'),IIf(TblNodes.HasSANStorage,'Yes','No'),TblSystemType.SystemTypeName,Count(TblNodes.NodeId) FROM [TblNodes],[TblSystemType] WHERE TblNodes.NodeIsDeleted=False and TblNodes.NodeIsActive=True ORDER BY Count(TblNodes.NodeId)

-- Nodes_Storage_SAN_Wintel_NodesByEnvironment
SELECT IIf(TblNodes.NodeIsActive,'Yes','No'),IIf(TblNodes.HasSANStorage,'Yes','No'),TblEnvironments.EnvironmentName,Count(TblNodes.NodeId) FROM [TblNodes],[TblEnvironments] WHERE TblNodes.NodeIsDeleted=False And TblNodes.NodeIsActive=True And TblNodes.SystemTypeId In (3,4,5,6,18,19,20,21,22) And TblNodes.NodeTypeId Not In (11,15) ORDER BY Count(TblNodes.NodeId)

-- Nodes_Storage_SAN_Wintel_NodesByNodeType
SELECT IIf(TblNodes.NodeIsActive,'Yes','No'),IIf(TblNodes.HasSANStorage,'Yes','No'),TblNodeTypes.NodeTypeName,Count(TblNodes.NodeId) FROM [TblNodes],[TblNodeTypes] WHERE TblNodes.NodeIsDeleted=False and TblNodes.NodeIsActive=True and TblNodes.SystemTypeId in (3,4,5,6,18,19,20,21,22) And TblNodes.NodeTypeId Not In (11,15) ORDER BY Count(TblNodes.NodeId)

-- Nodes_Storage_SAN_Wintel_NodesByProject
SELECT IIf(TblNodes.NodeIsActive,'Yes','No'),IIf(TblNodes.HasSANStorage,'Yes','No'),TblProjects.ProjectName,Count(TblNodes.NodeId) FROM [TblNodes],[TblProjects] WHERE TblNodes.NodeIsDeleted=False and TblNodes.NodeIsActive=True and TblNodes.SystemTypeId in (3,4,5,6,18,19,20,21,22) And TblNodes.NodeTypeId Not In (11,15) ORDER BY Count(TblNodes.NodeId)

-- Nodes_Storage_SAN_Wintel_NodesByRole
SELECT IIf(TblNodes.NodeIsActive,'Yes','No'),IIf(TblNodes.HasSANStorage,'Yes','No'),TblRoles.RoleName,Count(TblNodes.NodeId) FROM [TblNodes],[TblRoles] WHERE TblNodes.NodeIsDeleted=False and TblNodes.NodeIsActive=True and TblNodes.SystemTypeId in (3,4,5,6,18,19,20,21,22) And TblNodes.NodeTypeId Not In (11,15) ORDER BY Count(TblNodes.NodeId)

-- Nodes_Summary_ActiveNodes
SELECT Count(TblNodes.NodeId),TblNodes.NodeIsActive FROM [TblNodes] WHERE TblNodes.NodeIsDeleted=False 

-- Nodes_Summary_Chassis_FreeSlots_BySupplier_Location
SELECT COUNT(*),SUM(TblNodes.MaxSlots-TblNodes.AssignedSlots),TblSuppliers.SupplierName,TblEnvironments.EnvironmentName,IIf(TblNodes.HasSANStorage,"Yes","No"),TblProductionScopes.ProductionScopeName,TblVirtualDatacenters.VirtualDatacenterName FROM [TblNodes],[TblSuppliers],[TblEnvironments],[TblProductionScopes],[TblVirtualDatacenters] WHERE TblNodes.NodeIsDeleted=False And TblNodes.NodeIsActive=True And TblNodes.NodeTypeId=11 ORDER BY SUM(TblNodes.MaxSlots-TblNodes.AssignedSlots)

-- Nodes_Summary_Chassis_FreeSlots_Detail
SELECT TblNodes.NodeName,TblNodes.MaxSlots-TblNodes.AssignedSlots,TblSuppliers.SupplierName,TblNodes.NodeModel,TblEnvironments.EnvironmentName,IIf(TblNodes.HasSANStorage,"Yes","No"),TblProductionScopes.ProductionScopeName,TblVirtualDatacenters.VirtualDatacenterName FROM [TblNodes],[TblSuppliers],[TblEnvironments],[TblProductionScopes],[TblVirtualDatacenters] WHERE TblNodes.NodeIsDeleted=False And TblNodes.NodeIsActive=True And TblNodes.NodeTypeId=11 ORDER BY TblNodes.MaxSlots-TblNodes.AssignedSlots

-- Nodes_Summary_NodesByBusinessArea
SELECT TmpTable.BusinessAreaName,COUNT(TmpTable.ProjectName),SUM(TmpTable.Nodes) FROM [] ORDER BY SUM(TmpTable.Nodes)

-- Nodes_Summary_NodesByBusinessArea_Projects
SELECT TblBusinessAreas.BusinessAreaName,TblProjects.ProjectName,COUNT(TblNodes.NodeId) FROM [TblProjects],[TblNodes],[TblBusinessAreas] WHERE TblNodes.NodeIsDeleted=False ORDER BY COUNT(TblNodes.NodeId)

-- Nodes_Summary_NodesByBusinessArea_ServiceManager_Projects
SELECT TmpTable.BusinessAreaName,TmpTable.UserFullName,TmpTable.ProjectName,SUM(TmpTable.Nodes) FROM [] ORDER BY TmpTable.BusinessAreaName

-- Nodes_Summary_NodesByEnvironment
SELECT TblEnvironments.EnvironmentName,Count(TblNodes.NodeId) FROM [TblEnvironments],[TblNodes] WHERE TblNodes.NodeIsDeleted=False ORDER BY Count(TblNodes.NodeId)

-- Project_Tasks_Status
SELECT TblProjects.ProjectName,AssignedTasks.IsUnplanned,TblTasks.IsBlocked,TblTasks.IsFreezed,COUNT(TblTasks.TaskId) FROM [TblProjects],[TblTasks],[] WHERE TblProjects.ProjectName=[Project Name] ORDER BY TblTasks.IsBlocked

-- Project_Tasks_StatusKPI
SELECT TblProjects.ProjectName,TmpGlobalStatus.StatusName,TmpRiskStatus.StatusName,TmpExecutionStatus.StatusName,TmpScopeStatus.StatusName,TmpBugdetStatus.StatusName,TmpResourcesStatus.StatusName,TmpEffortAndDedicationStatus.StatusName,COUNT(TblTasks.TaskId) FROM [TblProjects],[TblTasks],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus] WHERE TblProjects.ProjectName=[Project Name] ORDER BY TblProjects.ProjectName

-- Project_Tasks_WorkTime
SELECT TblProjects.ProjectName,TblTasks.WorkTime,COUNT(TblTasks.TaskId) FROM [TblProjects],[TblTasks] WHERE TblProjects.ProjectName=[Project Name] ORDER BY TblTasks.WorkTime

-- Projects_OrphanProjects
SELECT TblProjects.ProjectName FROM [TblProjects] WHERE TblProjects.ProjectName NOT IN (
  SELECT TblProjects.ProjectName AS Project
  FROM TblProjects INNER JOIN TblNodes ON TblProjects.ProjectId = TblNodes.MainProjectId
  GROUP BY TblProjects.ProjectName) 

-- Projects_TotalProjects
SELECT COUNT(TblProjects.ProjectId) FROM [TblProjects] 

-- ProvisioningProjects_Delivered_Detail
SELECT TblProvisioningProjects.ProvisioningProjectId,TblProvisioningProjects.ProvisioningProjectName,TblProvisioningProjects.ProvisioningProjectLabel,TblProvisioningProjects.IsDeleted,TblProjects.ProjectName,TblUpdaters.UserFullName,TblPriorities.PriorityName,TblVisibilities.VisibilityName,TblImpacts.ImpactName,Format(TblProvisioningProjects.CurrentProgress,"#0.00%"),TblProvisioningProjects.IsBlocked,TblProvisioningProjects.IsFreezed,Format(TblProvisioningProjects.StartDate,"Short Date"),Format(TblProvisioningProjects.ProposalApprovalDate,"Short Date"),Format(TblProvisioningProjects.AcquisitionDate,"Short Date"),Format(TblProvisioningProjects.SupplierDeliveryDate,"Short Date"),Format(TblProvisioningProjects.ScheduledEndDate,"Short Date"),Format(TblProvisioningProjects.EndDate,"Short Date"),TmpGlobalStatus.StatusName,TmpRiskStatus.StatusName,TmpExecutionStatus.StatusName,TmpScopeStatus.StatusName,TmpBudgetStatus.StatusName,TmpResourcesStatus.StatusName,TmpEffortAndDedicationStatus.StatusName,TblProvisioningProjects.WorkTime,TblProvisioningProjects.ResourcesInvolved,Format(TblProvisioningProjects.LastUpdateDate,"Short Date"),TblProvisioningProjects.UpdateCount,TblProvisioningProjects.ReschedulingCount FROM [TblProvisioningProjects],[TblUpdaters],[TblPriorities],[TblVisibilities],[TblImpacts],[TblProjects],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus] WHERE TblProvisioningProjects.IsDeleted=False AND TblProvisioningProjects.CurrentProgress=1 

-- ProvisioningProjects_Delivered_QuantizedEndDate
SELECT Count(*),Format(CDate(TblProvisioningProjects.EndDate),'mmm yy') FROM [TblProvisioningProjects] WHERE TblProvisioningProjects.IsDeleted=False AND TblProvisioningProjects.CurrentProgress=1 AND NOT IsNull(TblProvisioningProjects.EndDate) ORDER BY Format(CDate(TblProvisioningProjects.EndDate),'mmm yy')

-- ProvisioningProjects_Delivered_QuantizedEndDate_Project
SELECT Count(*),Format(CDate(TblProvisioningProjects.EndDate),'mmm yy'),Count(TblProjects.ProjectName) FROM [TblProvisioningProjects],[TblProjects] WHERE TblProvisioningProjects.IsDeleted=False AND TblProvisioningProjects.CurrentProgress=1 AND NOT IsNull(TblProvisioningProjects.EndDate) ORDER BY Format(CDate(TblProvisioningProjects.EndDate),'mmm yy')

-- ProvisioningProjects_Delivered_QuantizedEndDate_Project_Detail
SELECT Count(*),Format(CDate(TblProvisioningProjects.EndDate),'mmm yy'),TblProjects.ProjectName FROM [TblProvisioningProjects],[TblProjects] WHERE TblProvisioningProjects.IsDeleted=False AND TblProvisioningProjects.CurrentProgress=1 AND NOT IsNull(TblProvisioningProjects.EndDate) ORDER BY Format(CDate(TblProvisioningProjects.EndDate),'mmm yy')

-- ProvisioningProjects_Delivered_QuantizedEndDate_TotalNodes
SELECT Count(*),Format(CDate(TblProvisioningProjects.EndDate),'mmm yy'),sum(TmpProvisioningProjectDetails.TotalNodes) FROM [TblProvisioningProjects],[] WHERE TblProvisioningProjects.IsDeleted=False AND TblProvisioningProjects.CurrentProgress=1 AND NOT IsNull(TblProvisioningProjects.EndDate) ORDER BY Format(CDate(TblProvisioningProjects.EndDate),'mmm yy')

-- ProvisioningProjects_Delivered_QuantizedStartDate_Project
SELECT Count(*),Format(CDate(TblProvisioningProjects.StartDate),'mmm yy'),Count(TblProjects.ProjectName) FROM [TblProvisioningProjects],[TblProjects] WHERE TblProvisioningProjects.IsDeleted=False AND TblProvisioningProjects.CurrentProgress=1 ORDER BY Format(CDate(TblProvisioningProjects.StartDate),'mmm yy')

-- ProvisioningProjects_Delivered_QuantizedStartDate_Project_Detail
SELECT Count(*),Format(CDate(TblProvisioningProjects.StartDate),'mmm yy'),TblProjects.ProjectName FROM [TblProvisioningProjects],[TblProjects] WHERE TblProvisioningProjects.IsDeleted=False AND TblProvisioningProjects.CurrentProgress=1 ORDER BY Format(CDate(TblProvisioningProjects.StartDate),'mmm yy')

-- ProvisioningProjects_Delivered_QuantizedStartDate_TotalNodes
SELECT Count(*),Format(CDate(TblProvisioningProjects.StartDate),'mmm yy'),sum(TmpProvisioningProjectDetails.TotalNodes) FROM [TblProvisioningProjects],[] WHERE TblProvisioningProjects.IsDeleted=False AND TblProvisioningProjects.CurrentProgress=1 ORDER BY Format(CDate(TblProvisioningProjects.StartDate),'mmm yy')

-- ProvisioningProjects_Pending_Detail
SELECT TblProvisioningProjects.ProvisioningProjectId,TblProvisioningProjects.ProvisioningProjectName,TblProvisioningProjects.ProvisioningProjectLabel,TblProvisioningProjects.IsDeleted,TblProjects.ProjectName,TblUpdaters.UserFullName,TblPriorities.PriorityName,TblVisibilities.VisibilityName,TblImpacts.ImpactName,Format(TblProvisioningProjects.CurrentProgress,"#0.00%"),TblProvisioningProjects.IsBlocked,TblProvisioningProjects.IsFreezed,Format(TblProvisioningProjects.StartDate,"Short Date"),Format(TblProvisioningProjects.ProposalApprovalDate,"Short Date"),Format(TblProvisioningProjects.AcquisitionDate,"Short Date"),Format(TblProvisioningProjects.SupplierDeliveryDate,"Short Date"),Format(TblProvisioningProjects.ScheduledEndDate,"Short Date"),Format(TblProvisioningProjects.EndDate,"Short Date"),TmpGlobalStatus.StatusName,TmpRiskStatus.StatusName,TmpExecutionStatus.StatusName,TmpScopeStatus.StatusName,TmpBudgetStatus.StatusName,TmpResourcesStatus.StatusName,TmpEffortAndDedicationStatus.StatusName,TblProvisioningProjects.WorkTime,TblProvisioningProjects.ResourcesInvolved,Format(TblProvisioningProjects.LastUpdateDate,"Short Date"),TblProvisioningProjects.UpdateCount,TblProvisioningProjects.ReschedulingCount FROM [TblProvisioningProjects],[TblUpdaters],[TblPriorities],[TblVisibilities],[TblImpacts],[TblProjects],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus] WHERE TblProvisioningProjects.IsDeleted=False AND TblProvisioningProjects.CurrentProgress<1 

-- ProvisioningProjects_Pending_QuantizedStartDate
SELECT Count(*),Format(CDate(TblProvisioningProjects.StartDate),'mmm yy') FROM [TblProvisioningProjects] WHERE TblProvisioningProjects.IsDeleted=False AND TblProvisioningProjects.CurrentProgress<1 ORDER BY Format(CDate(TblProvisioningProjects.StartDate),'mmm yy')

-- ProvisioningProjects_Pending_QuantizedStartDate_Project
SELECT Count(*),Format(CDate(TblProvisioningProjects.StartDate),'mmm yy'),Count(TblProjects.ProjectName) FROM [TblProvisioningProjects],[TblProjects] WHERE TblProvisioningProjects.IsDeleted=False AND TblProvisioningProjects.CurrentProgress<1 ORDER BY Format(CDate(TblProvisioningProjects.StartDate),'mmm yy')

-- ProvisioningProjects_Pending_QuantizedStartDate_TotalNodes
SELECT Count(*),Format(CDate(TblProvisioningProjects.StartDate),'mmm yy'),sum(TmpProvisioningProjectDetails.TotalNodes) FROM [TblProvisioningProjects],[] WHERE TblProvisioningProjects.IsDeleted=False AND TblProvisioningProjects.CurrentProgress<1 ORDER BY Format(CDate(TblProvisioningProjects.StartDate),'mmm yy')

-- Tasks_ProgressReport_Simple
SELECT TblTasks.TaskId,RelProgressReports2Tasks.IsUnplanned,TblTasks.IsBlocked,TblTasks.IsFreezed,RelProgressReports2Tasks.AssignedExecutionOrder,TblTasks.TaskName,TblTasks.CurrentProgress,TblPriorities.PriorityName,TblVisibilities.VisibilityName,TblImpacts.ImpactName,TblKpiStatus.StatusName,TblUpdaters.UserFullname,TblTasks.ScheduledEndDate,TblTasks.ReschedulingCount,TblTaskCategories.CategoryName,TblProjects.ProjectName,TblTasks.EndDate,TblTasks.LastUpdateDate FROM [TblTasks],[RelProgressReports2Tasks],[TblPriorities],[TblVisibilities],[TblImpacts],[TblKpiStatus],[TblUpdaters],[TblTaskCategories],[TblProjects] WHERE (((RelProgressReports2Tasks.ProgressReportId)=[Progress Report Id])) 

-- Tasks_TeamProgressByPeriod_ActivityType
SELECT RelClosedProgressReports2Tasks.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,TblTaskCategories.CategoryName,Count(TblTasks.TaskId) FROM [TblTasks],[TblProgressReports],[RelClosedProgressReports2Tasks],[TblTeams],[TblProjects],[TblTaskCategories] WHERE TblTeams.TeamName<>"N/A" ORDER BY RelClosedProgressReports2Tasks.ProgressReportId

-- Tasks_TeamProgressByPeriod_EffortAndDedication
SELECT RelClosedProgressReports2Tasks.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,TblKpiStatus.StatusName,Count(TblTasks.TaskId) FROM [TblTasks],[TblProgressReports],[RelClosedProgressReports2Tasks],[TblTeams],[TblProjects],[TblKpiStatus] WHERE TblTeams.TeamName<>"N/A" 

-- Tasks_TeamProgressByPeriod_EffortAndDedication_Projects
SELECT RelClosedProgressReports2Tasks.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,TblKpiStatus.StatusName,TmpProjects.ProjectName,Count(TblTasks.TaskId) FROM [TblTasks],[TblProgressReports],[RelClosedProgressReports2Tasks],[TblTeams],[TblProjects],[TblKpiStatus],[TblProjects] WHERE TblTeams.TeamName<>"N/A" 

-- Tasks_TeamProgressByPeriod_Impact
SELECT RelClosedProgressReports2Tasks.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,TblImpacts.ImpactName,Count(TblTasks.TaskId) FROM [TblTasks],[TblProgressReports],[RelClosedProgressReports2Tasks],[TblTeams],[TblProjects],[TblImpacts] WHERE TblTeams.TeamName<>"N/A" ORDER BY RelClosedProgressReports2Tasks.ProgressReportId

-- Tasks_TeamProgressByPeriod_Priority
SELECT RelClosedProgressReports2Tasks.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,TblPriorities.PriorityName,Count(TblTasks.TaskId) FROM [TblTasks],[TblProgressReports],[RelClosedProgressReports2Tasks],[TblTeams],[TblProjects],[TblPriorities] WHERE TblTeams.TeamName<>"N/A" ORDER BY RelClosedProgressReports2Tasks.ProgressReportId

-- Tasks_TeamProgressByPeriod_Priority_Projects
SELECT RelClosedProgressReports2Tasks.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,TblPriorities.PriorityName,TmpProjects.ProjectName,Count(TblTasks.TaskId) FROM [TblTasks],[TblProgressReports],[RelClosedProgressReports2Tasks],[TblTeams],[TblProjects],[TblPriorities],[TblProjects] WHERE TblTeams.TeamName<>"N/A" ORDER BY RelClosedProgressReports2Tasks.ProgressReportId

-- Tasks_TeamProgressByPeriod_Progress_AvailableResCount
SELECT RelClosedProgressReports2Tasks.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,TblProgressReports.AvailableResCount,TblTasks.CurrentProgress,Count(TblTasks.TaskId),Round([TotalTasks]/TblProgressReports.AvailableResCount,2) FROM [TblTasks],[TblProgressReports],[RelClosedProgressReports2Tasks],[TblTeams],[TblProjects] WHERE TblTeams.TeamName<>"N/A" ORDER BY RelClosedProgressReports2Tasks.ProgressReportId

-- Tasks_TeamProgressByPeriod_Project
SELECT RelClosedProgressReports2Tasks.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,TmpProjects.ProjectName,Count(TblTasks.TaskId) FROM [TblTasks],[TblProgressReports],[RelClosedProgressReports2Tasks],[TblTeams],[TblProjects],[TblProjects] WHERE TblTeams.TeamName<>"N/A" ORDER BY RelClosedProgressReports2Tasks.ProgressReportId

-- Tasks_TeamProgressByPeriod_Relevance
SELECT RelClosedProgressReports2Tasks.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,TblPriorities.PriorityName,TblVisibilities.VisibilityName,TblImpacts.ImpactName,TblKpiStatus.StatusName,Count(TblTasks.TaskId) FROM [TblTasks],[TblProgressReports],[RelClosedProgressReports2Tasks],[TblTeams],[TblProjects],[TblPriorities],[TblVisibilities],[TblImpacts],[TblKpiStatus] WHERE TblTeams.TeamName<>"N/A" ORDER BY RelClosedProgressReports2Tasks.ProgressReportId

-- Tasks_TeamProgressByPeriod_Rescheduling
SELECT RelClosedProgressReports2Tasks.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,TblTasks.ReschedulingCount,Count(TblTasks.TaskId) FROM [TblTasks],[TblProgressReports],[RelClosedProgressReports2Tasks],[TblTeams],[TblProjects] WHERE TblTeams.TeamName<>"N/A" ORDER BY RelClosedProgressReports2Tasks.ProgressReportId

-- Tasks_TeamProgressByPeriod_TeamActivity
SELECT RelClosedProgressReports2Tasks.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,TmpTeams.TeamName,Count(TblTasks.TaskId) FROM [TblTasks],[TblProgressReports],[RelClosedProgressReports2Tasks],[TblTeams],[TblProjects],[TblTeams] WHERE TblTeams.TeamName<>"N/A" 

-- Tasks_TeamProgressByPeriod_TeamActivity_AvailableResCount
SELECT RelClosedProgressReports2Tasks.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,TmpTeams.TeamName,TblProgressReports.AvailableResCount,Count(TblTasks.TaskId),Round(TotalTasks/TblProgressReports.AvailableResCount,2) FROM [TblTasks],[TblProgressReports],[RelClosedProgressReports2Tasks],[TblTeams],[TblProjects],[TblTeams] WHERE TblTeams.TeamName<>"N/A" 

-- Tasks_TeamProgressByPeriod_TeamActivity_TeamMember
SELECT RelClosedProgressReports2Tasks.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,TmpTeams.TeamName,TblUpdaters.UserFullName,Count(TblTasks.TaskId) FROM [TblTasks],[TblProgressReports],[RelClosedProgressReports2Tasks],[TblTeams],[TblProjects],[TblTeams],[TblUpdaters] WHERE TblTeams.TeamName<>"N/A" 

-- Tasks_TeamProgressByPeriod_Unplanned
SELECT RelClosedProgressReports2Tasks.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,RelClosedProgressReports2Tasks.IsUnplanned,Count(TblTasks.TaskId) FROM [TblTasks],[TblProgressReports],[RelClosedProgressReports2Tasks],[TblTeams],[TblProjects] WHERE TblTeams.TeamName<>"N/A" 

-- Tasks_TeamProgressByPeriod_Unpplanned_ActivityType
SELECT RelClosedProgressReports2Tasks.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,RelClosedProgressReports2Tasks.IsUnplanned,TblTaskCategories.CategoryName,Count(TblTasks.TaskId) FROM [TblTasks],[TblProgressReports],[RelClosedProgressReports2Tasks],[TblTeams],[TblProjects],[TblTaskCategories] WHERE TblTeams.TeamName<>"N/A" ORDER BY RelClosedProgressReports2Tasks.ProgressReportId

-- Tasks_TeamProgressByPeriod_Unpplanned_Projects
SELECT RelClosedProgressReports2Tasks.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,RelClosedProgressReports2Tasks.IsUnplanned,TmpProjects.ProjectName,Count(TblTasks.TaskId) FROM [TblTasks],[TblProgressReports],[RelClosedProgressReports2Tasks],[TblTeams],[TblProjects],[TblProjects] WHERE TblTeams.TeamName<>"N/A" ORDER BY RelClosedProgressReports2Tasks.ProgressReportId

-- Team_ClosedTasks_ActivityType
SELECT TblTaskCategories.CategoryName,count(TblTasks.TaskId) FROM [TblTasks],[TblTeams],[TblTaskCategories] WHERE TblTeams.TeamName=[Team Name] And TblTasks.CurrentProgress=1 ORDER BY count(TblTasks.TaskId)

-- Team_ClosedTasks_Age_Project
SELECT TblProjects.ProjectName,Round((TblTasks.EndDate-TblTasks.StartDate),1),count(TblTasks.TaskId) FROM [TblTasks],[TblTeams],[TblProjects] WHERE TblTeams.TeamName=[Team Name] And TblTasks.CurrentProgress=1 ORDER BY Round((TblTasks.EndDate-TblTasks.StartDate),1)

-- Team_ClosedTasks_Age_Project_Priority
SELECT TblProjects.ProjectName,TblPriorities.PriorityName,Round((TblTasks.EndDate-TblTasks.StartDate),1),count(TblTasks.TaskId) FROM [TblTasks],[TblTeams],[TblProjects],[TblPriorities] WHERE TblTeams.TeamName=[Team Name] And TblTasks.CurrentProgress=1 ORDER BY Round((TblTasks.EndDate-TblTasks.StartDate),1)

-- Team_ClosedTasks_Priority
SELECT TblPriorities.PriorityName,count(TblTasks.TaskId) FROM [TblTasks],[TblTeams],[TblPriorities] WHERE TblTeams.TeamName=[Team Name] And TblTasks.CurrentProgress=1 ORDER BY count(TblTasks.TaskId)

-- Team_ClosedTasks_Project
SELECT TblProjects.ProjectName,count(TblTasks.TaskId) FROM [TblTasks],[TblTeams],[TblProjects] WHERE TblTeams.TeamName=[Team Name] And TblTasks.CurrentProgress=1 ORDER BY count(TblTasks.TaskId)

-- Team_ClosedTasks_ReschedulingCount_Project
SELECT TblProjects.ProjectName,TblTasks.ReschedulingCount,count(TblTasks.TaskId) FROM [TblTasks],[TblTeams],[TblProjects] WHERE TblTeams.TeamName=[Team Name] And TblTasks.CurrentProgress=1 ORDER BY TblTasks.ReschedulingCount

-- Team_ClosedTasks_ReschedulingCount_Project_Priority
SELECT TblProjects.ProjectName,TblPriorities.PriorityName,TblTasks.ReschedulingCount,count(TblTasks.TaskId) FROM [TblTasks],[TblTeams],[TblProjects],[TblPriorities] WHERE TblTeams.TeamName=[Team Name] And TblTasks.CurrentProgress=1 ORDER BY TblTasks.ReschedulingCount

-- Team_LiveIssues_Age
SELECT TblIssues.ProjectId,TblIssues.IsARisk,TblIssues.SeverityStatusKPI,TblIssues.ActionStatusId,Round((Now()-TblIssues.CreationDate),2),count(TblIssues.IssueId) FROM [TblIssues],[TblTeams] WHERE TblTeams.TeamName=[Team Name] And TblIssues.IsDeleted=False And TblIssues.ActionStatusId In (1,2,3,4,9,10) ORDER BY TblIssues.ProjectId

-- Team_LiveIssues_RisksMap
SELECT TblIssues.ProjectId,TblIssues.SeverityStatusKPI,TblIssues.ActionStatusId,Round((TblIssues.OccurenceProbability*100)*TblIssues.SeverityStatusKPI,0),count(TblIssues.IssueId) FROM [TblIssues],[TblTeams] WHERE TblIssues.IsARisk=True And TblTeams.TeamName=[Team Name] And TblIssues.IsDeleted=False And TblIssues.ActionStatusId In (1,2,3,4,9,10) ORDER BY TblIssues.ProjectId

-- Team_LiveTasks_Age_Priority
SELECT TblPriorities.PriorityName,Round((TblTasks.EndDate-TblTasks.StartDate),1),count(TblTasks.TaskId) FROM [TblTasks],[TblTeams],[TblPriorities] WHERE TblTeams.TeamName=[Team Name] And TblTasks.CurrentProgress<1 ORDER BY Round((TblTasks.EndDate-TblTasks.StartDate),1)

-- Team_LiveTasks_Age_Project
SELECT TblProjects.ProjectName,Round((TblTasks.EndDate-TblTasks.StartDate),1),count(TblTasks.TaskId) FROM [TblTasks],[TblTeams],[TblProjects] WHERE TblTeams.TeamName=[Team Name] And TblTasks.CurrentProgress<1 ORDER BY Round((TblTasks.EndDate-TblTasks.StartDate),1)

-- Team_LiveTasks_Age_Project_Priority
SELECT TblProjects.ProjectName,TblPriorities.PriorityName,Round((TblTasks.EndDate-TblTasks.StartDate),1),count(TblTasks.TaskId) FROM [TblTasks],[TblTeams],[TblProjects],[TblPriorities] WHERE TblTeams.TeamName=[Team Name] And TblTasks.CurrentProgress<1 ORDER BY Round((TblTasks.EndDate-TblTasks.StartDate),1)

-- Team_LiveTasks_Age_Project_Progress
SELECT TblProjects.ProjectName,TblTasks.CurrentProgress,Round((Now()-TblTasks.CreationDate),1),count(TblTasks.TaskId) FROM [TblTasks],[TblTeams],[TblProjects] WHERE TblTeams.TeamName=[Team Name] And TblTasks.CurrentProgress<1 ORDER BY TblProjects.ProjectName

-- Team_LiveTasks_Age_QuantizedProgress
SELECT ROUND(((TblTasks.CurrentProgress*100)/10),0),SUM(ABS(ROUND((Now()-TblTasks.CreationDate),2))),COUNT(TblTasks.TaskId) FROM [TblTasks],[TblTeams] WHERE TblTeams.TeamName=[Team Name] And TblTasks.CurrentProgress<1 ORDER BY ROUND(((TblTasks.CurrentProgress*100)/10),0)

-- Team_LiveTasks_ReschedulingCount_Project_Priority
SELECT TblProjects.ProjectName,TblPriorities.PriorityName,TblTasks.ReschedulingCount,count(TblTasks.TaskId) FROM [TblTasks],[TblTeams],[TblProjects],[TblPriorities] WHERE TblTeams.TeamName=[Team Name] And TblTasks.CurrentProgress<1 ORDER BY TblTasks.ReschedulingCount

-- Team_LiveTasks_ReschedulingCount_Project_Progress
SELECT TblProjects.ProjectName,TblTasks.CurrentProgress,TblTasks.ReschedulingCount,count(TblTasks.TaskId) FROM [TblTasks],[TblTeams],[TblProjects] WHERE TblTeams.TeamName=[Team Name] And TblTasks.CurrentProgress<1 ORDER BY TblProjects.ProjectName

-- Team_LiveTasks_ReschedulingCount_Project_QuantizedProgress
SELECT TblProjects.ProjectName,ROUND(((TblTasks.CurrentProgress*100)/25),0),TblTasks.ReschedulingCount,COUNT(TblTasks.TaskId) FROM [TblTasks],[TblTeams],[TblProjects] WHERE TblTeams.TeamName=[Team Name] And TblTasks.CurrentProgress<1 ORDER BY TblProjects.ProjectName

-- Team_Summary_Issues
SELECT TblProjects.ProjectName,TblIssues.IsARisk,TblKpiStatus.StatusName,TblActionStatus.StatusName,count(TblIssues.IssueId) FROM [TblIssues],[TblTeams],[TblProjects],[TblKpiStatus],[TblActionStatus] WHERE TblTeams.TeamName=[Team Name] And TblIssues.IsDeleted=False ORDER BY TblProjects.ProjectName

-- Team_Summary_Issues_Age
SELECT TblProjects.ProjectName,TblIssues.IsARisk,TblKpiStatus.StatusName,TblActionStatus.StatusName,Round((TblIssues.ResolutionDate-TblIssues.CreationDate),2),count(TblIssues.IssueId) FROM [TblIssues],[TblTeams],[TblProjects],[TblKpiStatus],[TblActionStatus] WHERE TblTeams.TeamName=[Team Name] And TblIssues.IsDeleted=False And TblIssues.ActionStatusId Not In (1,2,3,4,9,10) ORDER BY TblProjects.ProjectName

-- Team_Summary_ManagedRisks
SELECT TblProjects.ProjectName,TblKpiStatus.StatusName,TblActionStatus.StatusName,Round((TblIssues.OccurenceProbability*100)*TblIssues.SeverityStatusKPI,0),count(TblIssues.IssueId) FROM [TblIssues],[TblTeams],[TblProjects],[TblKpiStatus],[TblActionStatus] WHERE TblIssues.IsARisk=True And TblTeams.TeamName=[Team Name] And TblIssues.IsDeleted=False And TblIssues.ActionStatusId Not In (1,2,3,4,9,10) ORDER BY TblProjects.ProjectName

-- Team_Summary_TasksActivityType_Project
SELECT TblProjects.ProjectName,TblTaskCategories.CategoryName,count(TblTasks.TaskId) FROM [TblTasks],[TblTeams],[TblTaskCategories],[TblProjects] WHERE TblTeams.TeamName=[Team Name] ORDER BY count(TblTasks.TaskId)

-- Team_Summary_TasksRelevanceMap
SELECT TblPriorities.PriorityName,TblVisibilities.VisibilityName,TblImpacts.ImpactName,TblKpiStatus.StatusName,count(TblTasks.TaskId) FROM [TblTasks],[TblTeams],[TblPriorities],[TblVisibilities],[TblImpacts],[TblKpiStatus] WHERE TblTeams.TeamName=[Team Name] ORDER BY count(TblTasks.TaskId)

-- Team_Summary_TasksRelevanceMap_Project
SELECT TblProjects.ProjectName,TblPriorities.PriorityName,TblVisibilities.VisibilityName,TblImpacts.ImpactName,TblKpiStatus.StatusName,count(TblTasks.TaskId) FROM [TblTasks],[TblTeams],[TblProjects],[TblPriorities],[TblVisibilities],[TblImpacts],[TblKpiStatus] WHERE TblTeams.TeamName=[Team Name] ORDER BY count(TblTasks.TaskId)

-- TeamMember_ClosedTasks
SELECT TblUpdaters.UserFullName,Count(TblTasks.TaskId) FROM [TblUpdaters],[TblTasks] WHERE TblUpdaters.UserFullName=[Team Member] And TblTasks.CurrentProgress=1 

-- TeamMember_ClosedTasks_Project
SELECT TblUpdaters.UserFullName,TblProjects.ProjectName,Count(TblTasks.TaskId) FROM [TblUpdaters],[TblTasks],[TblProjects] WHERE TblUpdaters.UserFullName=[Team Member] And TblTasks.CurrentProgress=1 ORDER BY Count(TblTasks.TaskId)

-- TeamMember_ClosedTasks_Relevance
SELECT TblUpdaters.UserFullName,TblPriorities.PriorityName,TblVisibilities.VisibilityName,TblImpacts.ImpactName,TblKpiStatus.StatusName,Count(TblTasks.TaskId) FROM [TblTasks],[TblUpdaters],[TblPriorities],[TblVisibilities],[TblImpacts],[TblKpiStatus] WHERE TblUpdaters.UserFullName=[Team Member] And TblTasks.CurrentProgress=1 ORDER BY Count(TblTasks.TaskId)

-- TeamMember_ClosedTasks_ReschedulingCount
SELECT TblUpdaters.UserFullName,TblTasks.ReschedulingCount,Count(TblTasks.TaskId) FROM [TblUpdaters],[TblTasks] WHERE TblUpdaters.UserFullName=[Team Member] And TblTasks.CurrentProgress=1 ORDER BY TblTasks.ReschedulingCount

-- TeamMember_ClosedTasks_ResourcesInvolved
SELECT TblUpdaters.UserFullName,TblTasks.ResourcesInvolved,Count(TblTasks.TaskId) FROM [TblUpdaters],[TblTasks] WHERE TblUpdaters.UserFullName=[Team Member] And TblTasks.CurrentProgress=1 ORDER BY TblTasks.ResourcesInvolved

-- TeamMember_ClosedTasks_Status
SELECT TblUpdaters.UserFullName,AssignedTasks.IsUnplanned,TblTasks.IsBlocked,TblTasks.IsFreezed,COUNT(TblTasks.TaskId) FROM [TblTasks],[TblUpdaters],[] WHERE TblUpdaters.UserFullName=[Team Member] AND  TblTasks.CurrentProgress = 1 ORDER BY TblTasks.IsBlocked

-- TeamMember_ClosedTasks_WorkTime
SELECT TblUpdaters.UserFullName,TblTasks.WorkTime,Count(TblTasks.TaskId) FROM [TblUpdaters],[TblTasks] WHERE TblUpdaters.UserFullName=[Team Member] And TblTasks.CurrentProgress=1 ORDER BY TblTasks.WorkTime

-- TeamMember_Tasks
SELECT TblUpdaters.UserFullName,Count(TblTasks.TaskId) FROM [TblUpdaters],[TblTasks] WHERE TblUpdaters.UserFullName=[Team Member] 

-- TeamMember_Tasks_ActivityType
SELECT TblUpdaters.UserFullName,TblTaskCategories.CategoryName,Count(TblTasks.TaskId) FROM [TblUpdaters],[TblTasks],[TblTaskCategories] WHERE TblUpdaters.UserFullName=[Team Member] ORDER BY Count(TblTasks.TaskId)

-- TeamMember_Tasks_Project
SELECT TblUpdaters.UserFullName,TblProjects.ProjectName,Count(TblTasks.TaskId) FROM [TblUpdaters],[TblTasks],[TblProjects] WHERE TblUpdaters.UserFullName=[Team Member] ORDER BY Count(TblTasks.TaskId)

-- TeamMember_Tasks_Relevance
SELECT TblUpdaters.UserFullName,TblPriorities.PriorityName,TblVisibilities.VisibilityName,TblImpacts.ImpactName,TblKpiStatus.StatusName,Count(TblTasks.TaskId) FROM [TblTasks],[TblUpdaters],[TblPriorities],[TblVisibilities],[TblImpacts],[TblKpiStatus] WHERE TblUpdaters.UserFullName=[Team Member] ORDER BY Count(TblTasks.TaskId)

-- TeamMember_Tasks_ResourcesInvolved
SELECT TblUpdaters.UserFullName,TblTasks.ResourcesInvolved,Count(TblTasks.TaskId) FROM [TblUpdaters],[TblTasks] WHERE TblUpdaters.UserFullName=[Team Member] ORDER BY TblTasks.ResourcesInvolved

-- TeamMember_Tasks_Status
SELECT TblUpdaters.UserFullName,AssignedTasks.IsUnplanned,TblTasks.IsBlocked,TblTasks.IsFreezed,COUNT(TblTasks.TaskId) FROM [TblTasks],[TblUpdaters],[] WHERE TblUpdaters.UserFullName=[Team Member] ORDER BY TblTasks.IsBlocked

-- TeamMember_Tasks_StatusKPIs
SELECT TblUpdaters.UserFullName,TmpGlobalStatus.StatusName,TmpRiskStatus.StatusName,TmpExecutionStatus.StatusName,TmpScopeStatus.StatusName,TmpBugdetStatus.StatusName,TmpResourcesStatus.StatusName,TmpEffortAndDedicationStatus.StatusName,Count(TblTasks.TaskId) FROM [TblTasks],[TblUpdaters],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus] WHERE TblUpdaters.UserFullName=[Team Member] ORDER BY Count(TblTasks.TaskId)

-- TeamMember_Tasks_WorkTime
SELECT TblUpdaters.UserFullName,TblTasks.WorkTime,Count(TblTasks.TaskId) FROM [TblUpdaters],[TblTasks] WHERE TblUpdaters.UserFullName=[Team Member] ORDER BY TblTasks.WorkTime

-- _GetHypervisor
SELECT TblNodes.NodeId,TblNodes.NodeName FROM [TblNodes],[TblVirtualDatacenters],[TblProductionScopes],[TblProjects],[TblEnvironments],[TblSystemType],[TblMajorPatchlevels],[TblRoles],[TblClusterTypes],[TblNodeTypes] WHERE TblNodes.NodeId IN (0,1,2,3) or (TblNodes.NodeIsDeleted=False And TblNodes.NodeIsActive=True And (TblSystemType.SystemTypeName Like "Windows*" or TblSystemType.SystemTypeName Like "VMWare*") And (TblRoles.RoleName like "*VMWare.server" or TblRoles.RoleName like "*HyperVServer" or TblRoles.RoleName like "*VirtualServer")) ORDER BY TblNodes.NodeId

-- _ProvisioningProjectDetailsBasicList
SELECT  FROM  

-- _QueryRelProgressReports2Tasks
SELECT RelProgressReports2Tasks.ProgressReportId,TblTasks.TaskId,RelProgressReports2Tasks.IsUnplanned,TblTasks.IsBlocked,TblTasks.IsFreezed,RelProgressReports2Tasks.AssignedExecutionOrder,TblTasks.TaskName,TblTasks.CurrentProgress,TblTasks.PriorityId,TblTasks.VisibilityId,TblTasks.ImpactId,TblTasks.EffortAndDedicationStatusKPI,TblTasks.UpdaterId,TblTasks.ScheduledEndDate,TblTasks.ReschedulingCount,TblTasks.TaskCategoryId,TblTasks.ProjectId,TblTasks.EndDate,TblTasks.LastUpdateDate FROM [TblTasks],[RelProgressReports2Tasks] ORDER BY TblTasks.UpdaterId

-- _ReportRelProgressReports2Tasks
SELECT RelProgressReports2Tasks.ProgressReportId,TblTasks.TaskId,RelProgressReports2Tasks.IsUnplanned,TblTasks.IsBlocked,TblTasks.IsFreezed,RelProgressReports2Tasks.AssignedExecutionOrder,TblTasks.TaskName,TblTasks.CurrentProgress,TblTasks.PriorityId,TblTasks.VisibilityId,TblTasks.ImpactId,TblTasks.UpdaterId,TblTasks.ScheduledEndDate,TblTasks.ReschedulingCount,TblTasks.TaskCategoryId,TblTasks.ProjectId,TblTasks.EndDate,TblTasks.LastUpdateDate FROM [TblTasks],[RelProgressReports2Tasks] WHERE RelProgressReports2Tasks.ProgressReportId=[Progress Report Id] ORDER BY TblTasks.UpdaterId

-- ~sq_c_DecommissioningHistoryView~sq_cBudgetStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_DecommissioningHistoryView~sq_cNodeId
SELECT TblNodes.NodeId,TblNodes.NodeName FROM [TblNodes] ORDER BY TblNodes.NodeName

-- ~sq_c_DecommissioningHistoryView~sq_cResourcesStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_DecommissioningHistoryView~sq_cVisibilityId
SELECT TblVisibilities.VisibilityId,TblVisibilities.VisibilityName,TblVisibilities.DisplayOrderIndex FROM [TblVisibilities] ORDER BY TblVisibilities.DisplayOrderIndex

-- ~sq_c_IssuesHistoryView~sq_cOwnerId
SELECT TblUpdaters.UserId,TblUpdaters.UserFullName,TblUpdaters.DisplayOrderIndex FROM [TblUpdaters] ORDER BY TblUpdaters.DisplayOrderIndex

-- ~sq_c_IssuesHistoryView~sq_cRelationshipTypeId
SELECT TblRelationshipType.RelationshipTypeId,TblRelationshipType.RelationshipTypeName,TblRelationshipType.DisplayOrderIndex FROM [TblRelationshipType] ORDER BY TblRelationshipType.DisplayOrderIndex

-- ~sq_c_NodeConfigurationManagement~sq_cAdminVLANId
SELECT TblNetworks.NetworkId,TblNetworks.NetworkName,TblNetworks.DisplayOrderIndex FROM [TblNetworks] ORDER BY TblNetworks.DisplayOrderIndex

-- ~sq_c_NodeConfigurationManagement~sq_cCpuTypeId
SELECT TblCpuTypes.CpuTypeId,TblCpuTypes.CpuTypeName,TblCpuTypes.DisplayOrderIndex FROM [TblCpuTypes] ORDER BY TblCpuTypes.DisplayOrderIndex

-- ~sq_c_NodeConfigurationManagement~sq_cHeartBeatVLANId
SELECT TblNetworks.NetworkId,TblNetworks.NetworkName,TblNetworks.DisplayOrderIndex FROM [TblNetworks] ORDER BY TblNetworks.DisplayOrderIndex

-- ~sq_c_NodeConfigurationManagement~sq_cMainProjectId
SELECT TblProjects.ProjectId,TblProjects.ProjectName FROM [TblProjects] 

-- ~sq_c_NodeConfigurationManagement~sq_cProductionScopeId
SELECT TblProductionScopes.ProductionScopeId,TblProductionScopes.ProductionScopeName,TblProductionScopes.DisplayOrderIndex FROM [TblProductionScopes] ORDER BY TblProductionScopes.DisplayOrderIndex

-- ~sq_c_NodeConfigurationManagement~sq_cStorageVLANId
SELECT TblNetworks.NetworkId,TblNetworks.NetworkName,TblNetworks.DisplayOrderIndex FROM [TblNetworks] ORDER BY TblNetworks.DisplayOrderIndex

-- ~sq_c_NodeDeliveryManagement~sq_cHardwareStatusId
SELECT TblNodeStatus.StatusId,TblNodeStatus.StatusName,TblNodeStatus.DisplayOrderIndex FROM [TblNodeStatus] ORDER BY TblNodeStatus.DisplayOrderIndex

-- ~sq_c_NodeDeliveryManagement~sq_cMainProjectId
SELECT TblProjects.ProjectId,TblProjects.ProjectName FROM [TblProjects] 

-- ~sq_c_NodeDeliveryManagement~sq_cProductionScopeId
SELECT TblProductionScopes.ProductionScopeId,TblProductionScopes.ProductionScopeName,TblProductionScopes.DisplayOrderIndex FROM [TblProductionScopes] ORDER BY TblProductionScopes.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cAuditExceptionsLastApproverId
SELECT TblUpdaters.UserId,TblUpdaters.UserFullName,TblUpdaters.DisplayOrderIndex FROM [TblUpdaters] ORDER BY TblUpdaters.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cClusterTypeId
SELECT TblClusterTypes.ClusterTypeId,TblClusterTypes.ClusterTypeName,TblClusterTypes.DisplayOrderIndex FROM [TblClusterTypes] ORDER BY TblClusterTypes.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cComboBoxRelProjects2Nodes
SELECT TblProjects.ProjectId,TblProjects.ProjectName FROM [TblProjects] 

-- ~sq_c_NodeHistoryView~sq_cDataCenterLocationId
SELECT TblDataCenterLocations.DataCenterLocationId,TblDataCenterLocations.DataCenterLocationName,TblDataCenterLocations.DisplayOrderIndex FROM [TblDataCenterLocations] ORDER BY TblDataCenterLocations.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cHeatBeatVLANId
SELECT TblNetworks.NetworkId,TblNetworks.NetworkName,TblNetworks.DisplayOrderIndex FROM [TblNetworks] ORDER BY TblNetworks.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cListViewRelNodes2Roles
SELECT RelNodes2Roles.RoleId,TblRoles.RoleName FROM [TblRoles],[RelNodes2Roles] WHERE RelNodes2Roles.NodeId=34 

-- ~sq_c_NodeHistoryView~sq_cMainEnvironmentId
SELECT TblEnvironments.EnvironmentId,TblEnvironments.EnvironmentName,TblEnvironments.DisplayOrderIndex FROM [TblEnvironments] ORDER BY TblEnvironments.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cMajorPatchLevelId
SELECT TblMajorPatchLevels.MajorPatchLevelId,TblMajorPatchLevels.MajorPatchLevelName,TblMajorPatchLevels.DisplayOrderIndex FROM [TblMajorPatchLevels] ORDER BY TblMajorPatchLevels.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cProductionScopeId
SELECT TblProductionScopes.ProductionScopeId,TblProductionScopes.ProductionScopeName,TblProductionScopes.DisplayOrderIndex FROM [TblProductionScopes] ORDER BY TblProductionScopes.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cSecurityClassId
SELECT TblSecurityClass.SecurityClassId,TblSecurityClass.SecurityClassName,TblSecurityClass.DisplayOrderIndex FROM [TblSecurityClass] ORDER BY TblSecurityClass.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cSecurityDomainId
SELECT TblSecurityDomains.DomainId,TblSecurityDomains.DomainName,TblSecurityDomains.DisplayOrderIndex FROM [TblSecurityDomains] ORDER BY TblSecurityDomains.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cStorageVLANId
SELECT TblNetworks.NetworkId,TblNetworks.NetworkName,TblNetworks.DisplayOrderIndex FROM [TblNetworks] ORDER BY TblNetworks.DisplayOrderIndex

-- ~sq_c_NodeHistoryView~sq_cVirtualDataCenterId
SELECT TblVirtualDataCenters.VirtualDataCenterId,TblVirtualDataCenters.VirtualDataCenterName,TblVirtualDataCenters.DisplayOrderIndex FROM [TblVirtualDataCenters] ORDER BY TblVirtualDataCenters.DisplayOrderIndex

-- ~sq_c_NodeTechnicalManagement~sq_cCpuTypeId
SELECT TblCpuTypes.CpuTypeId,TblCpuTypes.CpuTypeName,TblCpuTypes.DisplayOrderIndex FROM [TblCpuTypes] ORDER BY TblCpuTypes.DisplayOrderIndex

-- ~sq_c_NodeTechnicalManagement~sq_cHardwareAdminVLANId
SELECT TblNetworks.NetworkId,TblNetworks.NetworkName,TblNetworks.DisplayOrderIndex FROM [TblNetworks] ORDER BY TblNetworks.DisplayOrderIndex

-- ~sq_c_NodeTechnicalManagement~sq_cMainDnsZoneId
SELECT TblDnsZones.DnsZoneId,TblDnsZones.DnsZoneName,TblDnsZones.DisplayOrderIndex FROM [TblDnsZones] ORDER BY TblDnsZones.DisplayOrderIndex

-- ~sq_c_NodeTechnicalManagement~sq_cMainRoleId
SELECT TblRoles.RoleId,TblRoles.RoleName,TblRoles.DisplayOrderIndex FROM [TblRoles] ORDER BY TblRoles.DisplayOrderIndex

-- ~sq_c_NodeTechnicalManagement~sq_cParentNodeId
SELECT TblNodes.NodeId,TblNodes.NodeName FROM [TblNodes] 

-- ~sq_c_NodeTechnicalManagement~sq_cServiceVLANId
SELECT TblNetworks.NetworkId,TblNetworks.NetworkName,TblNetworks.DisplayOrderIndex FROM [TblNetworks] ORDER BY TblNetworks.DisplayOrderIndex

-- ~sq_c_NodeTechnicalManagement~sq_cSystemTypeId
SELECT TblSystemType.SystemTypeId,TblSystemType.SystemTypeName,TblSystemType.DisplayOrderIndex FROM [TblSystemType] ORDER BY TblSystemType.DisplayOrderIndex

-- ~sq_c_ProjectHistoryView~sq_cComboBoxRelProjects2Environments
SELECT TblEnvironments.EnvironmentId,TblEnvironments.EnvironmentName,TblEnvironments.DisplayOrderIndex FROM [TblEnvironments] ORDER BY TblEnvironments.DisplayOrderIndex

-- ~sq_c_ProjectHistoryView~sq_cGlobalMaturityEvaluationId
SELECT TblMaturityStatus.MaturityStatusId,TblMaturityStatus.MaturityStatusName,TblMaturityStatus.DisplayOrderIndex FROM [TblMaturityStatus] ORDER BY TblMaturityStatus.DisplayOrderIndex

-- ~sq_c_ProjectHistoryView~sq_cParentProjectId
SELECT TblProjects.ProjectId,TblProjects.ProjectName FROM [TblProjects] 

-- ~sq_c_ProjectHistoryView~sq_cResourcesStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_ProjectHistoryView~sq_cServiceCoverageId
SELECT TblServiceCoverage.CoverageId,TblServiceCoverage.CoverageName,TblServiceCoverage.DisplayOrderIndex FROM [TblServiceCoverage] ORDER BY TblServiceCoverage.DisplayOrderIndex

-- ~sq_c_ProvisioningHistoryView~sq_cBudgetStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_ProvisioningHistoryView~sq_cGlobalStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_ProvisioningHistoryView~sq_cProjectId
SELECT TblProjects.ProjectId,TblProjects.ProjectName FROM [TblProjects] ORDER BY TblProjects.ProjectName

-- ~sq_c_ProvisioningHistoryView~sq_cScopeStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_ProvisioningProjectDetails_Notes~sq_cMainEnvironmentId
SELECT TblEnvironments.EnvironmentId,TblEnvironments.EnvironmentName,TblEnvironments.DisplayOrderIndex FROM [TblEnvironments] ORDER BY TblEnvironments.DisplayOrderIndex

-- ~sq_c_ProvisioningProjectDetails_Notes~sq_cNodeStatusId
SELECT TblNodeStatus.StatusId,TblNodeStatus.StatusName,TblNodeStatus.DisplayOrderIndex FROM [TblNodeStatus] ORDER BY TblNodeStatus.DisplayOrderIndex

-- ~sq_c_ProvisioningProjectDetailsHistoryView~sq_cPriorityId
SELECT TblPriorities.PriorityId,TblPriorities.PriorityName,TblPriorities.DisplayOrderIndex FROM [TblPriorities] ORDER BY TblPriorities.DisplayOrderIndex

-- ~sq_c_RepairsHistoryView~sq_cDeliveredNodeId
SELECT TblNodes.NodeId,TblNodes.NodeName FROM [TblNodes] ORDER BY TblNodes.NodeName

-- ~sq_c_RepairsHistoryView~sq_cGlobalStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_RepairsHistoryView~sq_cOwnerId
SELECT TblUpdaters.UserId,TblUpdaters.UserFullName,TblUpdaters.DisplayOrderIndex FROM [TblUpdaters] ORDER BY TblUpdaters.DisplayOrderIndex

-- ~sq_c_RepairsHistoryView~sq_cRiskStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_RepairsHistoryView~sq_cWorkFlowStatusId
SELECT TblRepairWorkFlowStatus.StatusId,TblRepairWorkFlowStatus.StatusName,TblRepairWorkFlowStatus.DisplayOrderIndex FROM [TblRepairWorkFlowStatus] ORDER BY TblRepairWorkFlowStatus.DisplayOrderIndex

-- ~sq_c_TasksHistoryView~sq_cGlobalStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_TasksHistoryView~sq_cProjectId
SELECT TblProjects.ProjectId,TblProjects.ProjectName FROM [TblProjects] 

-- ~sq_c_TasksHistoryView~sq_cRiskStatusKPI
SELECT TblKpiStatus.StatusId,TblKpiStatus.StatusName,TblKpiStatus.DisplayOrderIndex FROM [TblKpiStatus] ORDER BY TblKpiStatus.DisplayOrderIndex

-- ~sq_c_TasksHistoryView~sq_cUpdaterId
SELECT TblUpdaters.UserId,TblUpdaters.UserFullName,TblUpdaters.DisplayOrderIndex FROM [TblUpdaters] ORDER BY TblUpdaters.DisplayOrderIndex

-- ~sq_c_TasksHistoryView~sq_cWorkStreamId
SELECT TblWorkStreams.WorkStreamId,TblWorkStreams.WorkStreamName FROM [TblWorkStreams] 

-- ~sq_cDecommissioning

-- Management~sq_cEffortAndDedicationStatusKPI

-- ~sq_cDecommissioning

-- Management~sq_cNodeId

-- ~sq_cDecommissioning

-- Management~sq_cResourcesStatusKPI

-- ~sq_cDecommissioning

-- Management~sq_cVisibilityId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cClusterTypeId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cDataCenterLocationId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cHardwareStatusId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cMainDnsZoneId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cMajorPatchLevelId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cRackLocationId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cSecurityClassId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cStorageVLANId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cSupplierId

-- ~sq_cInfrastructure

-- Node

-- Management~sq_cSystemTypeId

-- ~sq_cInfrastructure

-- Node

-- Quick

-- Management~sq_cHardwareStatusId

-- ~sq_cInfrastructure

-- Node

-- Quick

-- Management~sq_cMainRoleId

-- ~sq_cInfrastructure

-- Node

-- Quick

-- Management~sq_cSecurityDomainId

-- ~sq_cIssues

-- &

-- Risks

-- Management~sq_cProjectId

-- ~sq_cIssues

-- &

-- Risks

-- Management~sq_cSeverityStatusKPI

-- ~sq_cPortfolio

-- Management~sq_cComboBoxRelProjects2Environments

-- ~sq_cPortfolio

-- Management~sq_cListViewRelProjects2Environments

-- ~sq_cPortfolio

-- Management~sq_cProjectStatusId

-- ~sq_cPortfolio

-- Management~sq_cScopeStatusKPI

-- ~sq_cPortfolio

-- Management~sq_cSubFormCurrentIssues

-- ~sq_cPortfolio

-- Management~sq_cVisibilityId

-- ~sq_cPortfolio

-- Quick

-- Management~sq_cExecutionStatusKPI

-- ~sq_cPortfolio

-- Quick

-- Management~sq_cParentProjectId

-- ~sq_cPortfolio

-- Quick

-- Management~sq_cResourcesStatusKPI

-- ~sq_cPortfolio

-- Quick

-- Management~sq_cVisibilityId

-- ~sq_cProgress

-- Management~sq_cSubFormCurrentIssues

-- ~sq_cProvisioning

-- Management~sq_cComboBoxProvisioningProjectName

-- ~sq_cProvisioning

-- Management~sq_cGlobalStatusKPI

-- ~sq_cProvisioning

-- Management~sq_cProjectId

-- ~sq_cProvisioning

-- Management~sq_cScopeStatusKPI

-- ~sq_cRepairs

-- Management~sq_cBudgetStatusKPI

-- ~sq_cRepairs

-- Management~sq_cExecutionStatusKPI

-- ~sq_cRepairs

-- Management~sq_cNodeId

-- ~sq_cRepairs

-- Management~sq_cResourcesStatusKPI

-- ~sq_cRepairs

-- Management~sq_cVisibilityId

-- ~sq_cTasks

-- Management~sq_cEffortAndDedicationStatusKPI

-- ~sq_cTasks

-- Management~sq_cPriorityId

-- ~sq_cTasks

-- Management~sq_cResourcesStatusKPI

-- ~sq_cTasks

-- Management~sq_cTaskCategoryId

-- ~sq_cTasks

-- Management~sq_cVisibilityId

-- ~sq_dTasks_ClosedProgressReport~sq_dPriorityId
SELECT TblPriorities.PriorityId,TblPriorities.PriorityName,TblPriorities.DisplayOrderIndex FROM [TblPriorities] ORDER BY TblPriorities.DisplayOrderIndex

-- ~sq_dTasks_ClosedProgressReport~sq_dVisibilityId
SELECT TblVisibilities.VisibilityId,TblVisibilities.VisibilityName,TblVisibilities.DisplayOrderIndex FROM [TblVisibilities] ORDER BY TblVisibilities.DisplayOrderIndex

-- ~sq_dTasks_OpenedButPending~sq_dProjectId
SELECT TblProjects.ProjectId,TblProjects.ProjectName FROM [TblProjects] 

-- ~sq_dTasks_ProgressReport_AssignedForThisWeek~sq_dImpactId
SELECT TblImpacts.ImpactId,TblImpacts.ImpactName,TblImpacts.DisplayOrderIndex FROM [TblImpacts] ORDER BY TblImpacts.DisplayOrderIndex

-- ~sq_dTasks_ProgressReport~sq_dImpactId
SELECT TblImpacts.ImpactId,TblImpacts.ImpactName,TblImpacts.DisplayOrderIndex FROM [TblImpacts] ORDER BY TblImpacts.DisplayOrderIndex

-- ~sq_dTasks_ProgressReport~sq_dUpdaterId
SELECT TblUpdaters.UserId,TblUpdaters.UserFullName,TblUpdaters.DisplayOrderIndex FROM [TblUpdaters] ORDER BY TblUpdaters.DisplayOrderIndex

-- ~sq_f_DecommissioningHistoryView
SELECT DISTINCTROW  FROM [TblDecommissioningHistory] 

-- ~sq_f_EntityData_DnsZones
SELECT DISTINCTROW  FROM [TblDnsZones] 

-- ~sq_f_EntityData_Networks
SELECT DISTINCTROW  FROM [TblNetworks] 

-- ~sq_f_EntityData_ProductionScopes
SELECT DISTINCTROW  FROM [TblProductionScopes] 

-- ~sq_f_EntityData_SecurityDomains
SELECT DISTINCTROW  FROM [TblSecurityDomains] 

-- ~sq_f_EntityData_WorkStreams
SELECT DISTINCTROW  FROM [TblWorkStreams] 

-- ~sq_f_NodeConfigurationManagement
SELECT DISTINCTROW  FROM [TblNodes] 

-- ~sq_f_NodeExpandedFieldView_Notes
SELECT DISTINCTROW  FROM [TblNodes] 

-- ~sq_f_NodeExpandedFieldView_SystemInformationDump
SELECT DISTINCTROW  FROM [TblNodes] 

-- ~sq_f_NodeHistoryExpandedFieldView_SecurityAuditReport
SELECT DISTINCTROW  FROM [TblNodesHistory] 

-- ~sq_f_NodeTechnicalManagement
SELECT DISTINCTROW  FROM [TblNodes] 

-- ~sq_f_RepairsHistoryView
SELECT DISTINCTROW  FROM [TblRepairsHistory] 

-- ~sq_fContacts

-- Management

-- ~sq_fIssues

-- &

-- Risks

-- Management

-- ~sq_fProvisioning

-- Management

-- Issues_ProgressByPeriod_Risks
SELECT RelProgressReports2Issues.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,TblProjects.ProjectName,TblIssues.IsARisk,count(TblIssues.IssueId) FROM [TblIssues],[TblProgressReports],[RelProgressReports2Issues],[TblTeams],[TblProjects] ORDER BY RelProgressReports2Issues.ProgressReportId

-- Nodes_Decommissioning_Completed_QuantizedEndDate_Supplier
SELECT Count(*),Format(CDate(TblDecommissioning.EndDate),'mmm yy'),TblSuppliers.SupplierName FROM [TblDecommissioning],[TblNodes],[TblSuppliers] WHERE TblDecommissioning.IsDeleted=False AND TblDecommissioning.CurrentProgress=1 AND NOT IsNull(TblDecommissioning.EndDate) ORDER BY Format(CDate(TblDecommissioning.EndDate),'mmm yy')

-- Nodes_Decommissioning_Pending_Relevance_ByProject
SELECT Count(*),TblProjects.ProjectName,TblPriorities.PriorityName,TblVisibilities.VisibilityName,TblImpacts.ImpactName FROM [TblDecommissioning],[TblNodes],[TblProjects],[TblPriorities],[TblVisibilities],[TblImpacts] WHERE TblDecommissioning.IsDeleted=False AND TblDecommissioning.CurrentProgress<1 ORDER BY TblProjects.ProjectName

-- Nodes_Repairs_Pending_QuantizedStartDate_Owner
SELECT Count(*),Format(CDate(TblRepairs.StartDate),'mmm yy'),TblUpdaters.UserFullName FROM [TblRepairs],[TblUpdaters] WHERE TblRepairs.IsDeleted=False AND TblRepairs.CurrentProgress<1 ORDER BY Format(CDate(TblRepairs.StartDate),'mmm yy')

-- Nodes_Repairs_Repaired_QuantizedEndDate_Project
SELECT Count(*),Format(CDate(TblRepairs.EndDate),'mmm yy'),TblProjects.ProjectName FROM [TblRepairs],[TblNodes],[TblProjects] WHERE TblRepairs.IsDeleted=False AND TblRepairs.CurrentProgress=1 AND NOT IsNull(TblRepairs.EndDate) ORDER BY Format(CDate(TblRepairs.EndDate),'mmm yy')

-- Nodes_Storage_SAN_NodesByRole
SELECT IIf(TblNodes.NodeIsActive,'Yes','No'),IIf(TblNodes.HasSANStorage,'Yes','No'),TblRoles.RoleName,Count(TblNodes.NodeId) FROM [TblNodes],[TblRoles] WHERE TblNodes.NodeIsDeleted=False and TblNodes.NodeIsActive=True ORDER BY Count(TblNodes.NodeId)

-- Nodes_Storage_SAN_Wintel_NodesBySystemType
SELECT IIf(TblNodes.NodeIsActive,'Yes','No'),IIf(TblNodes.HasSANStorage,'Yes','No'),TblSystemType.SystemTypeName,Count(TblNodes.NodeId) FROM [TblNodes],[TblSystemType] WHERE TblNodes.NodeIsDeleted=False and TblNodes.NodeIsActive=True and TblNodes.SystemTypeId in (3,4,5,6,18,19,20,21,22) And TblNodes.NodeTypeId Not In (11,15) ORDER BY Count(TblNodes.NodeId)

-- Nodes_Summary_NodesByBusinessArea_ServiceManager
SELECT TmpTable.BusinessAreaName,TmpTable.UserFullName,Count(TmpTable.ProjectName),Sum(TmpTable.Nodes) FROM [] ORDER BY TmpTable.BusinessAreaName

-- Nodes_Summary_NodesByLocation
SELECT TblDataCenterLocations.DataCenterLocationName,Count(TblNodes.NodeId) FROM [TblDataCenterLocations],[TblNodes] WHERE TblNodes.NodeIsDeleted=False ORDER BY Count(TblNodes.NodeId)

-- Nodes_Summary_NodesBySupplier
SELECT TblSuppliers.SupplierName,Count(TblNodes.NodeId) FROM [TblSuppliers],[TblNodes] WHERE TblNodes.NodeIsDeleted=False ORDER BY Count(TblNodes.NodeId)

-- Nodes_Summary_Wintel_NodesByBusinessArea
SELECT TmpTable.BusinessAreaName,COUNT(TmpTable.ProjectName),SUM(TmpTable.Nodes) FROM [] ORDER BY SUM(TmpTable.Nodes)

-- Nodes_Summary_Wintel_NodesBySupplier
SELECT TblSuppliers.SupplierName,Count(TblNodes.NodeId) FROM [TblSuppliers],[TblNodes] WHERE TblNodes.NodeIsDeleted=False and TblNodes.SystemTypeId in (3,4,5,6,18,19,20,21,22) ORDER BY Count(TblNodes.NodeId)

-- Project_ClosedTasks_ReschedulingCount
SELECT TblProjects.ProjectName,TblTasks.ReschedulingCount,COUNT(TblTasks.TaskId) FROM [TblProjects],[TblTasks] WHERE TblProjects.ProjectName=[Project Name] AND TblTasks.CurrentProgress=1 ORDER BY TblTasks.ReschedulingCount

-- Project_Tasks_ActivityType
SELECT TblProjects.ProjectName,TblTasks.TaskCategoryId,COUNT(TblTasks.TaskId) FROM [TblProjects],[TblTasks] WHERE TblProjects.ProjectName=[Project Name] ORDER BY TblTasks.TaskCategoryId

-- Project_Tasks_ResourcesInvolved
SELECT TblProjects.ProjectName,TblTasks.ResourcesInvolved,COUNT(TblTasks.TaskId) FROM [TblProjects],[TblTasks] WHERE TblProjects.ProjectName=[Project Name] ORDER BY TblTasks.ResourcesInvolved

-- Projects_TotalProjectsByServiceManager
SELECT TblUpdaters.UserFullName,COUNT(TblProjects.ProjectName) FROM [TblProjects],[TblUpdaters] WHERE TblUpdaters.TeamId IN (22,23,24) ORDER BY COUNT(TblProjects.ProjectName)

-- ProvisioningProjects_Delivered_QuantizedStartDate
SELECT Count(*),Format(CDate(TblProvisioningProjects.StartDate),'mmm yy') FROM [TblProvisioningProjects] WHERE (((TblProvisioningProjects.IsDeleted)=False) AND ((TblProvisioningProjects.CurrentProgress)=1)) ORDER BY Format(CDate(TblProvisioningProjects.StartDate),'mmm yy')

-- ProvisioningProjects_Pending_QuantizedStartDate_Project_Detail
SELECT Count(*),Format(CDate(TblProvisioningProjects.StartDate),'mmm'),TblProjects.ProjectName FROM [TblProvisioningProjects],[TblProjects] WHERE TblProvisioningProjects.IsDeleted=False AND TblProvisioningProjects.CurrentProgress<1 ORDER BY Format(CDate(TblProvisioningProjects.StartDate),'mmm')

-- Tasks_TeamProgressByPeriod_Progress
SELECT RelClosedProgressReports2Tasks.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,TblTasks.CurrentProgress,Count(TblTasks.TaskId) FROM [TblTasks],[TblProgressReports],[RelClosedProgressReports2Tasks],[TblTeams],[TblProjects] WHERE TblTeams.TeamName<>"N/A" ORDER BY RelClosedProgressReports2Tasks.ProgressReportId

-- Tasks_TeamProgressByPeriod_Rescheduling_Projects
SELECT RelClosedProgressReports2Tasks.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,TmpProjects.ProjectName,TblTasks.ReschedulingCount,Count(TblTasks.TaskId) FROM [TblTasks],[TblProgressReports],[RelClosedProgressReports2Tasks],[TblTeams],[TblProjects],[TblProjects] WHERE TblTeams.TeamName<>"N/A" ORDER BY RelClosedProgressReports2Tasks.ProgressReportId

-- Tasks_TeamProgressByPeriod_Visibility
SELECT RelClosedProgressReports2Tasks.ProgressReportId,TblProgressReports.StartDate,TblProgressReports.EndDate,TblTeams.TeamName,TblVisibilities.VisibilityName,Count(TblTasks.TaskId) FROM [TblTasks],[TblProgressReports],[RelClosedProgressReports2Tasks],[TblTeams],[TblProjects],[TblVisibilities] WHERE TblTeams.TeamName<>"N/A" 

-- Team_ClosedTasks_Age_Priority
SELECT TblPriorities.PriorityName,Round((TblTasks.EndDate-TblTasks.StartDate),1),count(TblTasks.TaskId) FROM [TblTasks],[TblTeams],[TblPriorities] WHERE TblTeams.TeamName=[Team Name] And TblTasks.CurrentProgress=1 ORDER BY Round((TblTasks.EndDate-TblTasks.StartDate),1)

-- Team_ClosedTasks_Project_Priority
SELECT TblProjects.ProjectName,TblPriorities.PriorityName,count(TblTasks.TaskId) FROM [TblTasks],[TblTeams],[TblProjects],[TblPriorities] WHERE TblTeams.TeamName=[Team Name] And TblTasks.CurrentProgress=1 ORDER BY count(TblTasks.TaskId)

-- Team_LiveTasks_Age_Progress
SELECT TblTasks.CurrentProgress,Round((Now()-TblTasks.CreationDate),1),count(TblTasks.TaskId) FROM [TblTasks],[TblTeams] WHERE TblTeams.TeamName=[Team Name] And TblTasks.CurrentProgress<1 ORDER BY TblTasks.CurrentProgress

-- Team_LiveTasks_ReschedulingCount_Project
SELECT TblProjects.ProjectName,TblTasks.ReschedulingCount,count(TblTasks.TaskId) FROM [TblTasks],[TblTeams],[TblProjects] WHERE TblTeams.TeamName=[Team Name] And TblTasks.CurrentProgress<1 ORDER BY TblTasks.ReschedulingCount

-- Team_Summary_TasksActivityType
SELECT TblTaskCategories.CategoryName,count(TblTasks.TaskId) FROM [TblTasks],[TblTeams],[TblTaskCategories] WHERE TblTeams.TeamName=[Team Name] ORDER BY count(TblTasks.TaskId)

-- TeamMember_ClosedTasks_ActivityType
SELECT TblUpdaters.UserFullName,TblTaskCategories.CategoryName,Count(TblTasks.TaskId) FROM [TblUpdaters],[TblTasks],[TblTaskCategories] WHERE TblUpdaters.UserFullName=[Team Member] And TblTasks.CurrentProgress=1 ORDER BY Count(TblTasks.TaskId)

-- TeamMember_ClosedTasks_StatusKPIs
SELECT TblUpdaters.UserFullName,TmpGlobalStatus.StatusName,TmpRiskStatus.StatusName,TmpExecutionStatus.StatusName,TmpScopeStatus.StatusName,TmpBugdetStatus.StatusName,TmpResourcesStatus.StatusName,TmpEffortAndDedicationStatus.StatusName,Count(TblTasks.TaskId) FROM [TblTasks],[TblUpdaters],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus],[TblKpiStatus] WHERE TblUpdaters.UserFullName=[Team Member] And TblTasks.CurrentProgress=1 ORDER BY Count(TblTasks.TaskId)

-- TeamMember_Tasks_ReschedulingCount
SELECT TblUpdaters.UserFullName,TblTasks.ReschedulingCount,Count(TblTasks.TaskId) FROM [TblUpdaters],[TblTasks] WHERE TblUpdaters.UserFullName=[Team Member] ORDER BY TblTasks.ReschedulingCount

