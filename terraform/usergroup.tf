resource "harness_platform_usergroup" "this" {
  identifier  = lower(replace(join("_", [var.organization, var.project, "pipeline_creator"],), "[^a-zA-Z0-9_]", ""))
  name        = lower(replace(join("_", [var.organization, var.project, "pipeline_creator"],), "[^a-zA-Z0-9_]", ""))
  description = "An example user group managed by Terraform."
  tags        = concat(var.default_tags, ["Demo:true"])
  #linked_sso_id      = "linked_sso_id" fixme
  org_id      = harness_platform_organization.this.id
  project_id  = harness_platform_project.this.id
  # user_emails = ["i3lfrg+harness_non_admin@gmail.com"]
}

#resource "harness_platform_usergroup" "this" {
#  identifier  = lower(replace(join("_", [var.organization, var.project],), "[^a-zA-Z0-9_]", ""))
#  name        = lower(join(" ", [var.instance, "user_group"]))
#  description = "An example user group managed by Terraform."
#  tags        = concat(var.default_tags, ["Demo:true"])
#  org_id      = harness_platform_organization.this.id
#  project_id  = harness_platform_project.this.id
#  # user_emails = ["i3lfrg+harness_non_admin@gmail.com"]
#}
#
#resource "harness_platform_usergroup" "this" {
#  identifier  = lower(replace(join("_", [var.organization, var.project],), "[^a-zA-Z0-9_]", ""))
#  name        = lower(join(" ", [var.instance, "user_group"]))
#  description = "An example user group managed by Terraform."
#  tags        = concat(var.default_tags, ["Demo:true"])
#  org_id      = harness_platform_organization.this.id
#  project_id  = harness_platform_project.this.id
#  # user_emails = ["i3lfrg+harness_non_admin@gmail.com"]
#}
