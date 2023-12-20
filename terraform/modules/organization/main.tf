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
  org = lower(replace(var.organization_name, "/[^\\w]/", ""))
}

resource "harness_platform_organization" "this" {
  identifier  = local.org
  name        = local.org
  description = "The ${local.org} organization"
  tags        = concat(var.default_tags, ["Demo:true"])
}
