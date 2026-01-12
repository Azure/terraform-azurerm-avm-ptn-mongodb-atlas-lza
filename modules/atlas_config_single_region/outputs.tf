output "cluster_id" {
  value = mongodbatlas_advanced_cluster.this.id
}

output "project_name" {
  value = mongodbatlas_project.project.name
}

output "project_id" {
  value = mongodbatlas_project.project.id
}
output "privatelink_id" {
  value = mongodbatlas_privatelink_endpoint.azure.id
}

output "atlas_pe_service_id" {
  value = mongodbatlas_privatelink_endpoint.azure.private_link_service_resource_id
}

output "atlas_privatelink_endpoint_id" {
  value = mongodbatlas_privatelink_endpoint.azure.id
}
