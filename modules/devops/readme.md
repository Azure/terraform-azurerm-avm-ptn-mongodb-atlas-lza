# Devops Module

## Overview

This module creates the Azure resources required to store the Terraform remote state and supports federated identity and role assignments for secure automation.

## Features

- Creates Azure Resource Group
- Provisions Azure Storage Account and Blob Storage Container
- Configures Azure User Assigned Identity for automation
- Sets up Federated Identity Credential and Role Assignment

## Usage

```hcl
module "devops" {
  source = "./modules/devops"

  resource_group_name     = "rg-devops"
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

  permissions = {
    role1 = {
      principal_id = "principal-id"
      role_name    = "Contributor"
    }
  }

  federation = {
    setting1 = "value1"
    setting2 = "value2"
  }
}
```

## Inputs

| Name                    | Description                                           | Type           |
| ----------------------- | ----------------------------------------------------- | -------------- |
| `resource_group_name`   | Name of the resource group                            | `string`       |
| `location`              | Location for the resources                            | `string`       |
| `storage_account_name`  | Name of the storage account                           | `string`       |
| `account_tier`          | Storage account tier (e.g., Standard)                 | `string`       |
| `replication_type`      | Replication type (e.g., LRS)                          | `string`       |
| `container_name`        | Name of the blob container                            | `string`       |
| `container_access_type` | Access type for the container                         | `string`       |
| `tags`                  | Tags to apply to all resources                        | `map(string)`  |
| `audiences`             | List of audiences for federated identity              | `list(string)` |
| `issuer`                | Issuer for federated identity                        | `string`       |
| `permissions`           | Map of role assignments for automation                | `map(object)`  |
| `federation`            | Map of federation settings                            | `map(string)`  |

## Outputs

- **identity\_info**: Provides tenant, subscription, client, resource group, storage account, and container details for automation.
