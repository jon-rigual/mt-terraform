output "this" {
  value = data.harness_platform_organization.this != null ? data.harness_platform_organization.this : tomap(harness_platform_organization.this)
}
