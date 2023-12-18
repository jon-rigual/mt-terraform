resource "harness_platform_service" "this" {
  name        = lower(join(" ", [var.instance, "service"]))
  identifier  = lower(join("_", [var.instance, "service"]))
  description = "An example service managed by Terraform."
  org_id      = harness_platform_organization.this.id
  project_id  = harness_platform_project.this.id

  yaml = yamlencode({
    service = {
      name        = lower(join(" ", [var.instance, "service"]))
      identifier  = lower(join("_", [var.instance, "service"]))
      description = "An example service managed by Terraform."
      serviceDefinition = {
        spec = {
          manifests = [
            {
              manifest = {
                identifier = "hello"
                type       = "HelmChart"
                spec = {
                  store = {
                    type = "Http"
                    spec = {
                      connectorRef = harness_platform_connector_helm.this.id
                    }
                  }
                  chartName                 = "hello"
                  chartVersion              = "0.1.2"
                  subChartPath              = ""
                  helmVersion               = "V3"
                  skipResourceVersioning    = false
                  enableDeclarativeRollback = false
                  fetchHelmChartMetadata    = false
                }
              }
            }
          ]
        }
        type = "NativeHelm"
      }
    }
  })

  depends_on = [
    harness_platform_project.this,
  ]
}
