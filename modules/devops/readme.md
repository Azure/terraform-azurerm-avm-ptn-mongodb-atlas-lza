# Devops Module

## Overview

This module creates the Azure resources required to store the Terraform remote state and supports federated identity and role assignments for secure automation. Also, the resource groups for the step 01 and 02 are created. The creation of the step 02 resource group is optional since the step 02 is used to test the connection with the deployed cluster.

## Features

- Creates Azure Resource Group for devops (step 00), Infrastructure (step 01) and Application (optional, step 02)
- Provisions Azure Storage Account and Blob Storage Container
- Configures Azure User Assigned Identity for automation
- Sets up Federated Identity Credential and Role Assignment. The identity only has permissions to add or modify resources in the Devops, Infrastructure and Application resource groups.

## Usage

```hcl
module "devops" {
  source = "./modules/devops"

  resource_group_name_devops         = "rg-devops"
  resource_group_name_infrastructure = "rg-infra"
  resource_group_name_app            = "rg-application"
  location                = "East US"
  storage_account_name    = "stdevops"
  account_tier            = "Standard"
  replication_type        = "LRS"
  container_name          = "terraform-state"
  container_access_type   = "private"

  tags = {
    Environment = "dev"
    Project     = "devops"
  }

  audiences = ["audience1", "audience2"]
  issuer    = "https://issuer.example.com"

  federation = {
    setting1 = "value1"
    setting2 = "value2"
  }
}
```

## Inputs

| Name                    | Description                                           | Type           |
| ----------------------- | ----------------------------------------------------- | -------------- |
| `resource_group_name_devops`   | Name of the devops (step 00) resource group                            | `string`       |
| `resource_group_name_infrastructure`   | Name of the infrastructure (step 01) resource group                            | `string`       |
| `resource_group_name_app`   | Name of the app (step 02) resource group                            | `string`       |
| `location`              | Location for the resources                            | `string`       |
| `storage_account_name`  | Name of the storage account                           | `string`       |
| `account_tier`          | Storage account tier (e.g., Standard)                 | `string`       |
| `replication_type`      | Replication type (e.g., LRS)                          | `string`       |
| `container_name`        | Name of the blob container                            | `string`       |
| `container_access_type` | Access type for the container                         | `string`       |
| `tags`                  | Tags to apply to all resources                        | `map(string)`  |
| `audiences`             | List of audiences for federated identity              | `list(string)` |
| `issuer`                | Issuer for federated identity                        | `string`       |
| `federation`            | Map of federation settings                            | `map(string)`  |

## Outputs

- **identity\_info**: Provides tenant, subscription, client, resource groups (for DevOps, Infrastructure, and Application), storage account, and container details for automation.

- **resource\_group\_names**: Provides the names of the DevOps, Infrastructure, and Application resource groups.