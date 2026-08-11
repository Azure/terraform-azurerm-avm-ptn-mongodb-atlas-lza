resource "azurerm_service_plan" "application_service_plan" {
  name                = var.app_service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location

  # Has to be greater than or equal to B1 to support VNet integration
  sku_name = var.app_service_plan_sku
  os_type  = "Windows"
  tags     = var.tags
}

resource "azurerm_subnet" "application_subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.vnet_resource_group_name
  virtual_network_name = var.virtual_network_name

  # Ensure the subnet is defined with a valid address prefix
  # Adjust the address prefix as per your network design
  address_prefixes = var.address_prefixes

  delegation {
    name = "app_delegation"

    service_delegation {
      name = "Microsoft.Web/serverFarms"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action"
      ]
    }
  }
}

resource "azurerm_windows_web_app" "app_web_app" {
  name                = var.app_web_app_name
  resource_group_name = var.resource_group_name
  location            = azurerm_service_plan.application_service_plan.location
  service_plan_id     = azurerm_service_plan.application_service_plan.id

  virtual_network_subnet_id = azurerm_subnet.application_subnet.id

  site_config {
    application_stack {
      dotnet_version = "v8.0"
    }
  }
}
