data "mongodbatlas_organization" "org" {
  org_id = var.org_id
}

resource "mongodbatlas_project" "project" {
  name   = var.project_name
  org_id = data.mongodbatlas_organization.org.id

  is_collect_database_specifics_statistics_enabled = true
  is_data_explorer_enabled                         = true
  is_extended_storage_sizes_enabled                = true
  is_performance_advisor_enabled                   = true
  is_realtime_performance_panel_enabled            = true
  is_schema_advisor_enabled                        = true
}

resource "mongodbatlas_advanced_cluster" "this" {
  project_id     = mongodbatlas_project.project.id
  name           = var.cluster_name
  cluster_type   = var.cluster_type
  backup_enabled = var.backup_enabled
  replication_specs {
    region_configs {
      electable_specs {
        instance_size = var.instance_size
        node_count    = var.electable_nodes
      }

      provider_name = "AZURE"
      priority      = var.priority
      region_name   = var.region
    }
  }
}

resource "mongodbatlas_privatelink_endpoint" "azure" {
  project_id    = mongodbatlas_project.project.id
  provider_name = "AZURE"
  region        = var.region
}

resource "mongodbatlas_cloud_backup_schedule" "backup" {
  project_id   = mongodbatlas_project.project.id
  cluster_name = mongodbatlas_advanced_cluster.this.name

  reference_hour_of_day    = var.reference_hour_of_day
  reference_minute_of_hour = var.reference_minute_of_hour
  restore_window_days      = var.restore_window_days
}