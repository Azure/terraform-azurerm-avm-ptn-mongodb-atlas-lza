# Base Infrastructure - Step 1

This Terraform configuration deploys the foundational infrastructure for MongoDB Atlas clusters and associated Azure resources in a multi-region setup.

## Prerequisites

⚠️ **IMPORTANT**: You must complete the prerequisites before running this configuration.

### Required Previous Steps

1. **Environment Setup**: Ensure the environment is properly configured.
   - Verify the `locals.tf` file contains accurate values for your setup.

### Required Manual Configuration

Before running this step, you need to:

1. **Review Network Configuration**:
   - Verify the `region_definitions` in `locals.tf` align with your network design.
   - Ensure the subnet CIDR doesn't conflict with existing subnets.

## What This Step Deploys

This configuration creates:

- **Resource Group**: Container for infrastructure resources.
- **MongoDB Atlas Cluster**: Multi-region cluster with backup enabled by default, but it can be turned off if specified.
- **Virtual Networks**: Dedicated VNets for each region.
- **Private Subnets**: Subnets for private connectivity in each region.
- **Private Endpoints**: Secure connections to MongoDB Atlas in each region.

## Post-Deployment Steps

After the infrastructure is deployed, you can proceed to Step 2 for application resources. Follow the detailed guide: [Application Resources Guide](../02-app-resources/readme.md)

## Default Values in `locals.tf`

### General Settings

- **location**: Specifies the Azure region where resources will be deployed. Default is `eastus2`.
- **environment**: Defines the environment type, e.g., `dev`.
- **project_name**: The name of the project, default is `atlas-mongodb-multiregion`.
- **tags**: Metadata tags for resources, including `environment` and `project`.

### MongoDB Atlas Cluster Settings

- **org_id**: Organization ID for MongoDB Atlas.
- **cluster_name**: Name of the MongoDB cluster.
- **cluster_type**: Type of cluster, default is `REPLICASET`.
- **instance_size**: Size of the cluster instance, default is `M10`.
- **backup_enabled**: Enables backup for the cluster, default is `true`.
- **reference_hour_of_day**: Hour of the day for reference, default is `3`.
- **reference_minute_of_hour**: Minute of the hour for reference, default is `45`.
- **restore_window_days**: Number of days for the restore window, default is `4`.

### Region Definitions

The `region_definitions` block in `locals.tf` contains configurations for multiple regions. These include:

- **atlas_region**: Specifies the MongoDB Atlas region. Example values include `US_EAST`, `US_EAST_2`, and `US_WEST`.
- **azure_region**: Defines the corresponding Azure region. Example values include `eastus`, `eastus2`, and `westus`.
- **priority**: Sets the priority of the region. Example values include `7`, `6`, and `5`.
- **address_space**: Specifies the address space for the virtual network. Example values include `10.0.0.0/16`, `10.1.0.0/16`, and `10.2.0.0/16`.
- **private_subnet_prefixes**: Defines the prefixes for private subnets. Example values include `10.0.1.0/24`, `10.1.1.0/24`, and `10.2.1.0/24`.
- **node_count**: Indicates the number of nodes in the region. Example values include `2`, `2`, and `1`.

### Networking Settings

- **regions**: Contains Azure-specific configurations for each region, including:
  - **location**: Azure region.
  - **address_space**: Address space for the virtual network.
  - **private_subnet_prefixes**: Prefixes for private subnets.
  - **manual_connection**: Indicates whether manual connection is required.

## Backup Configuration

The backup feature is enabled by default (`backup_enabled = true`). It ensures that the MongoDB Atlas cluster has automated backups for data protection and recovery. The following parameters are relevant:

- **reference_hour_of_day**: Specifies the hour of the day when backups are initiated.
- **reference_minute_of_hour**: Specifies the minute of the hour when backups are initiated.
- **restore_window_days**: Defines the number of days for which backups are retained and can be restored.
