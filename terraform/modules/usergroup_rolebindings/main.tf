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

# data "harness_platform_project" "this" {
#   name   = var.project
#   org_id = data.harness_platform_organization.this.id
# }

data "harness_platform_usergroup" "this" {
  name = var.usergroup
  # org_id = data.harness_platform_organization.this.id
}

data "harness_platform_resource_group" "this" {
  identifier = lower(replace(join("_", [var.organization_name, var.project]), "/[^\\w]/", ""))
  # org_id     = data.harness_platform_organization.this.id
}

resource "harness_platform_role_assignments" "this" {
  # org_id                    = data.harness_platform_organization.this.id
  resource_group_identifier = data.harness_platform_resource_group.this.id
  role_identifier           = var.role
  managed                   = false
  disabled                  = false

  principal {
    identifier = data.harness_platform_usergroup.this.id
    type       = "USER_GROUP"
  }
}
