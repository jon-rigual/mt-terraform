# resource "harness_platform_roles" "this" {
#   identifier           = lower(join("_", [var.instance, "role"]))
#   name                 = lower(join(" ", [var.instance, "role"]))
#   description          = "An example role managed by Terraform."
#   tags                 = concat(var.default_tags, ["Demo:true"])
#   org_id               = harness_platform_organization.this.id
#   permissions          = ["core_resourcegroup_view"]
#   allowed_scope_levels = ["organization"]
# }
