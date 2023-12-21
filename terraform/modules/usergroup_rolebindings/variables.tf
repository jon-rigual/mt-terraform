variable "default_tags" {
  description = "Default tags to apply to all resources"
  type        = list(string)
  default     = []
}

variable "organization_name" {
  description = "Organization name to associate with"
  type        = string
}

variable "project" {
  description = "Organization the automation will run and create objects for"
  type        = string
  default     = "unknown"
}

variable "role" {
  description = "Role to associate with"
  type        = string
}

variable "usergroup" {
  description = "User Group to associate with"
  type        = string
}
