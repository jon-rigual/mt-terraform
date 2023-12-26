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
    "security",
  ]
  "project" = [
    "admin",
    "pipeline_creator",
    "pipeline_executor",
  ]
}
