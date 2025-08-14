# DevOps Resources - Step 0

This Terraform configuration deploys Azure DevOps resources including storage accounts, federated identities, and permissions required for managing the environment.

## Prerequisites

⚠️ **IMPORTANT**: You must configure the required values in the `locals.tf` file before running this configuration.

### Required Manual Configuration

Before running this step, you need to:

1. **Review Identity Configuration**:
   - Ensure the `github_organization_name`, `github_repository_name`, `email_address` and `environment` fields are properly configured in `locals.tf`.
   - Verify the `permissions` and `federation` settings align with your organization's requirements.

2. **Update the `terraform.tf` file**:
   - Ensure the `subscription_id` is correctly set in the provider block.

## What This Step Deploys

This configuration creates:

- **Resource Group**: Container for DevOps resources.
- **Storage Account**: Used for storing Terraform state files.
- **Federated Identity**: Enables GitHub Actions to authenticate with Azure.
- **Permissions**: Assigns roles such as Contributor and User Access Administrator.
- **MongoDB Atlas Organization**: Creates a new MongoDB Atlas organization if `should_create_mongo_org` is set to `true`.

## Usage

1. **Ensure Prerequisites**: Verify the `locals.tf` file is properly configured.
2. **Run Terraform**: Use the pipeline or manual commands to deploy this step.

## Default Values in `locals.tf`

### General Settings

- **location**: Specifies the Azure region where resources will be deployed. Default is set to `eastus2`.
- **suffix**: Default is set to `devops`.

### Storage Account Settings

- **account_tier**: Default is set to `Standard`.
- **replication_type**: Default is set to `ZRS`.
- **container_name**: Default is set to `tfstate`.

### Identity Settings

- **github_organization_name**: Set to your Organization name.
- **github_repository_name**: Set to your Repository name.
- **environment**: Default is set to `dev`.
- **permissions**: Includes Contributor and User Access Administrator roles.
- **federation**: Configures federated identity for GitHub Actions.

### Tags

- **tags**: Metadata tags for resources, including `environment` and `location`. Default includes `environment` set to `dev` and `location` set to `eastus2`.

## Organization Settings

### MongoDB Atlas Organization

- **organization_name**: Name of the MongoDB Atlas organization to be created. Default is set to `your-org`.
- **first_name**: First name of the organization owner. Default is set to `tester`.
- **last_name**: Last name of the organization owner. Default is set to `tester`.
- **email_address**: Email address of the organization owner. Default is set to `tester@example.com`.
- **should_create_mongo_org**: Flag to determine whether a MongoDB Atlas organization should be created. Default is set to `true`.

### Marketplace Settings

- **publisher_id**: Publisher ID for the MongoDB Atlas offer. Default is set to `mongodb`.
- **offer_id**: Offer ID for the MongoDB Atlas offer. Default is set to `mongodb_atlas_azure_native_prod`.
- **plan_id**: Plan ID for the MongoDB Atlas offer. Default is set to `azure_native`.
- **term_id**: Term ID for the MongoDB Atlas offer. Default is set to `gmz7xq9ge3py`.
- **plan_name**: Name of the plan for the MongoDB Atlas offer. Default is set to `Pay as You Go`.
- **term_unit**: Unit of the term for the MongoDB Atlas offer. Default is set to `P1M`.
