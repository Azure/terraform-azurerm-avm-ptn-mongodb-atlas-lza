# MongoDB Atlas Organization Deployment on Azure with Terraform

> ⚠️ **Warning:**
> If you delete the MongoDB Atlas Organization resource in Azure, you still need to delete it in the Atlas portal.

This Terraform module deploys a MongoDB Atlas Organization as a managed Azure resource using the [azapi](https://registry.terraform.io/providers/Azure/azapi/latest/docs) provider.

## Overview

- **Provider:**
  - `azapi` for native ARM resource deployment and management

## Resources

- `azapi_resource.mongodb_atlas_org` — Deploys a MongoDB Atlas Organization via Azure Resource Manager (ARM) APIs.

## Inputs

| Variable                | Description                                           | Type    | Required/Default |
|-------------------------|-------------------------------------------------------|---------|------------------|
| subscription_id         | Azure subscription ID                                 | string  | required         |
| location                | Azure region (required by AzAPI)                      | string  | required         |
| resource_group_id       | Resource group ID used as the parent for the resource | string  | required         |
| publisher_id            | Marketplace publisher ID (e.g., mongodbinc)           | string  | required         |
| offer_id                | Offer ID for MongoDB Atlas                            | string  | required         |
| plan_id                 | Plan ID for MongoDB Atlas                             | string  | required         |
| plan_name               | Plan name for display                                 | string  | required         |
| term_unit               | Marketplace billing term unit (e.g., P1M)             | string  | required         |
| term_id                 | Marketplace agreement term ID                         | string  | required         |
| first_name              | First name of MongoDB Atlas admin user                | string  | required if should_create_mongo_org = true |
| last_name               | Last name of MongoDB Atlas admin user                 | string  | required if should_create_mongo_org = true |
| email_address           | Email of the MongoDB Atlas user                       | string  | required if should_create_mongo_org = true |
| organization_name       | Name of the MongoDB Atlas organization                | string  | required         |
| should_create_mongo_org | Whether to create a new MongoDB Atlas organization    | bool    | true (default)  |

## Notes

- The resource group must already exist. If you want Terraform to create it, add an `azurerm_resource_group` resource and use its `id` for `resource_group_id`.
- The values for marketplace parameters (`offer_id`, `plan_id`, etc.) must match the actual MongoDB Atlas Azure offer details.
- The deployment uses the [azapi provider v2+ syntax](https://registry.terraform.io/providers/Azure/azapi/latest/docs/guides/2.0-upgrade-guide#dynamic-properties-support).