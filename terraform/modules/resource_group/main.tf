terraform {
  required_version = ">= 1.4.6"

  required_providers {
    harness = {
      source  = "harness/harness"
      version = ">= 0.29.4"
    }
  }
}

data "harness_platform_organization" "this" {
  name = var.organization_name
}

data "harness_platform_project" "this" {
  name   = var.project_name == "" ? "unknown" : var.project_name
  org_id = data.harness_platform_organization.this.id
}

locals {
  resource_group_suffix = var.project_name == "" ? null : var.project_name
  project_id            = var.project_name == "" ? null : data.harness_platform_project.this.id
  project_tag           = var.project_name == "" ? "" : "project:${data.harness_platform_project.this.id}"
  resource_group        = join("_", [for word in split("--", replace(join(" ", compact([var.organization_name, local.resource_group_suffix])), "/[^\\w]/", "--")) : word])
  resource_group_name   = join("-", compact([var.organization_name, local.resource_group_suffix]))
}

resource "harness_platform_resource_group" "this" {
  identifier  = local.resource_group
  name        = local.resource_group_name
  description = "The '${local.resource_group}' resource group"
  tags        = concat(var.default_tags, ["organization:${data.harness_platform_organization.this.id}", local.project_tag])

  account_id = var.harness_account_id
  # org_id     = data.harness_platform_organization.this.id
  # project_id = local.project_id

  allowed_scope_levels = ["account"]
  included_scopes {
    filter     = var.project_name == "" ? "INCLUDING_CHILD_SCOPES" : "EXCLUDING_CHILD_SCOPES"
    account_id = var.harness_account_id
    org_id     = data.harness_platform_organization.this.id
    # project_id = local.project_id
  }

  included_scopes {
    filter     = var.project_name == "" ? "INCLUDING_CHILD_SCOPES" : "EXCLUDING_CHILD_SCOPES"
    account_id = var.harness_account_id
    org_id     = data.harness_platform_organization.this.id
    project_id = local.project_id
  }

  resource_filter {
    include_all_resources = true
    # resources {
    #   resource_type = "ENVIRONMENT"
    #   # attribute_filter {
    #   #   attribute_name   = "name"
    #   #   attribute_values = ["PreProduction"]
    #   # }
    #   resource_type = "CONNECTOR"
    #   # attribute_filter {
    #   #   attribute_name   = "category"
    #   #   attribute_values = ["SECRET_MANAGER"]
    #   # }
    # }
  }
}
