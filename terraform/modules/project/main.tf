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

data "harness_platform_organization" "this" {
  name = var.organization_name
}

locals {
  org_id = data.harness_platform_organization.this.id != null ? data.harness_platform_organization.this.id : ""
}

resource "harness_platform_project" "this" {
  count = local.org_id != "" ? 1 : 0

  identifier  = lower(replace(join("_", [var.organization_name, var.project]), "/[^\\w]/", ""))
  name        = lower(replace(join("_", [var.organization_name, var.project]), "/[^\\w]/", ""))
  description = "An example project managed by Terraform."
  tags        = concat(var.default_tags, ["Demo:true"])
  org_id      = local.org_id
  color       = "#0063F7"
}
