resource "harness_platform_role_assignments" "example1" {
  org_id      = harness_platform_organization.this.id
  project_id  = harness_platform_project.this.id
  resource_group_identifier = harness_platform_resource_group.this.id
  role_identifier           = harness_platform_roles.this.id
  principal {
    identifier = harness_platform_usergroup.this.id
    type       = "USER_GROUP"
  }
  disabled = false
  managed  = false
}