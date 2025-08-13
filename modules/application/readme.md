# Application Module

This module creates Azure resources including App Service Plan, Web App, and associated networking components for hosting the test connection db app located in [Test DB Connection Deployment Steps](../../test-db-connection/test_db_connection_steps.md) with VNet integration.

## Features

- Creates Azure Resource Group for application resources
- Provisions App Service Plan with Windows OS support
- Creates application subnet within specified Virtual Network
- Deploys Windows Web Apps with VNet integration
- Supports .NET 8.0 runtime stack

## Usage

```hcl
module "application" {
  source = "./modules/application"

  resource_group_name    = "rg-myapp-dev"
  location              = "East US"
  app_service_plan_name = "asp-myapp-dev"
  app_service_plan_sku  = "B1"

  virtual_network_name  = "vnet-myapp-dev"
  subnet_name          = "snet-app-dev"
  address_prefixes     = ["10.0.1.0/24"]

  app_web_app_name         = "webapp-myapp-dev"

  tags = {
    Environment = "dev"
    Project     = "myapp"
  }
}
```

## Inputs

| Name                    | Description                                                  | Type           | Required |
| ----------------------- | ------------------------------------------------------------ | -------------- | -------- |
| `resource_group_name`   | Name of the resource group to create                         | `string`       | Yes      |
| `location`              | Azure region where resources will be deployed                | `string`       | Yes      |
| `app_service_plan_name` | Name of the App Service Plan                                 | `string`       | Yes      |
| `app_service_plan_sku`  | SKU for App Service Plan (B1 or higher for VNet integration) | `string`       | Yes      |
| `virtual_network_name`  | Name of the existing Virtual Network                         | `string`       | Yes      |
| `subnet_name`           | Name of the subnet to create for App Service integration     | `string`       | Yes      |
| `address_prefixes`      | Address prefixes for the application subnet                  | `list(string)` | Yes      |
| `app_web_app_name`      | Name of the main web application                             | `string`       | Yes      |
| `tags`                  | Tags to apply to all resources                               | `map(string)`  | No       |

## Notes

- Ensure the subnet is defined with a valid address prefix. Adjust the address prefix as per your network design. Also, **the VNet name has to be the same VNet connected to the Atlas Private Endpoint.**

- App service plan's SKU has to be greater than or equal to B1 to support VNet integration.

- For more information in how to deploy the test db connection App, please refer to this [document](../../docs/test_db_connection_steps.md).
