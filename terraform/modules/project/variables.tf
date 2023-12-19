variable "harness_endpoint" {
  description = "The Harness Endpoint"
  type        = string
}

variable "harness_account_id" {
  description = "The Harness Account ID"
  type        = string
}

variable "harness_api_key" {
  description = "The Harness API Key"
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

variable "organization_id" {
  description = "Organization ID to associate with"
  type        = string
}

variable "project" {
  description = "Organization the automation will run and create objects for"
  type        = string
}
