output "vnet_name" {
  value = module.network.vnet_name
}

output "resource_group_name" {
  value = azurerm_resource_group.infrastructure_rg.name
}

output "cluster_id" {
  value = module.mongodb_atlas_config.cluster_id
}

output "project_name" {
  value = module.mongodb_atlas_config.project_name
}

output "mongodb_project_id" {
  value = module.mongodb_atlas_config.project_id
}
output "privatelink_id" {
  value = module.mongodb_atlas_config.privatelink_id
}

output "atlas_pe_service_id" {
  value = module.mongodb_atlas_config.atlas_pe_service_id
}

output "atlas_privatelink_endpoint_id" {
  value = module.mongodb_atlas_config.atlas_privatelink_endpoint_id
}

output "infra_resource_group_name" {
  value = azurerm_resource_group.infrastructure_rg.name
}
