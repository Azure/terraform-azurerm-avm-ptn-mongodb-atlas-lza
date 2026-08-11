# DevOps Resources - Step 0

## Overview

This step provisions foundational DevOps resources for the single-region MongoDB Atlas landing zone accelerator using Terraform. It sets up Azure storage for state management, federated identity for secure automation, and permissions for GitHub Actions integration. Optionally, it deploys a MongoDB Atlas Organization via Azure Marketplace.

## What This Configuration Creates

* **Resource Groups**: Containers for DevOps, Infrastructure, and Application resources.
* **Storage Account**: Used for storing Terraform state files, with versioning and delete retention enabled, and public access disabled.
* **Federated Identity**: Enables GitHub Actions to authenticate with Azure using OIDC.
* **Permissions**: Assigns roles such as Contributor on all resource groups and Storage Blob Data Contributor on the Storage Account.
* **MongoDB Atlas Organization**: Creates a new MongoDB Atlas organization via Azure Marketplace if `should_create_mongo_org` is set to `true`.

## Prerequisites

* Copy `local.tfvars.template` to `local.tfvars` and fill in all required values for your environment (organization, repository, identity, permissions, etc.).
* Set the `ARM_SUBSCRIPTION_ID` environment variable to your Azure subscription ID before running Terraform commands.

> For more information, see [Setup Environment](../../../../../docs/wiki/Setup-environment.md)

## Deployment Steps

```bash
terraform init
terraform validate
terraform plan -var-file=local.tfvars -out tfplan
terraform apply -var-file=local.tfvars tfplan
```

**Note:** For more information on How to Deploy manually, please follow [Deploy-with-manual-steps](../../../../../docs/wiki/Deploy-with-manual-steps.md).

## Validation Checklist

* DevOps, Infrastructure, and (optionally) Application resource groups are created
* Storage Account is provisioned with:
  * Replication type and account tier
  * Versioning and delete retention enabled
  * Public access to nested items disabled
* Storage Container for Terraform state is created
* User Assigned Identity is created for automation
* Federated Identity Credential for GitHub Actions OIDC is created and linked to the identity
* Role assignments:
  * Contributor on all resource groups
  * Storage Blob Data Contributor on the Storage Account
* All outputs are available after apply
* MongoDB Atlas Organization is created via Azure Marketplace if enabled

## Configuration Reference

See `local.tfvars.template` for all configurable values, including:

* Azure region, resource group names, and tags
* Storage account and container settings
* GitHub organization and repository
* Federated identity and OIDC settings
* MongoDB Atlas organization and user details
* Marketplace offer parameters

## Outputs

* `identity_info`: Output from the DevOps module containing identity and resource details
* `resource_group_names`: Map with the names of the DevOps, Infrastructure, and Application resource groups

## Permissions Granted

* Contributor on DevOps, Infrastructure, and (if configured) Application resource groups
* Storage Blob Data Contributor on the Storage Account

## Notes

* Deleting the Atlas Organization in Azure does not remove it from the Atlas portal
