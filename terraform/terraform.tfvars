default_tags = [
  "iac:terraform",
]

entities = {
  "organization" = "Org 1"
  "projects" = [
    "Project 1",
    "Project 2",
  ]
}

roles = {
  "organization" = [
    "admin",
  ]
  "project" = [
    "admin",
    "release-manager",
    "platform-engineer",
    "developer",
  ]
}

linked_sso_display_name = "Marriott LDAP"

# <harness org>-admin – Harness organizational admin
# < harness org >-<project>-admin – Harness project admin (pipeline creator)
# < harness org >-< project >-release-manager - Able to approve to move through gates
# < harness org >-< project >-platform-engineer – Nothing as of now
# < harness org >-< project >-developer – Pipeline executor
