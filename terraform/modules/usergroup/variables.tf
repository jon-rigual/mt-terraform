variable "default_tags" {
  description = "The default tags to apply to all resources"
  type        = list(string)
  default     = []
}

variable "organization_name" {
  description = "The name of the Harness organization"
  type        = string
}

variable "project_name" {
  description = "The name of the Harness project"
  type        = string
  default     = "unknown"
}

variable "usergroup" {
  description = "The name of the Harness user group"
  type        = string
}

variable "linked_sso_id" {
  description = "The ID of the linked SSO provider"
  type        = string
}

variable "linked_sso_display_name" {
  description = "The display name of the linked SSO provider"
  type        = string
}
