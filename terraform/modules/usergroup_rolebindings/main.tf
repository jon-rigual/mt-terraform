terraform {
  required_version = ">= 1.4.6"

  required_providers {
    harness = {
      source  = "harness/harness"
      version = ">= 0.30.2"
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
  resource_group        = join("_", [for word in split("--", replace(join(" ", compact([var.organization_name, local.resource_group_suffix])), "/[^\\w]/", "--")) : word])
  user_group            = join("_", [for word in split("--", replace(join(" ", compact([var.organization_name, local.resource_group_suffix, var.usergroup])), "/[^\\w]/", "--")) : word])
}

resource "harness_platform_role_assignments" "this" {
  resource_group_identifier = replace(local.user_group, "-", "_")
  role_identifier           = replace(var.role, "-", "_")
  managed                   = false
  disabled                  = false

  principal {
    identifier = local.user_group
    type       = "USER_GROUP"
  }
}
