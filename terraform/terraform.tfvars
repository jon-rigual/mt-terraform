instance      = "TF"
delegate_name = "bastion"
namespace     = "default"
default_tags = [
  "IaC:Terraform",
  "Project:Example",
]

structure = {
  "organization" = "foo"
  "projects" = [
    "bar",
  ]
}
