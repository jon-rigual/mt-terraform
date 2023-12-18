# resource "harness_platform_user" "this" {
#   email       = "i3lfrg+harness_tf_managed@gmail.com"
#   user_groups = [harness_platform_usergroup.this.id]
#   role_bindings {
#     resource_group_identifier = "_all_project_level_resources"
#     resource_group_name       = "All Project Level Resources"
#     role_identifier           = "_project_viewer"
#     role_name                 = "Project Viewer"
#     managed_role              = true
#   }
# }
