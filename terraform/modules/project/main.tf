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
  project_id = join("_", [for word in split("--", replace(var.project, "/[^\\w]/", "--")) : word])
}

data "harness_platform_organization" "this" {
  name = var.organization_name
}

resource "harness_platform_project" "this" {
  identifier  = local.project_id
  name        = var.project
  description = "The '${var.project}' project"
  tags        = concat(var.default_tags, ["organization:${data.harness_platform_organization.this.id}", "project:${local.project_id}"])
  org_id      = data.harness_platform_organization.this.id
  color       = "#0063F7"
}
