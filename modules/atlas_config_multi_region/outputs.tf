output "cluster_id" {
  value = mongodbatlas_advanced_cluster.this.id
}

output "project_name" {
  value = mongodbatlas_project.project.name
}

output "project_id" {
  value = mongodbatlas_project.project.id
}

output "privatelink_ids" {
  value = {
    for region, pe in mongodbatlas_privatelink_endpoint.azure :
    region => pe.id
  }
}

output "atlas_pe_service_ids" {
  value = {
    for region, pe in mongodbatlas_privatelink_endpoint.azure :
    region => pe.private_link_service_resource_id
  }
}

output "atlas_privatelink_endpoint_ids" {
  value = {
    for region, pe in mongodbatlas_privatelink_endpoint.azure :
    region => pe.id
  }
}
