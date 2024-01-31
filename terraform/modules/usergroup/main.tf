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
  project_tag           = var.project_name == "" ? "" : "project:${data.harness_platform_project.this.id}"
  resource_group        = join("_", [for word in split("--", replace(join(" ", compact([var.organization_name, local.resource_group_suffix])), "/[^\\w]/", "--")) : word])
  usergroup             = join("_", [for word in split("--", replace(join(" ", compact([var.organization_name, local.resource_group_suffix, var.usergroup])), "/[^\\w]/", "--")) : word])
  usergroup_name        = join("-", compact([var.organization_name, local.resource_group_suffix, var.usergroup]))
}

resource "harness_platform_usergroup" "this" {
  identifier  = local.usergroup
  name        = local.usergroup_name
  description = "The ${local.usergroup} user group"
  tags        = concat(var.default_tags, ["organization:${data.harness_platform_organization.this.id}", local.project_tag])

  # org_id        = harness_platform_organization.this.id
  # project_id    = harness_platform_project.this.id

  externally_managed      = false
  sso_linked              = true
  linked_sso_id           = var.linked_sso_id
  linked_sso_display_name = var.linked_sso_display_name
  sso_group_id            = local.usergroup_name
  sso_group_name          = local.usergroup_name
  linked_sso_type         = "LDAP"
}
