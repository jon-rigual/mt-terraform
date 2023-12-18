resource "harness_platform_organization" "this" {
  identifier  = lower(join("_", [var.instance, "organization"]))
  name        = lower(join(" ", [var.instance, "organization"]))
  description = "An example organization managed by Terraform."
  tags        = concat(var.default_tags, ["Demo:true"])
}
