resource "azurerm_virtual_network_peering" "this_to_peer" {
  name                      = var.name_this_to_peer
  resource_group_name       = var.resource_group_name_this
  virtual_network_name      = var.vnet_name_this
  remote_virtual_network_id = var.vnet_id_peer

  allow_forwarded_traffic = var.allow_forwarded_traffic
  allow_gateway_transit   = var.allow_gateway_transit
  use_remote_gateways     = var.use_remote_gateways
}

resource "azurerm_virtual_network_peering" "peer_to_this" {
  name                      = var.name_peer_to_this
  resource_group_name       = var.resource_group_name_peer
  virtual_network_name      = var.vnet_name_peer
  remote_virtual_network_id = var.vnet_id_this

  allow_forwarded_traffic = var.allow_forwarded_traffic
  allow_gateway_transit   = var.allow_gateway_transit
  use_remote_gateways     = var.use_remote_gateways
}
