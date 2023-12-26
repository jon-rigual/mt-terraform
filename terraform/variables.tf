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

variable "entities" {
  description = "Organization and project structure"
  type = object({
    organization = string
    projects     = set(string)
  })
}

variable "roles" {
  description = "Roles to apply to the organization and projects"
  type = object({
    organization = list(string)
    project      = list(string)
  })
}
