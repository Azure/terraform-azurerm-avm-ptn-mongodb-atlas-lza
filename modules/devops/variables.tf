variable "tags" {
  type        = map(string)
  description = "A map of tags to be applied to resources"
}

variable "resource_group_name_devops" {
  type        = string
  description = "The name of the DevOps resource group"
}

variable "resource_group_name_app" {
  type        = string
  default     = ""
  description = "(Optional) The name of the application resource group. If not provided, the application resource group will not be created."
}

variable "resource_group_name_infrastructure" {
  type        = string
  description = "The name of the infrastructure resource group"
}

variable "location" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "account_tier" {
  type    = string
  default = "Standard"
}

variable "replication_type" {
  type    = string
  default = "LRS"
}

variable "container_name" {
  type = string
}

variable "container_access_type" {
  type    = string
  default = "private"
}

# Identity

variable "audiences" {
  type = list(string)
}

variable "issuer" {
  type = string
}

variable "federation" {
  type = map(string)
}
