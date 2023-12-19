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

module "project" {
  source = "./modules/project"

  harness_endpoint   = var.harness_endpoint
  harness_account_id = var.harness_account_id
  harness_api_key    = var.harness_api_key
  default_tags       = var.default_tags
  organization_name  = var.organization
  organization_id    = harness_platform_organization.this.id
  project            = var.project
}
