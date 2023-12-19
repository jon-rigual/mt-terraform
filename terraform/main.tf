terraform {
  required_version = ">= 1.4.6"

  required_providers {
    harness = {
      source  = "harness/harness"
      version = ">= 0.29.2"
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

  harness_endpoint   = var.harness_endpoint
  harness_account_id = var.harness_account_id
  harness_api_key    = var.harness_api_key
  default_tags       = var.default_tags
  organization_name  = var.structure.organization
}

module "project" {
  source = "./modules/project"

  for_each = var.structure.projects

  harness_endpoint   = var.harness_endpoint
  harness_account_id = var.harness_account_id
  harness_api_key    = var.harness_api_key
  default_tags       = var.default_tags
  organization_name  = var.structure.organization
  project            = each.value

  depends_on = [module.organization]
}

module "resource_group" {
  source = "./modules/resource_group"

  for_each = var.structure.projects

  harness_endpoint   = var.harness_endpoint
  harness_account_id = var.harness_account_id
  harness_api_key    = var.harness_api_key
  default_tags       = var.default_tags
  organization_name  = var.structure.organization
  project            = each.value

  depends_on = [module.organization, module.project]
}
