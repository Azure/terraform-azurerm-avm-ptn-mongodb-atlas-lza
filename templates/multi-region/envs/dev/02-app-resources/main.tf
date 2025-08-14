# Application Modules
module "application" {
  for_each = local.app_information_by_region

  source = "../../../../../modules/application"

  # Resource Group Configuration
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  # App Service Plan Configuration
  app_service_plan_name = each.value.app_service_plan_name
  app_service_plan_sku  = each.value.app_service_plan_sku

  # Network Configuration
  virtual_network_name     = each.value.virtual_network_name
  subnet_name              = each.value.subnet_name
  address_prefixes         = each.value.address_prefixes
  vnet_resource_group_name = data.terraform_remote_state.common.outputs.infra_resource_group_name

  # Web App Configuration
  app_web_app_name = each.value.app_web_app_name
  # Tags
  tags = local.tags
}
