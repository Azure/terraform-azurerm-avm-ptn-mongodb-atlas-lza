locals {
  location    = "eastus2"
  environment = "dev"

  purge_protection_enabled = true

  project_name = "atlas-mongodb"

  vnet_address_space      = ["10.0.0.0/16"]
  private_subnet_prefixes = ["10.0.1.0/24"]
  tags = {
    environment = local.environment
    location    = local.location
    project     = local.project_name
  }

  org_id                   = "your-org-id"
  cluster_name             = "your-cluster-name"
  cluster_type             = "REPLICASET"
  instance_size            = "M10"
  backup_enabled           = true
  num_shards               = 1
  zone_name                = "Zone 1"
  region                   = "US_EAST_2"
  electable_nodes          = 3
  priority                 = 7
  manual_connection        = true
  reference_hour_of_day    = 3
  reference_minute_of_hour = 45
  restore_window_days      = 4

  naming_suffix_base = "atlas-base-infra"
}
