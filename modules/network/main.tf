resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  tags                = var.tags
}

resource "azurerm_subnet" "private" {
  name                 = var.private_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.private_subnet_prefixes
}

resource "azurerm_public_ip" "nat_ip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "nat" {
  name                = var.nat_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "nat_assoc" {
  nat_gateway_id       = azurerm_nat_gateway.nat.id
  public_ip_address_id = azurerm_public_ip.nat_ip.id
}

resource "azurerm_subnet_nat_gateway_association" "assoc" {
  subnet_id      = azurerm_subnet.private.id
  nat_gateway_id = azurerm_nat_gateway.nat.id
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "private_subnet_nsg" {
  subnet_id                 = azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_private_endpoint" "mongodb" {
  name                = var.private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.private.id
  tags                = var.tags

  private_service_connection {
    name                           = var.private_service_connection_name
    private_connection_resource_id = var.private_connection_resource_id
    is_manual_connection           = var.manual_connection
    request_message                = var.request_message
  }
}

resource "mongodbatlas_privatelink_endpoint_service" "endpoint_service" {
  project_id                  = var.project_id
  private_link_id             = var.private_link_id
  endpoint_service_id         = azurerm_private_endpoint.mongodb.id
  private_endpoint_ip_address = azurerm_private_endpoint.mongodb.private_service_connection[0].private_ip_address
  provider_name               = "AZURE"
}
