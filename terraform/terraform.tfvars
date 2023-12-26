default_tags = [
  "iac:terraform",
]

entities = {
  "organization" = "foo"
  "projects" = [
    "bar",
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
