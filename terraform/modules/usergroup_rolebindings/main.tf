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
  name   = var.project
  org_id = data.harness_platform_organization.this.id
}

# data "harness_platform_usergroup" "this" {
#   name = var.usergroup
# }

# data "harness_platform_resource_group" "this" {
#   identifier = local.resource_group
# }

locals {
  resource_group_suffix = (var.usergroup == "admin") ? null : var.project
  project_id            = (var.usergroup == "admin") ? null : data.harness_platform_project.this.id
  resource_group        = lower(replace(join("_", compact([var.organization_name, local.resource_group_suffix])), "/[^\\w]/", ""))
  user_group            = lower(replace(join("_", compact([local.resource_group, var.usergroup])), "/[^\\w]/", ""))
}

resource "harness_platform_role_assignments" "this" {
  # org_id                    = data.harness_platform_organization.this.id
  resource_group_identifier = local.resource_group
  role_identifier           = var.role
  managed                   = false
  disabled                  = false

  principal {
    identifier = local.user_group
    type       = "USER_GROUP"
  }
}
