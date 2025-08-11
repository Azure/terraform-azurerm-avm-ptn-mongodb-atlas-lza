# Devops Module

This module creates the Azure resources required to store the Terraform remote state and supports federated identity and role assignments for secure automation.

## Resources

- Azure Resource Group
- Azure Storage Account
- Azure Blob Storage Container
- Azure User Assigned Identity (for automation)
- Federated Identity Credential
- Role Assignment

## Inputs

| Variable                | Description                                           | Type        | Default     |
|-------------------------|-------------------------------------------------------|-------------|-------------|
| resource_group_name     | Name of the resource group                            | string      | —           |
| location                | Location for the resources                            | string      | —           |
| storage_account_name    | Name of the storage account                           | string      | —           |
| account_tier            | Storage account tier (e.g., Standard)                 | string      | "Standard" |
| replication_type        | Replication type (e.g., LRS)                          | string      | "LRS"      |
| container_name          | Name of the blob container                            | string      | —           |
| container_access_type   | Access type for the container                         | string      | "private"  |
| tags                    | Tags to apply to all resources                        | map(string) | {}          |
| audiences               | List of audiences for federated identity              | list(string)| —           |
| issuer                  | Issuer for federated identity                        | string      | —           |
| permissions             | Map of role assignments for automation                | map(object) | —           |
| federation              | Map of federation settings                            | map(string) | —           |

## Outputs

| Output               | Description                             |
|----------------------|-----------------------------------------|
| identity_info        | Object with identity, tenant, and storage info |
