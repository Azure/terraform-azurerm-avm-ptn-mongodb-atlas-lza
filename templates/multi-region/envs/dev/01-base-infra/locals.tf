locals {
  location    = "eastus2"
  environment = "dev"

  project_name = var.project_name

  tags = {
    environment = local.environment
    project     = local.project_name
  }

  org_id                   = var.org_id
  cluster_name             = var.cluster_name
  cluster_type             = "REPLICASET"
  backup_enabled           = true
  reference_hour_of_day    = 3
  reference_minute_of_hour = 45
  restore_window_days      = 4

  naming_suffix_base = "inframulregion"

  # Disclaimer: Ensure that the `instance_size` is consistent across all regions specified in `region_configs`. Refer to the official documentation for more details: https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/advanced_cluster#electable_specs-1
  # Disclaimer: The `node_count` must be either 3, 5, or 7. Refer to the official documentation for more details: https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/cluster.html?utm_source=chatgpt.com#electable_nodes-1

  region_definitions = {
    eastus = {
      atlas_region                                   = "US_EAST"
      azure_region                                   = "eastus"
      priority                                       = 7
      address_space                                  = ["10.0.0.0/16"]
      private_subnet_prefixes                        = ["10.0.1.0/24"]
      deploy_observability_subnets                   = true
      observability_function_app_subnet_prefixes     = ["10.0.2.0/24"]
      observability_private_endpoint_subnet_prefixes = ["10.0.3.0/24"]
      node_count                                     = 2
    }
    eastus2 = {
      atlas_region                 = "US_EAST_2"
      azure_region                 = "eastus2"
      priority                     = 6
      address_space                = ["10.1.0.0/16"]
      private_subnet_prefixes      = ["10.1.1.0/24"]
      deploy_observability_subnets = false
      node_count                   = 2
    }
    westus = {
      atlas_region                 = "US_WEST"
      azure_region                 = "westus"
      priority                     = 5
      address_space                = ["10.2.0.0/16"]
      private_subnet_prefixes      = ["10.2.1.0/24"]
      deploy_observability_subnets = false
      node_count                   = 1
    }
  }

  # For Atlas cluster
  region_configs = {
    for k, v in local.region_definitions : k => {
      atlas_region = v.atlas_region
      azure_region = v.azure_region
      priority     = v.priority
      electable_specs = {
        instance_size = "M10"
        node_count    = v.node_count
      }
    }
  }

  # For Azure resources
  regions = {
    for k, v in local.region_definitions : k => {
      location                                       = v.azure_region
      address_space                                  = v.address_space
      private_subnet_prefixes                        = v.private_subnet_prefixes
      manual_connection                              = true
      deploy_observability_subnets                   = v.deploy_observability_subnets
      observability_function_app_subnet_prefixes     = v.deploy_observability_subnets ? v.observability_function_app_subnet_prefixes : null
      observability_private_endpoint_subnet_prefixes = v.deploy_observability_subnets ? v.observability_private_endpoint_subnet_prefixes : null
    }
  }

  vnet_keys  = sort(keys(module.network))
  pair_list  = flatten([for i, a in local.vnet_keys : [for j, b in local.vnet_keys : { key = "${a}|${b}", a = a, b = b } if i < j]])
  vnet_pairs = { for p in local.pair_list : p.key => { a = p.a, b = p.b } }

  mongo_atlas_client_id     = var.mongo_atlas_client_id
  mongo_atlas_client_secret = var.mongo_atlas_client_secret
}
