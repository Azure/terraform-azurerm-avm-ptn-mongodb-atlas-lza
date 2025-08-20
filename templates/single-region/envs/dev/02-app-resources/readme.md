# Application Resources - Step 2

## Overview

This Terraform configuration deploys Azure application resources including App Service Plan, Web Apps, and networking components for hosting the test db connection App with VNet integration.

## Prerequisites

⚠️ **IMPORTANT**: You must run the **Step 1** using the pipeline before running this configuration. (You can also run the steps manually, but we recommend using the pipeline as it is simpler)

### Required Previous Steps

1. **Base Infrastructure (Step 1)**: The `01-base-infra` step must be successfully deployed first.

   * This creates the foundational resources including Virtual Network, and other base infrastructure.
   * The remote state from Step 1 is required for this configuration to work properly.

### Required Manual Configuration

Before running this step, you need to:

1. **Review Network Configuration**:

   * Verify the `address_prefixes` in `locals.tf` align with your network design.
   * Ensure the subnet CIDR doesn't conflict with existing subnets.

## How to Deploy

```bash
terraform init
terraform validate
terraform plan -out tfplan
terraform apply tfplan
```

## What This Step Deploys

This configuration creates:

* **Resource Group**: Container for application resources.
* **App Service Plan**: B1 SKU with Windows OS (required for VNet integration).
* **Application Subnet**: Dedicated subnet for App Service VNet integration.
* **Azure Web App**: Azure Web App resource with .NET 8.0 runtime.

## Validate

* Resource Group for application resources is created.
* App Service Plan deployed with correct SKU and OS.
* Application subnet created and delegated for VNet integration.
* Web App deployed and able to reach the Atlas cluster via Private Endpoint.

## Usage

1. **Ensure Prerequisites**: Verify Step 1 is completed and remote state is accessible.
2. **Configure Locals**: Update `locals.tf` with your specific values.
3. **Use the pipeline to deploy this step**.

## Post-Deployment Steps

After the infrastructure is deployed, to utilize the test database connection app, you need to deploy the code.
Follow the detailed guide: [Database Connection Testing Guide](../../../../../docs/wiki/Test_DB_connection_steps.md)

## Default Values in `locals.tf`

### General Settings

* **environment**: Defines the environment type, e.g., `dev`. Default is set to `dev`.
* **location**: Specifies the Azure region where resources will be deployed. Default is set to `eastus2`.

### Application Settings

* **resource\_group\_name**: Generated dynamically using the Azure Naming Module.
* **app\_service\_plan\_name**: Generated dynamically using the Azure Naming Module.
* **app\_service\_plan\_sku**: Default is set to `B1`.
* **app\_web\_app\_name**: Generated dynamically using the Azure Naming Module.
* **virtual\_network\_name**: Retrieved from the Step 1 remote state.
* **subnet\_name**: Generated dynamically using the Azure Naming Module.
* **address\_prefixes**: Default is set to `10.0.2.0/24`.

### Tags

* **tags**: Metadata tags for resources, including `environment` and `location`. Default includes `environment` set to `dev` and `location` set to `eastus2`.
