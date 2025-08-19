# Base Infrastructure - Step 1

## Overview

This Terraform configuration deploys the foundational infrastructure for MongoDB Atlas clusters and associated Azure resources in a single-region setup.

## Prerequisites

⚠️ **IMPORTANT**: You must complete the prerequisites before running this configuration.

### Required Previous Steps

1. **Environment Setup**: Ensure the environment is properly configured.

   - Verify the `locals.tf` file contains accurate values for your setup.

### Required Manual Configuration

Before running this step, you need to:

1. **Review Network Configuration**:

   - Verify the `vnet_address_space` and `private_subnet_prefixes` in `locals.tf` align with your network design.
   - Ensure the subnet CIDR doesn't conflict with existing subnets.

## How to Deploy

```bash
terraform init
terraform validate
terraform plan -out tfplan
terraform apply tfplan
```

## What This Step Deploys

This configuration creates:

- **Resource Group**: Container for infrastructure resources.
- **MongoDB Atlas Cluster**: Single-region cluster with backup enabled by default, but it can be turned off if specified.
- **Virtual Network**: Dedicated VNet for the cluster.
- **Private Subnet**: Subnet for private connectivity.
- **Private Endpoint**: Secure connection to MongoDB Atlas.

## Validate

- Atlas cluster is deployed and healthy in the configured region.
- Private Endpoint is approved/connected.
- DNS resolution from inside the VNet returns a private IP for the Atlas hostname.

## Post-Deployment Steps

After the infrastructure is deployed, you can proceed to Step 2 for application resources.
Follow the detailed guide: [Application Resources Guide](../02-app-resources/readme.md)

## Default Values in `locals.tf`

### General Settings

- **location**: Specifies the Azure region where resources will be deployed. Default is `eastus2`.
- **environment**: Defines the environment type, e.g., `dev`.
- **project_name**: The name of the project, default is `atlas-mongodb`.
- **tags**: Metadata tags for resources, including `environment`, `location`, and `project`.

### MongoDB Atlas Cluster Settings

- **org_id**: Organization ID for MongoDB Atlas.
- **cluster_name**: Name of the MongoDB cluster.
- **cluster_type**: Type of cluster, default is `REPLICASET`.
- **instance_size**: Size of the cluster instance, default is `M10`.
- **backup_enabled**: Enables backup for the cluster, default is `true`.
- **region**: MongoDB Atlas region, default is `US_EAST_2`.
- **electable_nodes**: Number of electable nodes, default is `3`.
- **priority**: Priority of the region, default is `7`.
- **reference_hour_of_day**: Hour of the day for reference, default is `3`.
- **reference_minute_of_hour**: Minute of the hour for reference, default is `45`.
- **restore_window_days**: Number of days for the restore window, default is `4`.

### Networking Settings

- **vnet_address_space**: Address space for the virtual network, default is `10.0.0.0/16`.
- **private_subnet_prefixes**: Prefixes for private subnets, default is `10.0.1.0/24`.

## Backup Configuration

The backup feature is enabled by default (`backup_enabled = true`). It ensures that the MongoDB Atlas cluster has automated backups for data protection and recovery. The following parameters are relevant:

- **reference_hour_of_day**: Specifies the hour of the day when backups are initiated.
- **reference_minute_of_hour**: Specifies the minute of the hour when backups are initiated.
- **restore_window_days**: Defines the number of days for which backups are retained and can be restored.

## Outputs

- **vnet_name**: Name of the virtual network created.
- **resource_group_name**: Name of the Resource Group for infrastructure resources.
- **cluster_id**: ID of the MongoDB Atlas cluster.
- **project_name**: Name of the MongoDB Atlas project.
- **mongodb_project_id**: ID of the MongoDB Atlas project.
- **privatelink_id**: ID of the private link created for MongoDB Atlas.
- **atlas_pe_service_id**: ID of the Atlas private endpoint service.
- **atlas_privatelink_endpoint_id**: ID of the Atlas private link endpoint.
- **infra_resource_group_name**: Name of the infrastructure Resource Group.
