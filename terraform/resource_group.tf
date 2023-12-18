# resource "harness_platform_resource_group" "this" {
#   identifier  = lower(join("_", [var.instance, "resource_group"]))
#   name        = lower(join(" ", [var.instance, "resource_group"]))
#   description = "An example resource group managed by Terraform."
#   tags        = concat(var.default_tags, ["Demo:true"])

#   account_id = var.harness_account_id
#   org_id     = harness_platform_organization.this.id
#   project_id = harness_platform_project.this.id

#   allowed_scope_levels = ["project"]
#   # included_scopes {
#   #   filter     = "EXCLUDING_CHILD_SCOPES"
#   #   account_id = "account_id"
#   # }
#   resource_filter {
#     include_all_resources = false
#     # resources {
#     #   resource_type = "PIPELINES"
#     #   # attribute_filter {
#     #   #   attribute_name   = "category"
#     #   #   attribute_values = ["CLOUD_COST"]
#     #   # }
#     # }
#   }
# }
