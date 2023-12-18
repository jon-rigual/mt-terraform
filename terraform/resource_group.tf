 resource "harness_platform_resource_group" "this" {
   identifier  = lower(replace(join("_", [var.organization, var.project],), "/[^\\w]/", ""))
   name        = lower(replace(join("_", [var.organization, var.project],), "/[^\\w]/", ""))
   description = "An example resource group managed by Terraform."
   tags        = concat(var.default_tags, ["Demo:true"])

   account_id = var.harness_account_id
#   org_id     = harness_platform_organization.this.id
#   project_id = harness_platform_project.this.id

   allowed_scope_levels = ["project"]
    included_scopes {
      filter     = "INCLUDING_CHILD_SCOPES"
      account_id = var.harness_account_id
      org_id     = harness_platform_organization.this.id
      project_id = harness_platform_project.this.id
    }
   resource_filter {
     include_all_resources = true
     # resources {
     #   resource_type = "PIPELINES"
     #   # attribute_filter {
     #   #   attribute_name   = "category"
     #   #   attribute_values = ["CLOUD_COST"]
     #   # }
     # }
   }
 }
