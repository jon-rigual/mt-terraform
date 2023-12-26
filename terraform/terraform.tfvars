default_tags = [
  "iac:terraform",
]

entities = {
  "organization" = "A complex-Organization-name"
  "projects" = [
    "A complex-Project-name",
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
