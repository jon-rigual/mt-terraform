resource "harness_platform_organization" "this" {
  identifier  = lower(replace(var.organization, "[^a-zA-Z0-9_]", ""))
  name        = var.organization
  description = "An example organization managed by Terraform."
  tags        = concat(var.default_tags, ["Demo:true"])
}
