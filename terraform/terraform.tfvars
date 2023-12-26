default_tags = [
  "IaC:Terraform",
  "Project:Example",
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
