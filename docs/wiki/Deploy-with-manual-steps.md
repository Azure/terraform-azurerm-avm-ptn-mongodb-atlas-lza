# Manual Steps for Applying Terraform Resources

> **Note:** The following instructions cover both single-region and multi-region deployments. Be sure to use the correct folder paths for your scenario:
>
> - **Single-region:** `templates/single-region/envs/dev/`
> - **Multi-region:** `templates/multi-region/envs/dev/`

This guide provides a clear, step-by-step process for deploying infrastructure and applications manually using Terraform. Follow the steps in order; each depends on the outputs of the previous step.

> **Note:** Step 00 (DevOps) is always mandatory and must be run manually before continuing with any other part of the deployment, regardless of whether you use manual steps or the pipeline for later steps.

---

## Table of Contents

- [Overview: Deployment Sequence](#overview-deployment-sequence)
- [Step 00: DevOps (Mandatory, Always Manual) and Marketplace](#step-00-devops-mandatory-always-manual-and-marketplace)
- [Step 01: Base Infrastructure](#step-01-base-infrastructure)
- [Step 02: Application](#step-02-application)
- [Quick Checklist for Local Manual Runs](#quick-checklist-for-local-manual-runs)

## Overview: Deployment Sequence

**You must perform the steps in this order. For each step, use the appropriate path for your deployment type:**

| Step | Single-Region Path | Multi-Region Path |
|------|-------------------|------------------|
| 00: DevOps | `templates/single-region/envs/dev/00-devops/` | `templates/multi-region/envs/dev/00-devops/` |
| 01: Base Infrastructure | `templates/single-region/envs/dev/01-base-infra/` | `templates/multi-region/envs/dev/01-base-infra/` |
| 02: Application | `templates/single-region/envs/dev/02-app-resources/` | `templates/multi-region/envs/dev/02-app-resources/` |

1. **Step 00: DevOps (Mandatory, Always Manual)**
   - Sets up the Terraform backend and core identity.
   - Optionally, creates the MongoDB Atlas Organization (via Marketplace).
   - Outputs are required for all subsequent steps.
   - **Navigate to the correct path for your deployment type before running this step.**

2. **Step 01: Base Infrastructure**
   - Provisions networking, NAT, subnets, and configures MongoDB Atlas (project, cluster, PrivateLink).
   - For multi-region deployments: Also provisions VNet peering connections between regions.
   - Can be run manually or via the pipeline.
   - **Navigate to the correct path for your deployment type before running this step.**

3. **Step 02: Application**
   - Deploys application infrastructure: App Service Plan, subnet, and an empty Azure Web App with VNet integration.
   - Does not deploy a test app or application code. For instructions on deploying and testing the test database connection app, see [Test_DB_connection_steps.md](Test_DB_connection_steps.md).
   - Can be run manually or via the pipeline.
   - **Navigate to the correct path for your deployment type before running this step.**

---

## Step 00: DevOps (Mandatory, Always Manual) and Marketplace

### MongoDB Atlas Organization Setup (Optional in Step 00)

You can choose whether to have Terraform create a MongoDB Atlas Organization for you via the Azure Marketplace, or use an existing Atlas Organization.

#### Option 1: Create Atlas Org via Terraform (Marketplace Module)

- In `envs/dev/00-devops/locals.tf`, set:
  - `should_create_mongo_org = true`
  - Fill in `organization_name`, `first_name`, `last_name`, and `email_address` as needed.
    - **Important:** The `email_address` must be an address you have access to. Atlas will send verification codes to this email for account setup, and this address will have full access to the new organization.
- When you run this step, Terraform will attempt to create a new Atlas Organization for you via the Marketplace.

#### Option 2: Use an Existing Atlas Org

- In `envs/dev/00-devops/locals.tf`, set:
  - `should_create_mongo_org = false`
- Ensure you have Atlas API keys for your existing organization.

---

### Running Step 00

**Preparation:**

- Update `locals.tf` in `envs/dev/00-devops/` (inside the respective single-region or multi-region folder) to set the correct values for `subscription_id`, `github_organization_name`, `github_repository_name`, and the rest of variables before running this step. This ensures resources are created in the intended Azure subscription.

Navigate to `envs/dev/00-devops/` and run:

```bash
terraform init
terraform plan
# Review the plan output carefully
terraform apply -auto-approve
```

**Important Notes:**

- **Run only once:** If you need to re-run this step with different parameters, you must manually destroy the previous resources first.
- **Backend Setup:** This step sets up the remote Terraform state and core identity for all remaining steps.
- **Copy outputs:** After applying, copy the outputs (`container_name`, `storage_account_name`, `resource_group_name`) for use in later steps.

Example outputs to copy:

```hcl
container_name         = "<from step 00 output>"
storage_account_name   = "<from step 00 output>"
resource_group_name    = "<from step 00 output>"
```

---

**MongoDB Atlas API Key Setup:**

- If you created a new Atlas Organization in this step, go to the Atlas UI, generate API keys ([see MongoDB docs](https://www.mongodb.com/docs/atlas/configure-api-access-org/)), and set them as environment variables (see [Setup-environment.md](Setup-environment.md) for instructions):
  - `MONGODB_ATLAS_PUBLIC_API_KEY`
  - `MONGODB_ATLAS_PRIVATE_API_KEY`
- If you are using an existing Atlas Organization, ensure you have API keys and set them as environment variables now.

> **MongoDB Atlas API keys must always be set as environment variables before running step 01 where Atlas configuration is performed.**

## Step 01: Base Infrastructure

**Preparation:**

- Review and fill in the required values in `locals.tf` in `envs/dev/01-base-infra/` (such as `org_id`, `cluster_name`, and other configuration values) before running this step.
- Go to `terraform.tf` in `envs/dev/01-base-infra/` and:
  - Replace:

  ```hcl
  backend "azurerm" {
    use_azuread_auth = true
  }
  ```

  with the following, using the outputs from Step 00:

  ```hcl
  backend "azurerm" {
    resource_group_name  = "<from step 00 output>"
    storage_account_name = "<from step 00 output>"
    container_name       = "<from step 00 output>"
    key                  = "01-base-infra.tfstate"
  }
  ```

- Set required environment variables and ensure MongoDB Atlas API keys are present in your environment.

Navigate to `envs/dev/01-base-infra/` and run:

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

This provisions network resources and configures MongoDB Atlas (project, cluster, PrivateLink). For multi-region deployments, it also creates VNet peering connections between regions.

---

## Step 02: Application

**Preparation:**

- Go to `terraform.tf` in `envs/dev/02-app-resources/` and replace:

  ```hcl
  backend "azurerm" {
    use_azuread_auth = true
  }
  ```

  with the following, using the outputs from Step 00:

  ```hcl
  backend "azurerm" {
    resource_group_name  = "<from step 00 output>"
    storage_account_name = "<from step 00 output>"
    container_name       = "<from step 00 output>"
    key                  = "02-application.tfstate"
  }
  ```

- Ensure `data.tf` in `envs/dev/02-app-resources/` references the correct resource group, storage account, container and key values from Step 01.

### Data Configuration

In your `data.tf` update the `terraform_remote_state` resource and set the corresponding values:

```hcl
data "terraform_remote_state" "common" {
  backend = "azurerm"
  config = {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstatestorageaccount"
    container_name       = "tfstate"
    key                  = "01-base-infra.tfstate"
    use_oidc             = true
  }
}
```

> **Note:** If you have a different key for the setup, update it accordingly

Navigate to `envs/dev/02-app-resources/` and run:

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

This deploys application resources (App Service, test app, VNet integration).

**Note:** To deploy the Test Database App into the Web App resource deployed in this step, please follow [Test_DB_connection_steps](Test_DB_connection_steps.md).

---

## Quick Checklist for Local Manual Runs

1. **Step 00: DevOps (Manual)**
   - Decide whether to create a new Atlas Organization or use an existing one (see options above).
   - Navigate to the appropriate path:
     - Single-region: `templates/single-region/envs/dev/00-devops/`
     - Multi-region: `templates/multi-region/envs/dev/00-devops/`
   - Review and update `locals.tf` as needed.
   - Run Terraform commands.
   - Copy outputs for backend configuration.

2. **Step 01: Base Infrastructure**
   - Navigate to the appropriate path:
     - Single-region: `templates/single-region/envs/dev/01-base-infra/`
     - Multi-region: `templates/multi-region/envs/dev/01-base-infra/`
   - Update `terraform.tf` with backend values from Step 00.
   - Set environment variables and API keys.
   - Run Terraform commands.

3. **Step 02: Application**
   - Navigate to the appropriate path:
     - Single-region: `templates/single-region/envs/dev/02-app-resources/`
     - Multi-region: `templates/multi-region/envs/dev/02-app-resources/`
   - Update `terraform.tf` with backend values from Step 00.
   - Ensure `data.tf` references Step 01 outputs.
   - Run Terraform commands.

---

**Tips:**

- Each step includes a pre-filled `locals.tf` file with default values for common deployments. Review and update as needed.
- Always ensure environment variables and API keys are set before running steps that require them.
- Do not rerun Step 00 unless you intend to destroy and recreate all resources.
