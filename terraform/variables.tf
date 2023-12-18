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

variable "instance" {
  description = "The Harness Instance"
  type        = string
}

variable "default_tags" {
  description = "Default tags to apply to all resources"
  type        = list(string)
  default     = []
}

variable "delegate_name" {
  description = "The Harness Delegate Name"
  type        = string
}

variable "namespace" {
  description = "The Kubernetes Namespace"
  type        = string
}

variable "organization" {
  description = "Organization the automation will run and create objects for"
  type        = string
}

variable "project" {
  description = "Organization the automation will run and create objects for"
  type        = string
}
