resource "azurerm_resource_group" "infrastructure_rg" {
  name     = module.naming.resource_group.name_unique
  location = local.location
}


module "mongodb_atlas_config" {
  source                   = "../../../../../modules/atlas_config_single_region"
  org_id                   = local.org_id
  cluster_name             = local.cluster_name
  cluster_type             = local.cluster_type
  instance_size            = local.instance_size
  backup_enabled           = local.backup_enabled
  region                   = local.region
  electable_nodes          = local.electable_nodes
  priority                 = local.priority
  project_name             = local.project_name
  reference_hour_of_day    = local.reference_hour_of_day
  reference_minute_of_hour = local.reference_minute_of_hour
  restore_window_days      = local.restore_window_days

  providers = {
    mongodbatlas = mongodbatlas
  }
}

module "network" {
  source                                         = "../../../../../modules/network"
  location                                       = local.location
  resource_group_name                            = azurerm_resource_group.infrastructure_rg.name
  vnet_name                                      = module.naming.virtual_network.name
  address_space                                  = local.vnet_address_space
  private_subnet_name                            = module.naming.subnet.name_unique
  private_subnet_prefixes                        = local.private_subnet_prefixes
  public_ip_name                                 = module.naming.public_ip.name_unique
  nat_gateway_name                               = module.naming.nat_gateway.name_unique
  nsg_name                                       = module.naming.network_security_group.name_unique
  tags                                           = local.tags
  private_endpoint_name                          = module.naming.private_endpoint.name
  private_service_connection_name                = module.naming.private_service_connection.name
  manual_connection                              = local.manual_connection
  private_connection_resource_id                 = module.mongodb_atlas_config.atlas_pe_service_id
  project_id                                     = module.mongodb_atlas_config.project_id
  private_link_id                                = module.mongodb_atlas_config.atlas_privatelink_endpoint_id
  deploy_observability_subnets                   = true
  observability_function_app_subnet_name         = "${module.naming.subnet.name_unique}-function-app"
  observability_function_app_subnet_prefixes     = local.observability_function_app_subnet_prefixes
  observability_private_endpoint_subnet_name     = "${module.naming.subnet.name_unique}-private-endpoint"
  observability_private_endpoint_subnet_prefixes = local.observability_private_endpoint_subnet_prefixes

  providers = {
    mongodbatlas = mongodbatlas
  }
}

module "observability" {
  source                          = "../../../../../modules/observability"
  resource_group_name             = azurerm_resource_group.infrastructure_rg.name
  location                        = local.location
  app_insights_name               = module.naming.application_insights.name_unique
  function_app_name               = module.naming.function_app.name_unique
  service_plan_name               = module.naming.app_service_plan.name_unique
  storage_account_name            = module.naming.storage_account.name_unique
  mongo_atlas_client_id           = local.mongo_atlas_client_id
  mongo_atlas_client_secret       = local.mongo_atlas_client_secret
  mongo_group_name                = local.project_name
  function_subnet_id              = module.network.observability_function_app_subnet_id
  private_link_scope_name         = "private_link_scope_sr"
  appinsights_assoc_name          = "private_link_appi_association"
  pe_name                         = module.naming.private_endpoint.name_unique
  network_interface_name          = module.naming.network_interface.name_unique
  private_service_connection_name = module.naming.private_service_connection.name_unique
  vnet_id                         = module.network.vnet_id
  vnet_name                       = module.network.vnet_name
  private_endpoint_subnet_id      = module.network.observability_private_endpoint_subnet_id
}
