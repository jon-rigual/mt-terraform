resource "harness_platform_connector_helm" "this" {
  name        = lower(join(" ", [var.instance, "helmconn"]))
  identifier  = lower(join("_", [var.instance, "helmconn"]))
  description = "An example Helm Connector managed by Terraform."
  tags        = concat(var.default_tags, ["Demo:true"])
  org_id      = harness_platform_organization.this.id
  project_id  = harness_platform_project.this.id
  url         = "https://cloudecho.github.io/charts/"
}
