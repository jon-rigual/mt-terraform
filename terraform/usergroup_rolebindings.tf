resource "harness_platform_role_assignments" "this" {
  count                     = length(harness_platform_resource_group.this) != "" ? 1 : 0
  resource_group_identifier = harness_platform_resource_group.this[0].id
  role_identifier           = harness_platform_roles.this.id
  principal {
    identifier = harness_platform_usergroup.this.id
    type       = "USER_GROUP"
  }
  disabled = false
  managed  = false
}
