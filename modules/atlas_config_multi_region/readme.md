# MongoDB Atlas Multi-Region Configuration Module

This module configures a MongoDB Atlas project, advanced cluster, and Azure PrivateLink endpoint for **multi-region deployments** using the official Terraform `mongodbatlas` provider.

> **Use this module if you require a MongoDB Atlas cluster that spans multiple cloud regions for high availability and disaster recovery.**

## Features

- Creates a MongoDB Atlas project (if not existing)
- Provisions an advanced (dedicated) cluster (M10+) **across multiple regions**
- Supports flexible cluster sizing, region, and replication setup
- Provisions an Azure PrivateLink endpoint for secure connectivity
- Configures automated backup schedule with customizable policies

---

## Inputs

| Name            | Description                                              | Type                                                                 | Required/Default |
|-----------------|----------------------------------------------------------|----------------------------------------------------------------------|------------------|
| `org_id`        | MongoDB Atlas organization ID                            | `string`                                                             | required         |
| `project_name`  | MongoDB Atlas project name                               | `string`                                                             | required         |
| `cluster_name`  | Name of the MongoDB cluster                              | `string`                                                             | required         |
| `cluster_type`  | Type of the cluster (e.g., REPLICASET)                   | `string`                                                             | required         |
| `instance_size` | Size of the cluster instance (e.g., M10)                 | `string`                                                             | required         |
| `backup_enabled`| Whether backup is enabled for the cluster                | `bool`                                                               | required         |
| `region_configs`| **Map of region configurations for multi-region cluster**| `map(object({ atlas_region = string, azure_region = string, priority = number, electable_specs = object({ instance_size = string, node_count    = number }) }))` | required         |

> **Note:** The `region_configs` input allows you to specify multiple regions and their priorities for the cluster. This is the key difference from the single-region module.

> **Regions:** Only the first ones listed on the [Availability Zones and Supported Regions page](https://www.mongodb.com/docs/atlas/reference/microsoft-azure/#availability-zones-and-supported-regions) are supported for deployment. Please ensure your selected region is available and approved in your Azure environment.
> **Disclaimer:**
>
> - The `instance_size` must be the same for all regions specified in `region_configs`. For more details, refer to the [official documentation](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/advanced_cluster#electable_specs-1).
> - The `node_count` must be either 3, 5, or 7, and no other values are allowed. For more details, refer to the [official documentation](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/cluster.html?utm_source=chatgpt.com#electable_nodes-1).

## Outputs

| Name                        | Description                                      |
|-----------------------------|--------------------------------------------------|
| `cluster_id`                | ID of the MongoDB cluster                        |
| `project_id`                | ID of the MongoDB Atlas project                  |
| `project_name`              | Name of the MongoDB Atlas project                |
| `privatelink_ids`           | IDs of the Atlas PrivateLink endpoints (per region) |
| `atlas_pe_service_ids`      | Atlas PrivateLink service resource IDs (per region) |
| `atlas_privatelink_endpoint_ids` | IDs of the Atlas PrivateLink endpoints (per region) |

## Example Usage

```hcl
module "mongodbatlas_config" {
  source         = "../../modules/atlas_config_multi_region"
  org_id         = var.org_id
  project_name   = "my-project"
  cluster_name   = "cluster1"
  cluster_type   = "REPLICASET"
  instance_size  = "M10"
  backup_enabled = true
  region_configs = {
    eastus = {
      atlas_region = "US_EAST"
      azure_region = "eastus"
      priority     = 7
      electable_specs = {
        instance_size = "M10"
        node_count    = 2
      }
    },
    eastus2 = {
      atlas_region = "US_EAST_2"
      azure_region = "eastus2"
      priority     = 6
      electable_specs = {
        instance_size = "M10"
        node_count    = 2
      }
    },
    westus = {
      atlas_region = "US_WEST"
      azure_region = "westus"
      priority     = 5
      electable_specs = {
        instance_size = "M10"
        node_count    = 1
      }
    }
  }
}
```

---

## Backup Configuration

MongoDB Atlas provides automated backups to ensure data durability and disaster recovery. Backups are stored in the cluster's primary region by default, even for multi-region clusters. This module allows you to configure backup settings for your cluster, including the reference time for backups and the restore window duration.

### Key Features of Backup

- **Automated Backups:** Backups are automatically created based on the specified reference time.
- **Restore Window:** You can define the number of days for the restore window, allowing you to recover data within this period.
- **Snapshot Distribution:** Backups can be copied to other regions for added durability or disaster recovery. This requires explicit configuration using the `copy_settings` parameter in the `mongodbatlas_cloud_backup_schedule` resource.

### Backup Configuration Inputs

| Name                     | Description                                      | Type   | Default |
|--------------------------|--------------------------------------------------|--------|---------|
| `reference_hour_of_day`  | Hour of the day for backup reference time (0-23) | `number` | `3`     |
| `reference_minute_of_hour` | Minute of the hour for backup reference time (0-59) | `number` | `45`    |
| `restore_window_days`    | Number of days for the restore window            | `number` | `4`     |

### Backup Example Usage

```tf
resource "mongodbatlas_cloud_backup_schedule" "backup" {
  project_id   = mongodbatlas_project.project.id
  cluster_name = mongodbatlas_advanced_cluster.this.name

  reference_hour_of_day    = var.reference_hour_of_day
  reference_minute_of_hour = var.reference_minute_of_hour
  restore_window_days      = var.restore_window_days
}
```

> **Note:** For snapshot distribution across regions, refer to the [official documentation](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/cloud_backup_schedule#example-usage---create-a-cluster-with-cloud-backup-enabled-with-snapshot-distribution).

---

For **single-region deployments**, use the [single-region module](../../single-region/atlas_config_single_region/readme.md).
