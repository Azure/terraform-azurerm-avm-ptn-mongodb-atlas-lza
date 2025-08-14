# Application Resources - Step 2

This Terraform configuration deploys Azure application resources including App Service Plan, Web Apps, and networking components for hosting the test db connection App with VNet integration. Since it is Multi-Region, this step is able to deploy the Azure resources in the different regions you specify to test the connection to the Database in the Clusters deployed in the step #1.

## Prerequisites

⚠️ **IMPORTANT**: You must run the **Step 1** using the pipeline before running this configuration. (You can also run the steps manually, but we recommend using the pipeline as it is simpler)

### Required Previous Steps

1. **Base Infrastructure (Step 1)**: The `01-base-infra` step must be successfully deployed first
   - This creates the foundational resources including Virtual Networks in each specified region, and other base infrastructure
   - The remote state from Step 1 is required for this configuration to work properly

### Required Manual Configuration

Before running this step, you need to:

1. **Review Network Configuration**:
   - In the `locals.tf` file we created a custom logic that increments the third octet of the private subnet prefix for each region defined in the Step 1 outputs. You can adjust the logic as needed. You can even hardcode the list of addresses having each region as keys. For example:

   ```tf
    incremented_addresses = {
        eastus = ["10.0.2.0/24"],
        westus = ["10.0.3.0/24"]
    }
   ```

   - Verify the `incremented_addresses` in `locals.tf` align with your network design
   - Ensure the subnet CIDR doesn't conflict with existing subnets

2. **Update the data.tf file**
   - `key` is set as `01-base-infra-multi-region.tfstate` by default, since if you deploy the steps with the pipeline, it will have that value. However, you can modify that value if needed.

   ```tf
    config = {
        resource_group_name  = "tfstate-rg"
        storage_account_name = "tfstatestorageaccount"
        container_name       = "tfstate"
        key                  = "01-base-infra-multi-region.tfstate" # If you have a different key, update it accordingly
        use_oidc             = true
    }
    ```

## What This Step Deploys

This configuration creates the following for each specified region:

- **Resource Group**: Container for application resources
- **App Service Plan**: B1 SKU with Windows OS (required for VNet integration)
- **Application Subnet**: Dedicated subnet for App Service VNet integration  
- **Azure Web App**: Azure Web App resource with .NET 8.0 runtime

## Usage

1. **Ensure Prerequisites**: Verify Step 1 is completed and remote state is accessible
2. **Configure Locals**: Update `locals.tf` with your specific values
3. **Use the pipeline to deploy this step**

## Post-Deployment Steps

After the infrastructure is deployed, to utilize the test database connection app, you need to deploy the code. Follow the detailed guide: [Database Connection Testing Guide](../../docs/test_db_connection_steps.md)

## Default Values in `locals.tf`

### General Settings

- **environment**: Defines the environment type, e.g., `dev`. Default is set to `dev`.

### Application Settings

- **incremented_addresses**: Contains the logic to increment the third octet of the private subnet prefix for each region defined in the Step 1 outputs. Default logic ensures unique subnet CIDRs for each region.
- **app_information_by_region**: Contains application-specific configurations for each region, including:
  - **resource_group_name**: Generated dynamically with Azure Naming Module.
  - **location**: Region name. Default is derived from the Step 1 outputs.
  - **app_service_plan_name**: Generated dynamically with Azure Naming Module.
  - **app_service_plan_sku**: Default is set to `B1`.
  - **app_web_app_name**: Generated dynamically with Azure Naming Module.
  - **virtual_network_name**: Retrieved from the Step 1 remote state.
  - **subnet_name**: Generated dynamically with Azure Naming Module.
  - **address_prefixes**: Default logic increments the third octet of the private subnet prefix.

### Tags

- **tags**: Metadata tags for resources, including `environment`. Default includes `environment` set to `dev`.
