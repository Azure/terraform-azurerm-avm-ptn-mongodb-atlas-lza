# Prerequisites

## Required Tools and Access

- **[Terraform CLI](https://developer.hashicorp.com/terraform/install)**: Installed and configured.
- **[Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)**: Installed and authenticated.
- **[Azure subscription](https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/create-subscription)**: With required permissions.
- **In case you have an existing MongoDB Organization** you want to use with this templates, you will need to enter the Org Id, a MongoDB Service Account and MongoDB API Key values. For more information on how to generate the API Keys and the Service Account, please [refer the MongoDB docs](https://www.mongodb.com/docs/atlas/configure-api-access-org/), and to get the Org Id and set the API Keys and Org Id as environment variables (see [Setup-environment.md](Setup-environment.md) for instructions).
- **If you don't have an existing MongoDB Organization**, don't worry, you will be able to create it by following the steps in [Deploy with manual steps](./Deploy-with-manual-steps.md) or in [Deploy with pipeline](./Deploy-with-pipeline.md) docs.
