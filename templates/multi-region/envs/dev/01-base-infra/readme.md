# Base Infrastructure - Step 1

## Overview

This Terraform configuration deploys the foundational infrastructure for MongoDB Atlas clusters and associated Azure resources in a multi-region setup.

## Prerequisites

⚠️ **IMPORTANT**: You must complete the prerequisites before running this configuration.

### Required Previous Steps

1. **Environment Setup**: Ensure the environment is properly configured.

   * Verify the `locals.tf` file contains accurate values for your setup.

### Required Manual Configuration

Before running this step, you need to:

1. **Review Network Configuration**:

   * Verify the `region_definitions` in `locals.tf` align with your network design.
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

* **Resource Group**: Container for infrastructure resources.
* **MongoDB Atlas Cluster**: Multi-region cluster with backup enabled by default, but it can be turned off if specified.
* **Virtual Networks**: Dedicated VNets for each region.
* **Private Subnets**: Subnets for private connectivity in each region.
* **Private Endpoints**: Secure connections to MongoDB Atlas in each region.

## Validate

* MongoDB Atlas cluster is deployed and healthy across all configured regions.
* Private Endpoints are approved and in a connected state.
* DNS resolution from within the VNet returns a private IP for the Atlas FQDN.

## Next Steps

After the infrastructure is deployed, you can proceed to Step 2 for application resources.
Follow the detailed guide: [Application Resources Guide](../02-app-resources/readme.md)

## Default Values in `locals.tf`

### General Settings

* **location**: Specifies the Azure region where resources will be deployed. Default is `eastus2`.
* **environment**: Defines the environment type, e.g., `dev`.
* **project\_name**: The name of the project, default is `atlas-mongodb-multiregion`.
* **tags**: Metadata tags for resources, including `environment` and `project`.

### MongoDB Atlas Cluster Settings

* **org\_id**: Organization ID for MongoDB Atlas.
* **cluster\_name**: Name of the MongoDB cluster.
* **cluster\_type**: Type of cluster, default is `REPLICASET`.
* **instance\_size**: Size of the cluster instance, default is `M10`.
* **backup\_enabled**: Enables backup for the cluster, default is `true`.
* **reference\_hour\_of\_day**: Hour of the day for reference, default is `3`.
* **reference\_minute\_of\_hour**: Minute of the hour for reference, default is `45`.
* **restore\_window\_days**: Number of days for the restore window, default is `4`.

### Region Definitions

The `region_definitions` block in `locals.tf` contains configurations for multiple regions. These include:

* **atlas\_region**: Specifies the MongoDB Atlas region. Example values include `US_EAST`, `US_EAST_2`, and `US_WEST`.
* **azure\_region**: Defines the corresponding Azure region. Example values include `eastus`, `eastus2`, and `westus`.
* **priority**: Sets the priority of the region. Example values include `7`, `6`, and `5`.
* **address\_space**: Specifies the address space for the virtual network. Example values include `10.0.0.0/16`, `10.1.0.0/16`, and `10.2.0.0/16`.
* **private\_subnet\_prefixes**: Defines the prefixes for private subnets. Example values include `10.0.1.0/24`, `10.1.1.0/24`, and `10.2.1.0/24`.
* **node\_count**: Indicates the number of nodes in the region. Example values include `2`, `2`, and `1`.

### Networking Settings

* **regions**: Contains Azure-specific configurations for each region, including:

  * **location**: Azure region.
  * **address\_space**: Address space for the virtual network.
  * **private\_subnet\_prefixes**: Prefixes for private subnets.
  * **manual\_connection**: Indicates whether manual connection is required.

## Backup Configuration

The backup feature is enabled by default (`backup_enabled = true`). It ensures that the MongoDB Atlas cluster has automated backups for data protection and recovery. The following parameters are relevant:

* **reference\_hour\_of\_day**: Specifies the hour of the day when backups are initiated.
* **reference\_minute\_of\_hour**: Specifies the minute of the hour when backups are initiated.
* **restore\_window\_days**: Defines the number of days for which backups are retained and can be restored.

### Outputs

* **resource\_group\_name**: Name of the Resource Group for infrastructure resources.
* **cluster\_id**: ID of the MongoDB Atlas cluster.
* **project\_name**: Name of the MongoDB Atlas project.
* **mongodb\_project\_id**: ID of the MongoDB Atlas project.
* **privatelink\_ids**: IDs of the private links created for MongoDB Atlas.
* **atlas\_pe\_service\_ids**: IDs of the Atlas private endpoint services.
* **atlas\_privatelink\_endpoint\_ids**: IDs of the Atlas private link endpoints.
* **infra\_resource\_group\_name**: Name of the infrastructure Resource Group.
* **vnet\_names**: Names of the virtual networks created.
* **regions\_values**: Values of the regions configured.
