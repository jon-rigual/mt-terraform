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
  org_id = join("_", [for word in split("--", replace(var.organization_name, "/[^\\w]/", "--")) : word])
}

resource "harness_platform_organization" "this" {
  identifier  = local.org_id
  name        = var.organization_name
  description = "The '${var.organization_name}' organization"
  tags        = concat(var.default_tags, ["Demo:true"])
}
