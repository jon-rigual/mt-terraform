resource "harness_platform_infrastructure" "this" {
  name            = lower(join(" ", [var.instance, "infrastructure"]))
  identifier      = lower(join("_", [var.instance, "infrastructure"]))
  description     = "An example infrastructure managed by Terraform."
  org_id          = harness_platform_organization.this.id
  project_id      = harness_platform_project.this.id
  env_id          = harness_platform_environment.this.id
  tags            = concat(var.default_tags, ["Demo:true"])
  type            = "KubernetesDirect"
  deployment_type = "Kubernetes"

  yaml = yamlencode({
    infrastructureDefinition = {
      name              = lower(join(" ", [var.instance, "infrastructure"]))
      identifier        = lower(join("_", [var.instance, "infrastructure"]))
      orgIdentifier     = harness_platform_organization.this.id
      projectIdentifier = harness_platform_project.this.id
      environmentRef    = harness_platform_environment.this.id
      deploymentType    = "Kubernetes"
      type              = "KubernetesDirect"
      spec = {
        connectorRef = harness_platform_connector_kubernetes.this.id
        namespace    = var.namespace
        releaseName  = "release-<+INFRA_KEY_SHORT_ID>"
      }
      allowSimultaneousDeployments = false
      useDelegate                  = true
    }
  })

  depends_on = [
    harness_platform_environment.this
  ]
}
