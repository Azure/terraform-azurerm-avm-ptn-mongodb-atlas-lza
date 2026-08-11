# MongoDB Atlas Organization Deployment on Azure with Terraform

## Overview

> ⚠️ **Warning:**
> If you delete the MongoDB Atlas Organization resource in Azure, you still need to delete it in the Atlas portal.

This Terraform module deploys a MongoDB Atlas Organization as a managed Azure resource using the [azapi](https://registry.terraform.io/providers/Azure/azapi/latest/docs) provider.

## Features

- Deploys a MongoDB Atlas Organization via Azure Resource Manager (ARM) APIs.
- Uses the `azapi` provider for native ARM resource deployment and management.

## Usage

```hcl
module "mongodb_marketplace" {
  source = "./modules/mongodb_marketplace"

  subscription_id         = "subscription-id"
  location                = "East US"
  resource_group_id       = "resource-group-id"
  publisher_id            = "mongodbinc"
  offer_id                = "offer-id"
  plan_id                 = "plan-id"
  plan_name               = "plan-name"
  term_unit               = "P1M"
  term_id                 = "term-id"
  first_name              = "John"
  last_name               = "Doe"
  email_address           = "john.doe@example.com"
  organization_name       = "My Organization"
  should_create_mongo_org = true
}
```

## Inputs

| Name                    | Description                                           | Type           |
| ----------------------- | ----------------------------------------------------- | -------------- |
| `subscription_id`       | Azure subscription ID                                 | `string`       |
| `location`              | Azure region (required by AzAPI)                      | `string`       |
| `resource_group_id`     | Resource group ID used as the parent for the resource | `string`       |
| `publisher_id`          | Marketplace publisher ID (e.g., mongodbinc)           | `string`       |
| `offer_id`              | Offer ID for MongoDB Atlas                            | `string`       |
| `plan_id`               | Plan ID for MongoDB Atlas                             | `string`       |
| `plan_name`             | Plan name for display                                 | `string`       |
| `term_unit`             | Marketplace billing term unit (e.g., P1M)             | `string`       |
| `term_id`               | Marketplace agreement term ID                         | `string`       |
| `first_name`            | First name of MongoDB Atlas admin user                | `string`       |
| `last_name`             | Last name of MongoDB Atlas admin user                 | `string`       |
| `email_address`         | Email of the MongoDB Atlas user                       | `string`       |
| `organization_name`     | Name of the MongoDB Atlas organization                | `string`       |
| `should_create_mongo_org` | Whether to create a new MongoDB Atlas organization  | `bool`         |

## Outputs

- **organization\_id**: ID of the MongoDB Atlas Organization.

## Notes

- The resource group must already exist. If you want Terraform to create it, add an `azurerm_resource_group` resource and use its `id` for `resource_group_id`.
- The values for marketplace parameters (`offer_id`, `plan_id`, etc.) must match the actual MongoDB Atlas Azure offer details.
- The deployment uses the [azapi provider v2+ syntax](https://registry.terraform.io/providers/Azure/azapi/latest/docs/guides/2.0-upgrade-guide#dynamic-properties-support).
