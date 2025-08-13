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

variable "app_service_plan_name" {
  type        = string
  description = "Name of the App Service Plan"
}

variable "app_web_app_name" {
  type        = string
  description = "Name of the Windows Web App"
}

variable "app_service_plan_sku" {
  type        = string
  default     = "B1"
  description = "SKU for the App Service Plan"
}

variable "virtual_network_name" {
  type        = string
  description = "Name of the Virtual Network for the Web App"
}

variable "address_prefixes" {
  type        = list(string)
  description = "List of address prefixes for the application subnet"
  default     = ["10.0.2.0/24"]
}

variable "subnet_name" {
  type        = string
  default     = "application-subnet"
  description = "Name of the subnet for the application"
}

variable "vnet_resource_group_name" {
  type        = string
  description = "Name of the resource group where the Virtual Network is located"
}
