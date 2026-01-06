# MongoDB Atlas Single-Region Configuration Module

## Overview

This module configures a MongoDB Atlas project, advanced cluster, and Azure PrivateLink endpoint for **single-region deployments** using the official Terraform `mongodbatlas` provider.

> **Use this module if you require a MongoDB Atlas cluster in a single cloud region.**

## Features

- Creates a MongoDB Atlas project (if not existing)
- Provisions an advanced (dedicated) cluster (M10+) **in a single region**
- Supports flexible cluster sizing and replication setup within one region
- Provisions an Azure PrivateLink endpoint for secure connectivity
- Configures automated backup schedule with customizable policies

## Usage

```hcl
module "mongodbatlas_config" {
  source         = "../../modules/atlas_config_single_region"
  org_id         = var.org_id
  project_name   = "my-project"
  cluster_name   = "cluster1"
  cluster_type   = "REPLICASET"
  instance_size  = "M10"
  region         = "WESTERN_EUROPE"
  electable_nodes = 3
  priority       = 7
  backup_enabled = true
}
```

## Inputs

| Name                     | Description                                      | Type     |
|--------------------------|--------------------------------------------------|----------|
| `org_id`                 | MongoDB Atlas organization ID                   | `string` |
| `project_name`           | Name of the Atlas project                       | `string` |
| `cluster_name`           | Name of the cluster                             | `string` |
| `cluster_type`           | Cluster type (e.g. `REPLICASET`)                | `string` |
| `instance_size`          | Cluster tier (e.g. `M10`, `M20`)                | `string` |
| `region`                 | **Atlas region (e.g. `WESTERN_EUROPE`)**        | `string` |
| `electable_nodes`        | Number of electable nodes                       | `number` |
| `priority`               | Election priority                               | `number` |
| `backup_enabled`         | Whether to enable backups                       | `bool`   |
| `reference_hour_of_day`  | Hour of day for backup reference time (0-23)    | `number` |
| `reference_minute_of_hour` | Minute of hour for backup reference time (0-59)| `number` |
| `restore_window_days`    | Number of days for restore window               | `number` |

## Outputs

- **cluster\_id**: ID of the MongoDB cluster.
- **project\_name**: Name of the MongoDB Atlas project.
- **project\_id**: ID of the MongoDB Atlas project.
- **privatelink\_id**: ID of the Atlas PrivateLink endpoint.
- **atlas\_pe\_service\_id**: Atlas PrivateLink service resource ID.
- **atlas\_privatelink\_endpoint\_id**: ID of the Atlas PrivateLink endpoint.

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

For **multi-region deployments**, use the [multi-region module](../../multi-region/atlas_config_multi_region/readme.md).
