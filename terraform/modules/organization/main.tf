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


resource "harness_platform_organization" "this" {
  count = data.harness_platform_organization.this != null ? 0 : 1

  identifier  = lower(replace(var.organization_name, "/[^\\w]/", ""))
  name        = lower(replace(var.organization_name, "/[^\\w]/", ""))
  description = "An example organization managed by Terraform."
  tags        = concat(var.default_tags, ["Demo:true"])
}
