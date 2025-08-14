resource "azurerm_resource_group" "infrastructure_rg" {
  name     = module.naming.resource_group.name_unique
  location = local.location
}


module "mongodb_atlas_config" {
  source                   = "../../../../../modules/atlas_config_multi_region"
  org_id                   = local.org_id
  cluster_name             = local.cluster_name
  cluster_type             = local.cluster_type
  instance_size            = local.instance_size
  backup_enabled           = local.backup_enabled
  region_configs           = local.region_configs
  project_name             = local.project_name
  reference_hour_of_day    = local.reference_hour_of_day
  reference_minute_of_hour = local.reference_minute_of_hour
  restore_window_days      = local.restore_window_days

  providers = {
    mongodbatlas = mongodbatlas
  }
}

module "network" {
  for_each                        = local.regions
  source                          = "../../../../../modules/network"
  location                        = each.value.location
  resource_group_name             = azurerm_resource_group.infrastructure_rg.name
  vnet_name                       = "${module.naming.virtual_network.name_unique}-${each.key}"
  private_subnet_name             = "${module.naming.subnet.name_unique}-${each.key}"
  public_ip_name                  = "${module.naming.public_ip.name_unique}-${each.key}"
  nat_gateway_name                = "${module.naming.nat_gateway.name_unique}-${each.key}"
  nsg_name                        = "${module.naming.network_security_group.name_unique}-${each.key}"
  private_endpoint_name           = "${module.naming.private_endpoint.name_unique}-${each.key}"
  private_service_connection_name = "${module.naming.private_service_connection.name_unique}-${each.key}"

  address_space                  = each.value.address_space
  private_subnet_prefixes        = each.value.private_subnet_prefixes
  manual_connection              = each.value.manual_connection
  tags                           = local.tags
  private_connection_resource_id = module.mongodb_atlas_config.atlas_pe_service_ids[each.key]
  private_link_id                = module.mongodb_atlas_config.atlas_privatelink_endpoint_ids[each.key]
  project_id                     = module.mongodb_atlas_config.project_id

  providers = {
    mongodbatlas = mongodbatlas
  }
}

module "vnet_peerings" {
  for_each = local.vnet_pairs
  source   = "../../../../../modules/vnet_peering"

  name_this_to_peer = "${each.value.a}-to-${each.value.b}"
  name_peer_to_this = "${each.value.b}-to-${each.value.a}"

  resource_group_name_this = azurerm_resource_group.infrastructure_rg.name
  resource_group_name_peer = azurerm_resource_group.infrastructure_rg.name

  vnet_name_this = module.network[each.value.a].vnet_name
  vnet_name_peer = module.network[each.value.b].vnet_name
  vnet_id_this   = module.network[each.value.a].vnet_id
  vnet_id_peer   = module.network[each.value.b].vnet_id

  allow_forwarded_traffic = true
  allow_gateway_transit   = false
  use_remote_gateways     = false
}
