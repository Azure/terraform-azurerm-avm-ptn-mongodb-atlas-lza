output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Name of the Virtual Network"
  value       = azurerm_virtual_network.this.name
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = azurerm_subnet.private.id
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = azurerm_nat_gateway.nat.id
}

output "nat_gateway_public_ip" {
  description = "Public IP of the NAT Gateway"
  value       = azurerm_public_ip.nat_ip.ip_address
}

output "private_subnet_nsg_id" {
  description = "ID of the NSG associated with the private subnet"
  value       = azurerm_network_security_group.nsg.id
}

output "private_endpoint_id" {
  description = "ID of the MongoDB private endpoint"
  value       = azurerm_private_endpoint.mongodb.id
}
