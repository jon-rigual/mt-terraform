resource "harness_platform_delegatetoken" "this" {
  name       = lower(join(" ", [var.instance, "delegate_token"]))
  account_id = var.harness_account_id
  org_id     = harness_platform_organization.this.id
  project_id = harness_platform_project.this.id
}
