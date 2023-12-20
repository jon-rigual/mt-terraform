terraform {
  required_version = ">= 1.4.6"

  required_providers {
    harness = {
      source  = "harness/harness"
      version = ">= 0.29.4"
    }
  }
}

locals {
  project = lower(replace(join("_", [var.organization_name, var.project]), "/[^\\w]/", ""))
}

data "harness_platform_organization" "this" {
  name = var.organization_name
}

resource "harness_platform_project" "this" {
  identifier  = local.project
  name        = local.project
  description = "The ${local.project} project"
  tags        = concat(var.default_tags, ["Demo:true"])
  org_id      = data.harness_platform_organization.this.id
  color       = "#0063F7"
}
