output "this" {
  value = harness_platform_project.this != null ? harness_platform_project.this : toset({ id : "" })
}
