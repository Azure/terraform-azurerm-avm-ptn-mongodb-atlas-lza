output "peering_ids" {
  description = "IDs of both peerings"
  value = {
    this_to_peer = azurerm_virtual_network_peering.this_to_peer.id
    peer_to_this = azurerm_virtual_network_peering.peer_to_this.id
  }
}
