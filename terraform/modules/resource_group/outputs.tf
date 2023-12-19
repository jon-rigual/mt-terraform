output "this" {
  value = data.harness_platform_resource_group.this != null ? data.harness_platform_resource_group.this : tomap(harness_platform_resource_group.this)
}
