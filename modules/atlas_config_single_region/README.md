# MongoDB Atlas Single-Region Configuration Module

This module configures a MongoDB Atlas project, advanced cluster, and Azure PrivateLink endpoint for **single-region deployments** using the official Terraform `mongodbatlas` provider.

> **Use this module if you require a MongoDB Atlas cluster in a single cloud region.**

## Features

- Creates a MongoDB Atlas project (if not existing)
- Provisions an advanced (dedicated) cluster (M10+) **in a single region**
- Supports flexible cluster sizing and replication setup within one region
- Provisions an Azure PrivateLink endpoint for secure connectivity
- Configures automated backup schedule with customizable policies

## Inputs

| Name              | Description                                 | Type     | Required/Default |
|-------------------|---------------------------------------------|----------|------------------|
| `org_id`          | MongoDB Atlas organization ID                | `string` | required         |
| `project_name`    | Name of the Atlas project                    | `string` | required         |
| `cluster_name`    | Name of the cluster                          | `string` | required         |
| `cluster_type`    | Cluster type (e.g. `REPLICASET`)             | `string` | required         |
| `instance_size`   | Cluster tier (e.g. `M10`, `M20`)             | `string` | required         |
| `region`          | **Atlas region (e.g. `WESTERN_EUROPE`)**     | `string` | required         |
| `zone_name`       | Logical zone name                            | `string` | required         |
| `num_shards`      | Number of shards                             | `number` | required         |
| `electable_nodes` | Number of electable nodes                    | `number` | required         |
| `priority`        | Election priority                            | `number` | required         |
| `backup_enabled`  | Whether to enable backups                    | `bool`   | required         |
| `reference_hour_of_day` | Hour of day for backup reference time (0-23) | `number` | default: 3       |
| `reference_minute_of_hour` | Minute of hour for backup reference time (0-59) | `number` | default: 45      |
| `restore_window_days` | Number of days for restore window           | `number` | default: 4       |

> **Note:** The `region` input is a single value, not a list. For multi-region clusters, use the multi-region module instead.

## Outputs

| Name                        | Description                                      |
|-----------------------------|--------------------------------------------------|
| `cluster_id`                | ID of the MongoDB cluster                        |
| `project_id`                | ID of the MongoDB Atlas project                  |
| `project_name`              | Name of the MongoDB Atlas project                |
| `privatelink_id`            | ID of the Atlas PrivateLink endpoint             |
| `atlas_pe_service_id`       | Atlas PrivateLink service resource ID            |
| `atlas_privatelink_endpoint_id` | ID of the Atlas PrivateLink endpoint         |

## Example Usage

```hcl
module "mongodbatlas_config" {
  source         = "../../modules/atlas_config_single_region"
  org_id         = var.org_id
  project_name   = "my-project"
  cluster_name   = "cluster1"
  cluster_type   = "REPLICASET"
  instance_size  = "M10"
  region         = "WESTERN_EUROPE"
  zone_name      = "Zone 1"
  num_shards     = 1
  electable_nodes = 3
  priority       = 7
  backup_enabled = true
}
```

---

## Backup Configuration

MongoDB Atlas provides automated backups to ensure data durability and disaster recovery. Backups are stored in the cluster's primary region. This module allows you to configure backup settings for your cluster, including the reference time for backups and the restore window duration.

### Key Features of Backup

- **Automated Backups:** Backups are automatically created based on the specified reference time.
- **Restore Window:** You can define the number of days for the restore window, allowing you to recover data within this period.

### Backup Configuration Inputs

| Name                     | Description                                      | Type   | Default |
|--------------------------|--------------------------------------------------|--------|---------|
| `reference_hour_of_day`  | Hour of the day for backup reference time (0-23) | `number` | `3`     |
| `reference_minute_of_hour` | Minute of the hour for backup reference time (0-59) | `number` | `45`    |
| `restore_window_days`    | Number of days for the restore window            | `number` | `4`     |

### Example Usage

```hcl
resource "mongodbatlas_cloud_backup_schedule" "backup" {
  project_id   = mongodbatlas_project.project.id
  cluster_name = mongodbatlas_advanced_cluster.this.name

  reference_hour_of_day    = var.reference_hour_of_day
  reference_minute_of_hour = var.reference_minute_of_hour
  restore_window_days      = var.restore_window_days
}
```
