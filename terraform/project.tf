resource "harness_platform_project" "this" {
  identifier  = lower(replace(join("_", [var.organization, var.project]), "[^a-zA-Z0-9_]", ""))
  name        = lower(join(" ", [var.instance, "project"]))
  description = "An example project managed by Terraform."
  tags        = concat(var.default_tags, ["Demo:true"])
  org_id      = harness_platform_organization.this.id
  color       = "#0063F7"
}
