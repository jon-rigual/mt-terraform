terraform {
  required_version = ">= 1.4.6"

  required_providers {
    harness = {
      source  = "harness/harness"
      version = ">= 0.29.4"
    }
  }
}

#Configure the Harness provider for Next Gen resources
# provider "harness" {
#   endpoint         = var.harness_endpoint
#   account_id       = var.harness_account_id
#   platform_api_key = var.harness_api_key
# }

data "harness_platform_organization" "this" {
  name = var.organization_name
}

data "harness_platform_project" "this" {
  name   = var.project
  org_id = data.harness_platform_organization.this.id
}

data "harness_platform_resource_group" "this" {
  identifier = join("_", [var.organization_name, var.project, "admin"])
  org_id     = data.harness_platform_organization.this.id
}

resource "harness_platform_resource_group" "this" {
  identifier  = lower(replace(join("_", [var.organization_name, data.harness_platform_project.this.name], ), "/[^\\w]/", ""))
  name        = lower(replace(join("_", [var.organization_name, data.harness_platform_project.this.name], ), "/[^\\w]/", ""))
  description = "An example resource group managed by Terraform."
  tags        = concat(var.default_tags, ["Demo:true"])

  account_id = var.harness_account_id
  org_id     = data.harness_platform_organization.this.id
  #   project_id = harness_platform_project.this.id

  allowed_scope_levels = ["project"]
  included_scopes {
    filter     = "INCLUDING_CHILD_SCOPES"
    account_id = var.harness_account_id
    org_id     = data.harness_platform_organization.this.id
    project_id = data.harness_platform_project.this.id
  }

  resource_filter {
    include_all_resources = true
    # resources {
    #   resource_type = "PIPELINES"
    #   # attribute_filter {
    #   #   attribute_name   = "category"
    #   #   attribute_values = ["CLOUD_COST"]
    #   # }
    # }
  }
}
