variable "public_ip_name" {
  description = "The name of the public IP resource."
  type        = string
}

variable "nat_gateway_name" {
  description = "The name of the NAT gateway resource."
  type        = string
}

variable "nsg_name" {
  description = "The name of the network security group."
  type        = string
}
variable "vnet_name" {
  description = "Name of the virtual network."
  type        = string
}

variable "location" {
  description = "Azure region for all network resources."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where the network resources are deployed."
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network."
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to all network resources."
  type        = map(string)
}

variable "private_subnet_name" {
  description = "Name of the private subnet."
  type        = string
}

variable "private_subnet_prefixes" {
  description = "Address prefixes for the private subnet."
  type        = list(string)
}

# Private Endpoint variables
variable "private_endpoint_name" {
  description = "Name of the private endpoint for MongoDB."
  type        = string
}

variable "private_service_connection_name" {
  description = "Name of the private service connection."
  type        = string
}

variable "manual_connection" {
  description = "Whether the private endpoint requires manual approval."
  type        = bool
  default     = false
}

variable "private_connection_resource_id" {
  description = "The resource ID of the private connection"
  type        = string
}

variable "request_message" {
  description = "Message for manual private endpoint connection approval."
  type        = string
  default     = "Please approve this connection for MongoDB Atlas Private Endpoint."
}

variable "project_id" {
  description = "The ID of the MongoDB Atlas project"
  type        = string
}

variable "private_link_id" {
  description = "Atlas Private Link ID."
  type        = any
}
