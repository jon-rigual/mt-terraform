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

locals {
  resource_group_suffix = var.isAdmin ? null : var.project
  project_id            = var.isAdmin ? null : data.harness_platform_project.this.id
  resource_group        = lower(replace(join("_", compact([var.organization_name, local.resource_group_suffix])), "/[^\\w]/", ""))
  usergroup             = lower(replace(join("_", compact([var.organization_name, local.resource_group_suffix, var.usergroup])), "/[^\\w]/", ""))
}

resource "harness_platform_usergroup" "this" {
  identifier  = local.usergroup
  name        = local.usergroup
  description = "The ${local.usergroup} user group"
  tags        = concat(var.default_tags, ["Demo:true"])

  # linked_sso_id = "linked_sso_id"
  # org_id        = harness_platform_organization.this.id
  # project_id    = harness_platform_project.this.id
  # user_emails   = ["user@example.com"]
}
