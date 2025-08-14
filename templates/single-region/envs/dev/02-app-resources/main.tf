# Application Module
module "application" {
  source = "../../../../../modules/application"

  # Resource Group Configuration
  resource_group_name = local.resource_group_name
  location            = local.location

  # App Service Plan Configuration
  app_service_plan_name = local.app_service_plan_name
  app_service_plan_sku  = local.app_service_plan_sku

  # Network Configuration
  virtual_network_name     = local.virtual_network_name
  subnet_name              = local.subnet_name
  address_prefixes         = local.address_prefixes
  vnet_resource_group_name = data.terraform_remote_state.common.outputs.infra_resource_group_name

  # Web App Configuration
  app_web_app_name = local.app_web_app_name
  # Tags
  tags = local.tags
}
