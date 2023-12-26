variable "harness_account_id" {
  description = "The Harness Account ID"
  type        = string
}

variable "default_tags" {
  description = "Default tags to apply to all resources"
  type        = list(string)
  default     = []
}

variable "organization_name" {
  description = "Organization name to associate with"
  type        = string
}

variable "project_name" {
  description = "Organization the automation will run and create objects for"
  type        = string
  default     = "unknown"
}
