variable "resource_group_name_tfstate" {
  description = "Name of Resource Group for TF state"
  type        = string
}

variable "storage_account_name_tfstate" {
  description = "Name of Storage Account for TF state"
  type        = string
}

variable "container_name_tfstate" {
  description = "Name of Container for TF state"
  type        = string
}

variable "key_name_infra_tfstate" {
  description = "Name of Key for infrastructure TF state"
  type        = string
}

variable "key_name_tfstate" {
  description = "Name of Key for devops TF state"
  type        = string
}
