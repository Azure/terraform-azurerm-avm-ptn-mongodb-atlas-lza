# Base Infrastructure - Step 1

## Overview

This Terraform configuration deploys the foundational infrastructure for MongoDB Atlas clusters and associated Azure resources in a single-region setup.

## Prerequisites

⚠️ **IMPORTANT**: You must complete the prerequisites before running this configuration.

### Required Previous Steps

1. **Environment Setup**: Ensure the environment is properly configured.

   - Verify the `locals.tf` file contains accurate values for your setup.

2. **Deploy the Terraform state from step 00**:
   - Follow the instructions on the step 00 `terraform.tf` file to migrate the Terraform state to the Azure backend

### Required Manual Configuration

Before running this step, you need to:

**Review Network Configuration**:

   - Verify the `vnet_address_space`, `private_subnet_prefixes`, `observability_function_app_subnet_prefixes`, and `observability_private_endpoint_subnet_prefixes` in `locals.tf` align with your network design.
   - Ensure the subnet CIDR doesn't conflict with existing subnets.

> **Note:** For information on How to Deploy manually, please follow the steps in [Deploy with manual steps](../../../../../docs/wiki/Deploy-with-manual-steps.md) guide.

## What This Step Deploys

This configuration creates:

- **MongoDB Atlas Cluster**: Single-region cluster with backup enabled by default, but it can be turned off if specified.
- **Virtual Network**: Dedicated VNet for the cluster.
- **Private Subnet**: Subnet for private connectivity.
- **Private Endpoint**: Secure connection to MongoDB Atlas.
- **Observability Resources**: Provisions all infrastructure needed for centralized monitoring of MongoDB Atlas and Azure resources, including Application Insights, Storage Account, Service Plan, Function App, Private DNS Zones, and Private Endpoints. After resource creation, you must deploy the metrics collection function code to the Function App. This function will securely connect to the MongoDB Atlas API, collect metrics, and send them to Application Insights for monitoring and analysis.

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
- **tags**: Metadata tags for resources, including `environment`, `location`, and `project`.

### MongoDB Atlas Cluster Settings

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

- **vnet_address_space**: Address space for the virtual network, default is `10.0.0.0/26`.
- **private_subnet_prefixes**: Prefixes for private subnets, default is `10.0.0.0/29`.
- **observability_function_app_subnet_prefixes**: Prefixes fot Observability Function App, default is `10.0.0.8/29`.
- **observability_private_endpoint_subnet_prefixes**: Prefixes for Observability private endpoint subnet, default is `10.0.0.16/28`.
> The default addresses set here are placeholders for the template. To run this template, you must provide your own IP addresses.

## Backup Configuration

The backup feature is enabled by default (`backup_enabled = true`). It ensures that the MongoDB Atlas cluster has automated backups for data protection and recovery. The following parameters are relevant:

- **reference_hour_of_day**: Specifies the hour of the day when backups are initiated.
- **reference_minute_of_hour**: Specifies the minute of the hour when backups are initiated.
- **restore_window_days**: Defines the number of days for which backups are retained and can be restored.

## Outputs

- **vnet_name**: Name of the virtual network created.
- **cluster_id**: ID of the MongoDB Atlas cluster.
- **project_name**: Name of the MongoDB Atlas project.
- **mongodb_project_id**: ID of the MongoDB Atlas project.
- **privatelink_id**: ID of the private link created for MongoDB Atlas.
- **atlas_pe_service_id**: ID of the Atlas private endpoint service.
- **atlas_privatelink_endpoint_id**: ID of the Atlas private link endpoint.
- **function_app_default_hostname**: Function App default hostname.
