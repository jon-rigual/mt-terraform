output "this" {
  value = data.harness_platform_project.this != null ? data.harness_platform_project.this : tomap(harness_platform_project.this)
}
