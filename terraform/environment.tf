resource "harness_platform_environment" "this" {
  name        = lower(join(" ", [var.instance, "environment"]))
  identifier  = lower(join("_", [var.instance, "environment"]))
  description = "An example environment managed by Terraform."
  org_id      = harness_platform_organization.this.id
  project_id  = harness_platform_project.this.id
  tags        = concat(var.default_tags, ["Demo:true"])
  type        = "PreProduction"
  # yaml       = <<-EOT
  #   ...
  # EOT

  depends_on = [
    harness_platform_project.this
  ]
}
