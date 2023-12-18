 resource "harness_platform_roles" "this" {
   identifier           = "pipeline_creator"
   name                 = "pipeline_creator"
   description          = "An example role managed by Terraform."
   tags                 = concat(var.default_tags, ["Demo:true"])
   permissions          = ["core_template_view",
      "core_governancePolicy_view",
      "core_serviceaccount_view",
      "sto_exemption_view",
      "chi_downtime_edit",
      "core_resourcegroup_view",
      "chaos_chaosexperiment_view",
      "core_secret_edit",
      "chi_slo_view",
      "core_pipeline_view",
      "core_user_view",
      "chi_slo_edit",
      "sto_issue_view",
      "chaos_chaosinfrastructure_view",
      "core_file_delete",
      "chi_downtime_view",
      "core_role_view",
      "core_file_access",
      "sto_ticket_edit",
      "core_secret_delete",
      "core_delegateconfiguration_view",
      "core_authsetting_view",
      "chaos_chaoshub_view",
      "chi_monitoredservice_delete",
      "core_organization_view",
      "chaos_chaosgameday_view",
      "core_template_edit",
      "core_secret_view",
      "sto_scan_view",
      "core_secret_access",
      "chi_monitoredservice_toggle",
      "core_service_view",
      "core_governancePolicy_edit",
      "sto_ticket_view",
      "sto_exemption_create",
      "chi_monitoredservice_view",
      "core_service_edit",
      "core_dashboards_edit",
      "chi_downtime_delete",
      "core_governancePolicySets_edit",
      "core_account_view",
      "sto_testtarget_view",
      "core_environment_view",
      "core_environmentgroup_access",
      "core_service_delete",
      "core_usergroup_view",
      "core_environmentgroup_view",
      "core_connector_view",
      "core_governancePolicySets_view",
      "core_template_copy",
      "chi_monitoredservice_edit",
      "core_variable_edit",
      "core_environment_access",
      "core_streamingDestination_view",
      "core_file_view",
      "chi_slo_delete",
      "core_delegate_view",
      "core_variable_delete",
      "core_template_access",
      "core_pipeline_delete",
      "core_dashboards_view",
      "core_project_view",
      "core_service_access",
      "core_deploymentfreeze_manage",
      "core_pipeline_edit",
      "core_template_delete",
      "core_connector_access",
      "core_pipeline_execute",
      "core_variable_view",
      "sto_testtarget_edit",
      "core_file_edit"
   ]
   allowed_scope_levels = ["account"]
 }
