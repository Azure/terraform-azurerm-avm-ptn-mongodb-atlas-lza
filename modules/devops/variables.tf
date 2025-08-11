variable "tags" {
  type        = map(string)
  description = "A map of tags to be applied to resources"
}

variable "resource_group_name" {
  type = string
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

variable "permissions" {
  type = map(object({
    subscription_id = string
    role            = string
  }))
}

variable "federation" {
  type = map(string)
}
