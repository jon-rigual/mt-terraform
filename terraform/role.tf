resource "harness_platform_roles" "pipeline_executor" {
  identifier  = "pipeline_executor"
  name        = "pipeline_executor"
  description = "An example role managed by Terraform."
  tags        = concat(var.default_tags, ["Demo:true"])
  permissions = [
    "chaos_chaosexperiment_view",
    "chaos_chaosgameday_view",
    "chaos_chaoshub_view",
    "chaos_chaosinfrastructure_view",
    "chi_downtime_delete",
    "chi_downtime_edit",
    "chi_downtime_view",
    "chi_monitoredservice_delete",
    "chi_monitoredservice_edit",
    "chi_monitoredservice_toggle",
    "chi_monitoredservice_view",
    "chi_slo_delete",
    "chi_slo_edit",
    "chi_slo_view",
    "core_connector_view",
    "core_dashboards_edit",
    "core_dashboards_view",
    "core_delegate_view",
    "core_delegateconfiguration_view",
    "core_deploymentfreeze_manage",
    "core_environment_access",
    "core_environment_view",
    "core_environmentgroup_access",
    "core_environmentgroup_view",
    "core_file_view",
    "core_organization_view",
    "core_pipeline_execute",
    "core_pipeline_view",
    "core_project_view",
    "core_resourcegroup_view",
    "core_role_view",
    "core_secret_view",
    "core_service_access",
    "core_service_view",
    "core_serviceaccount_view",
    "core_streamingDestination_view",
    "core_template_access",
    "core_template_view",
    "core_user_view",
    "core_usergroup_view",
    "core_variable_view",
    "sto_exemption_create",
    "sto_exemption_view",
    "sto_issue_view",
    "sto_scan_view",
    "sto_testtarget_view",
    "sto_ticket_view",
  ]
  allowed_scope_levels = ["account"]
}

resource "harness_platform_roles" "pipeline_creator" {
  identifier  = "pipeline_creator"
  name        = "pipeline_creator"
  description = "An example role managed by Terraform."
  tags        = concat(var.default_tags, ["Demo:true"])
  permissions = [
    "chaos_chaosexperiment_view",
    "chaos_chaosgameday_view",
    "chaos_chaoshub_view",
    "chaos_chaosinfrastructure_view",
    "chi_downtime_delete",
    "chi_downtime_edit",
    "chi_downtime_view",
    "chi_monitoredservice_delete",
    "chi_monitoredservice_edit",
    "chi_monitoredservice_toggle",
    "chi_monitoredservice_view",
    "chi_slo_delete",
    "chi_slo_edit",
    "chi_slo_view",
    "core_account_view",
    "core_authsetting_view",
    "core_connector_access",
    "core_connector_view",
    "core_dashboards_edit",
    "core_dashboards_view",
    "core_delegate_view",
    "core_delegateconfiguration_view",
    "core_deploymentfreeze_manage",
    "core_environment_access",
    "core_environment_view",
    "core_environmentgroup_access",
    "core_environmentgroup_view",
    "core_file_access",
    "core_file_delete",
    "core_file_edit",
    "core_file_view",
    "core_governancePolicy_edit",
    "core_governancePolicy_view",
    "core_governancePolicySets_edit",
    "core_governancePolicySets_view",
    "core_organization_view",
    "core_pipeline_delete",
    "core_pipeline_edit",
    "core_pipeline_execute",
    "core_pipeline_view",
    "core_project_view",
    "core_resourcegroup_view",
    "core_role_view",
    "core_secret_access",
    "core_secret_delete",
    "core_secret_edit",
    "core_secret_view",
    "core_service_access",
    "core_service_delete",
    "core_service_edit",
    "core_service_view",
    "core_serviceaccount_view",
    "core_streamingDestination_view",
    "core_template_access",
    "core_template_copy",
    "core_template_delete",
    "core_template_edit",
    "core_user_view",
    "core_usergroup_view",
    "core_variable_delete",
    "core_variable_edit",
    "core_variable_view",
    "sto_exemption_create",
    "sto_exemption_view",
    "sto_issue_view",
    "sto_scan_view",
    "sto_testtarget_edit",
    "sto_testtarget_view",
    "sto_ticket_edit",
    "sto_ticket_view",
    "core_template_view",
  ]
  allowed_scope_levels = ["account"]
}

resource "harness_platform_roles" "admin" {
  identifier  = "admin"
  name        = "admin"
  description = "An example role managed by Terraform."
  tags        = concat(var.default_tags, ["Demo:true"])
  permissions = [
    "chaos_chaosexperiment_delete",
    "chaos_chaosexperiment_edit",
    "chaos_chaosexperiment_execute",
    "chaos_chaosexperiment_view",
    "chaos_chaosgameday_delete",
    "chaos_chaosgameday_edit",
    "chaos_chaosgameday_view",
    "chaos_chaoshub_delete",
    "chaos_chaoshub_edit",
    "chaos_chaoshub_view",
    "chaos_chaosinfrastructure_delete",
    "chaos_chaosinfrastructure_edit",
    "chaos_chaosinfrastructure_view",
    "chi_downtime_delete",
    "chi_downtime_edit",
    "chi_downtime_view",
    "chi_monitoredservice_delete",
    "chi_monitoredservice_edit",
    "chi_monitoredservice_toggle",
    "chi_monitoredservice_view",
    "chi_slo_delete",
    "chi_slo_edit",
    "chi_slo_view",
    "core_account_edit",
    "core_account_view",
    "core_authsetting_delete",
    "core_authsetting_edit",
    "core_authsetting_view",
    "core_connector_access",
    "core_connector_delete",
    "core_connector_edit",
    "core_connector_view",
    "core_dashboards_edit",
    "core_dashboards_view",
    "core_delegate_delete",
    "core_delegate_edit",
    "core_delegate_view",
    "core_delegateconfiguration_delete",
    "core_delegateconfiguration_edit",
    "core_delegateconfiguration_view",
    "core_deploymentfreeze_global",
    "core_deploymentfreeze_manage",
    "core_deploymentfreeze_override",
    "core_environment_access",
    "core_environment_delete",
    "core_environment_edit",
    "core_environment_view",
    "core_environmentgroup_access",
    "core_environmentgroup_delete",
    "core_environmentgroup_edit",
    "core_environmentgroup_view",
    "core_file_access",
    "core_file_delete",
    "core_file_edit",
    "core_file_view",
    "core_organization_create",
    "core_organization_delete",
    "core_organization_edit",
    "core_organization_view",
    "core_pipeline_delete",
    "core_pipeline_edit",
    "core_pipeline_execute",
    "core_pipeline_view",
    "core_project_create",
    "core_project_delete",
    "core_project_edit",
    "core_project_view",
    "core_resourcegroup_delete",
    "core_resourcegroup_edit",
    "core_resourcegroup_view",
    "core_role_delete",
    "core_role_edit",
    "core_role_view",
    "core_secret_access",
    "core_secret_delete",
    "core_secret_edit",
    "core_secret_view",
    "core_service_access",
    "core_service_delete",
    "core_service_edit",
    "core_service_view",
    "core_serviceaccount_delete",
    "core_serviceaccount_edit",
    "core_serviceaccount_manageapikey",
    "core_serviceaccount_view",
    "core_setting_edit",
    "core_streamingDestination_delete",
    "core_streamingDestination_edit",
    "core_streamingDestination_view",
    "core_template_access",
    "core_template_copy",
    "core_template_delete",
    "core_template_edit",
    "core_template_view",
    "core_user_invite",
    "core_user_manage",
    "core_user_view",
    "core_usergroup_manage",
    "core_usergroup_view",
    "core_variable_delete",
    "core_variable_edit",
    "core_variable_view",
    "ff_environment_apiKeyCreate",
    "ff_environment_apiKeyDelete",
    "ff_featureflag_delete",
    "ff_featureflag_edit",
    "ff_featureflag_toggle",
    "ff_targetgroup_delete",
    "ff_targetgroup_edit",
    "sto_exemption_create",
    "sto_exemption_view",
    "sto_issue_view",
    "sto_scan_view",
    "sto_testtarget_edit",
    "sto_testtarget_view",
    "sto_ticket_delete",
    "sto_ticket_edit",
    "sto_ticket_view",
  ]
  allowed_scope_levels = ["account"]
}
