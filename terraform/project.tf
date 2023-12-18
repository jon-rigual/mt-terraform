resource "harness_platform_project" "this" {
  identifier  = lower(join("_", [var.instance, "project"]))
  name        = lower(join(" ", [var.instance, "project"]))
  description = "An example project managed by Terraform."
  tags        = concat(var.default_tags, ["Demo:true"])
  org_id      = harness_platform_organization.this.id
  color       = "#0063F7"
}
