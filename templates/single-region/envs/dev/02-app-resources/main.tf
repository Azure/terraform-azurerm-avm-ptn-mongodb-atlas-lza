# Application Module
module "application" {
  source = "../../../../../modules/application"

  # App Service Plan Configuration
  app_service_plan_name = local.app_service_plan_name
  app_service_plan_sku  = local.app_service_plan_sku

  # Network Configuration
  virtual_network_name     = local.virtual_network_name
  subnet_name              = local.subnet_name
  address_prefixes         = local.address_prefixes
  vnet_resource_group_name = data.azurerm_resource_group.infrastructure_rg.name

  # Web App Configuration
  app_web_app_name = local.app_web_app_name

  resource_group_name = data.azurerm_resource_group.app_rg.name
  location            = local.location

  tags = local.tags
}

data "azurerm_resource_group" "app_rg" {
  name = data.terraform_remote_state.devops.outputs.resource_group_names.app
}

data "azurerm_resource_group" "infrastructure_rg" {
  name = data.terraform_remote_state.devops.outputs.resource_group_names.infrastructure
}
