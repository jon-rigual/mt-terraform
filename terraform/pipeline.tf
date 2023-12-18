resource "harness_platform_pipeline" "this" {
  name        = lower(join(" ", [var.instance, "pipeline"]))
  identifier  = lower(join("_", [var.instance, "pipeline"]))
  description = "An example pipeline managed by Terraform."
  # tags        = concat(var.default_tags, ["Demo:true"])
  org_id     = harness_platform_organization.this.id
  project_id = harness_platform_project.this.id

  yaml = yamlencode({
    pipeline = {
      name              = lower(join(" ", [var.instance, "pipeline"]))
      identifier        = lower(join("_", [var.instance, "pipeline"]))
      projectIdentifier = harness_platform_project.this.id
      orgIdentifier     = harness_platform_organization.this.id
      # tags              = concat(var.default_tags, ["Demo:true"])
      stages = [
        {
          stage = {
            name        = lower(join(" ", [var.instance, "build"]))
            identifier  = lower(join("_", [var.instance, "build"]))
            description = "An example build stage managed by Terraform."
            type        = "CI"
            spec = {
              cloneCodebase = false
              infrastructure = {
                type = "KubernetesDirect"
                spec = {
                  connectorRef                 = harness_platform_connector_kubernetes.this.id
                  namespace                    = var.namespace
                  automountServiceAccountToken = true
                  nodeSelector                 = {}
                  os                           = "Linux"
                }
              }
              execution = {
                steps = [
                  {
                    step = {
                      type       = "Run"
                      name       = lower(join(" ", [var.instance, "run"]))
                      identifier = lower(join("_", [var.instance, "run"]))
                      spec = {
                        connectorRef = "account.harnessImage"
                        image        = "busybox"
                        shell        = "Sh"
                        command      = "echo \"run!\""
                      }
                    }
                  }
                ]
              }
            }
          }
        },
        {
          stage = {
            name        = lower(join(" ", [var.instance, "deploy"]))
            identifier  = lower(join("_", [var.instance, "deploy"]))
            description = "An example deploy stage managed by Terraform."
            type        = "Deployment"
            spec = {
              deploymentType = "NativeHelm"
              service = {
                serviceRef = harness_platform_service.this.id
              },
              environment = {
                environmentRef = harness_platform_environment.this.id
                deployToAll    = false
                infrastructureDefinitions = [
                  {
                    identifier = harness_platform_infrastructure.this.id
                  }
                ]
              },
              execution = {
                steps = [
                  {
                    step = {
                      name       = "Helm Deployment"
                      identifier = "helmDeployment"
                      type       = "HelmDeploy"
                      timeout    = "10m"
                      spec = {
                        skipDryRun = false
                      }
                    }
                  }
                ],
                rollbackSteps = [
                  {
                    step = {
                      name       = "Helm Rollback"
                      identifier = "helmRollback"
                      type       = "HelmRollback"
                      timeout    = "10m"
                      spec       = {}
                    }
                  }
                ]
              }
            },
            tags = {},
            failureStrategies = [
              {
                onFailure = {
                  errors = [
                    "AllErrors"
                  ],
                  action = {
                    type = "StageRollback"
                  }
                }
              }
            ]
          }
        }
      ]
    }
  })

  depends_on = [
    harness_platform_infrastructure.this
  ]
}
