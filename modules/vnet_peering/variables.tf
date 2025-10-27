variable "name_this_to_peer" {
  type        = string
  description = "Name of the peering from this VNet to the peer VNet"
}

variable "name_peer_to_this" {
  type        = string
  description = "Name of the peering from the peer VNet to this VNet"
}

variable "resource_group_name_this" {
  type        = string
  description = "Resource group of the first VNet"
}

variable "resource_group_name_peer" {
  type        = string
  description = "Resource group of the second VNet"
}

variable "vnet_name_this" {
  type        = string
  description = "Name of the first VNet"
}

variable "vnet_name_peer" {
  type        = string
  description = "Name of the second VNet"
}

variable "vnet_id_this" {
  type        = string
  description = "ID of the first VNet"
}

variable "vnet_id_peer" {
  type        = string
  description = "ID of the second VNet"
}

variable "allow_forwarded_traffic" {
  type    = bool
  default = false
}

variable "allow_gateway_transit" {
  type    = bool
  default = false
}

variable "use_remote_gateways" {
  type    = bool
  default = false
}
