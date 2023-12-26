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
provider "harness" {
  endpoint         = var.harness_endpoint
  account_id       = var.harness_account_id
  platform_api_key = var.harness_api_key
}

module "organization" {
  source = "./modules/organization"

  default_tags      = var.default_tags
  organization_name = var.entities.organization
}

module "project" {
  source = "./modules/project"

  for_each = var.entities.projects

  default_tags      = var.default_tags
  organization_name = var.entities.organization
  project           = each.value

  depends_on = [module.organization]
}

module "resource_group_admin" {
  source = "./modules/resource_group"

  harness_account_id = var.harness_account_id
  default_tags       = var.default_tags
  organization_name  = var.entities.organization
  isAdmin            = true

  depends_on = [module.organization, module.project]
}

module "resource_group" {
  source = "./modules/resource_group"

  for_each = var.entities.projects

  harness_account_id = var.harness_account_id
  default_tags       = var.default_tags
  organization_name  = var.entities.organization
  project            = each.value

  depends_on = [module.organization, module.project]
}

locals {
  project_role_map = [
    for pair in setproduct(var.entities.projects, ["pipeline_creator", "pipeline_executor"]) : {
      key          = "${var.entities.organization}_${pair[0]}_${pair[1]}"
      organization = var.entities.organization
      project      = pair[0]
      role         = pair[1]
    }
  ]

  merged_role_map = merge(
    {
      for role_map in local.project_role_map : "${role_map.organization}_${role_map.project}_${role_map.role}" => role_map
    },
    {
      "${var.entities.organization}_admin" = {
        key          = "${var.entities.organization}_admin"
        organization = var.entities.organization
        project      = "unknown"
        role         = "admin"
      }
    }
  )
}

module "usergroup" {
  source = "./modules/usergroup"

  for_each = {
    for role_map in local.merged_role_map : "${role_map.key}" => role_map
  }

  default_tags      = var.default_tags
  organization_name = each.value.organization
  project           = each.value.project
  usergroup         = each.value.role

  depends_on = [module.organization, module.project, module.resource_group]
}

module "usergroup_rolebindings" {
  source = "./modules/usergroup_rolebindings"

  for_each = {
    for role_map in local.merged_role_map : "${role_map.key}" => role_map
  }

  default_tags      = var.default_tags
  organization_name = each.value.organization
  project           = each.value.project
  usergroup         = each.value.role
  role              = each.value.role

  depends_on = [module.organization, module.project, module.resource_group, module.usergroup]
}
