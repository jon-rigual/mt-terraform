resource "harness_platform_connector_kubernetes" "this" {
  name        = lower(join(" ", [var.instance, "k8sconn"]))
  identifier  = lower(join("_", [var.instance, "k8sconn"]))
  description = "An example Kubernetes connector managed by Terraform."
  org_id      = harness_platform_organization.this.id
  project_id  = harness_platform_project.this.id
  tags        = concat(var.default_tags, ["Demo:true"])

  inherit_from_delegate {
    delegate_selectors = ["bastion"]
  }
}
