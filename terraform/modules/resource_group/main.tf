terraform {
  required_version = ">= 1.4.6"

  required_providers {
    harness = {
      source  = "harness/harness"
      version = ">= 0.30.2"
    }
  }
}

data "harness_platform_organization" "this" {
  name = var.organization_name == "" ? "unknown" : var.organization_name
}

data "harness_platform_project" "this" {
  name   = var.project_name == "" ? "unknown" : var.project_name
  org_id = var.organization_name == "" ? "unknown" : data.harness_platform_organization.this.id
}

locals {
  usergroup             = var.usergroup == "" ? null : var.usergroup
  resource_group_suffix = var.project_name == "" ? null : var.project_name
  project_id            = var.project_name == "" ? null : data.harness_platform_project.this.id
  project_tag           = var.project_name == "" ? "" : "project:${local.project_id}"
  org_name              = var.usergroup == "account" ? "shared" : var.organization_name
  resource_group        = join("_", [for word in split("--", replace(join(" ", compact([local.org_name, local.resource_group_suffix, local.usergroup])), "/[^\\w]/", "--")) : word])
  resource_group_name   = join("-", compact([local.org_name, local.resource_group_suffix, local.usergroup]))

  resource_level = var.usergroup == "account" ? "account" : var.project_name == "" ? "org" : "project"

  resources = {
    account = {
      connectors = [
        # "ARTIFACTORY",
        "CLOUD_PROVIDER",
        "CODE_REPO",
        "SECRET_MANAGER",
      ],
    },
    org = {
      connectors = [
        # "ARTIFACTORY",
        # "CLOUD_PROVIDER",
        # "CODE_REPO",
        # "SECRET_MANAGER",
      ],
    },
    project = {
      connectors = [
        "ARTIFACTORY",
        # "CLOUD_PROVIDER",
        # "CODE_REPO",
        "SECRET_MANAGER",
      ],
    },
  }

  abac_account = [
    # "ACCOUNT",
    # "AUDIT",
    # "AUTHSETTING",
    # "CCM_ANOMALIES",
    # "CCM_AUTOSTOPPINGRULE",
    # "CCM_BUDGET",
    # "CCM_CLOUD_ASSET_GOVERNANCE_RULE_ENFORCEMENT",
    # "CCM_CLOUD_ASSET_GOVERNANCE_RULE_SET",
    # "CCM_CLOUD_ASSET_GOVERNANCE_RULE",
    # "CCM_COMMITMENT_ORCHESTRATOR",
    # "CCM_COSTCATEGORY",
    # "CCM_CURRENCYPREFERENCE",
    # "CCM_FOLDER",
    # "CCM_LOADBALANCER ",
    # "CCM_OVERVIEW",
    # "CCM_PERSPECTIVE",
    # "CCM_RECOMMENDATIONS",
    # "CET_AGENT",
    # "CET_CRITICAL_EVENT",
    # "CET_TOKEN",
    # "CHAOS_EXPERIMENT",
    # "CHAOS_GAMEDAY",
    # "CHAOS_HUB",
    # "CHAOS_INFRASTRUCTURE",
    # "CHAOS_SECURITY_GOVERNANCE",
    # "CODE_REPOSITORY",
    # "DASHBOARDS",
    "DELEGATE",
    # "DELEGATECONFIGURATION",
    # "DEPLOYMENTFREEZE",
    # "DOWNTIME",
    # "ENVIRONMENT_GROUP",
    # "FEATUREFLAG",
    # "FILE",
    # "GITOPS_AGENT",
    # "GITOPS_APP",
    # "GITOPS_CERT",
    # "GITOPS_CLUSTER",
    # "GITOPS_GPGKEY",
    # "GITOPS_REPOSITORY",
    # "GOVERNANCEPOLICY",
    # "GOVERNANCEPOLICYSETS",
    # "IAC_WORKSPACE",
    # "IDP_ADVANCED_CONFIGURATION",
    # "IDP_CATALOG_ACCESS_POLICY",
    # "IDP_INTEGRATION",
    # "IDP_LAYOUT",
    # "IDP_PLUGIN",
    # "IDP_SCORECARD",
    # "IDP_SETTINGS",
    # "INPUT_SET",
    # "LICENSE",
    # "MONITOREDSERVICE",
    # "NETWORK_MAP",
    # "ORGANIZATION",
    # "PIPELINE",
    # "PROJECT",
    # "RESOURCEGROUP",
    # "ROLE",
    # "SECRET",
    # "SEI_COLLECTIONS",
    # "SEI_CONFIGURATION_SETTINGS",
    # "SEI_INSIGHTS",
    # "SERVICE",
    # "SERVICEACCOUNT",
    # "SETTING",
    # "SLO",
    # "SMTP",
    # "STO_EXEMPTION",
    # "STO_ISSUE",
    # "STO_SCAN",
    # "STO_TESTTARGET",
    # "STREAMING_DESTINATION",
    # "TARGET",
    # "TARGETGROUP",
    "TEMPLATE",
    # "TICKET",
    # "USER",
    # "USERGROUP",
    # "VARIABLE",
  ]

  abac_non_account = local.resource_level != "account" ? concat(local.abac_account, [
    "CHAOS_EXPERIMENT",
    "CHAOS_GAMEDAY",
    "CHAOS_HUB",
    "CHAOS_INFRASTRUCTURE",
    "CHAOS_SECURITY_GOVERNANCE",
    "FEATUREFLAG",
    "FILE",
    "INPUT_SET",
    "ORGANIZATION",
    "PIPELINE",
    "PROJECT",
    "SECRET",
    "SEI_COLLECTIONS",
    "SEI_CONFIGURATION_SETTINGS",
    "SEI_INSIGHTS",
    "SERVICE",
    "STO_EXEMPTION",
    "STO_ISSUE",
    "STO_SCAN",
    "STO_TESTTARGET",
    "TARGET",
    "TARGETGROUP",
    "VARIABLE",
  ]) : local.abac_account

  abac_merged = var.usergroup == "platform-engineer" ? concat(local.abac_non_account, [
    "GITOPS_AGENT",
    "GITOPS_APP",
    "GITOPS_CERT",
    "GITOPS_CLUSTER",
    "GITOPS_GPGKEY",
    "GITOPS_REPOSITORY",
  ]) : local.abac_non_account
}

resource "harness_platform_resource_group" "this" {
  identifier  = local.resource_group
  name        = local.resource_group_name
  description = "The '${local.resource_group}' resource group"
  tags        = concat(var.default_tags, ["organization:${data.harness_platform_organization.this.id}", local.project_tag])

  account_id = var.harness_account_id
  # org_id     = data.harness_platform_organization.this.id
  # project_id = local.project_id

  allowed_scope_levels = [
    "account",
    # "org",
    # "project",
  ]

  dynamic "included_scopes" {
    for_each = var.usergroup == "account" ? [] : [var.usergroup]
    content {
      filter     = var.project_name == "" ? "INCLUDING_CHILD_SCOPES" : "EXCLUDING_CHILD_SCOPES"
      account_id = var.harness_account_id
      org_id     = data.harness_platform_organization.this.id
      # project_id = local.project_id
    }
  }

  dynamic "included_scopes" {
    for_each = var.usergroup == "account" ? [] : [var.usergroup]
    content {
      filter     = var.project_name == "" ? "INCLUDING_CHILD_SCOPES" : "EXCLUDING_CHILD_SCOPES"
      account_id = var.harness_account_id
      org_id     = data.harness_platform_organization.this.id
      project_id = local.project_id
    }
  }

  resource_filter {
    include_all_resources = var.usergroup == "admin" ? true : false

    dynamic "resources" {
      for_each = contains(["admin", "account"], var.usergroup) ? [] : [var.usergroup]
      content {
        resource_type = "ENVIRONMENT"
        attribute_filter {
          attribute_name = "type"
          attribute_values = [
            var.usergroup == "release-manager" ? "Production" : "PreProduction",
          ]
        }
      }
    }

    dynamic "resources" {
      for_each = contains(["admin", "account-temp-disabled"], var.usergroup) ? [] : [var.usergroup]
      content {
        resource_type = "CONNECTOR"

        # attribute_filter {
        #   attribute_name   = "category"
        #   attribute_values = local.resources[local.resource_level].connectors
        # }
      }
    }

    # dynamic "resources" {
    #   for_each = var.usergroup != "account" ? [] : [var.usergroup]
    #   content {
    #     resource_type = "CONNECTOR"
    #     identifiers   = local.account_resources.connectors
    #   }
    # }

    dynamic "resources" {
      for_each = var.usergroup == "admin" ? [] : local.abac_merged
      content {
        # identifiers   = []
        resource_type = resources.value
      }
    }
  }
}
