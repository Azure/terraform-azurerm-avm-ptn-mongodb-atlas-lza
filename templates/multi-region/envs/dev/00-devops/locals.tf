locals {
  # Common
  location = "eastus2"
  suffix   = "devops"

  # Storage Account
  account_tier          = "Standard"
  replication_type      = "ZRS"
  container_name        = "tfstate"
  container_access_type = "private"
  subscription_id       = "{your-azure-subscription-id}" # Replace with your actual subscription ID

  # Identity
  github_organization_name = "{your-github-org}"      # Replace with your GitHub org
  github_repository_name   = "{your-repository-name}" # Replace with your GitHub repository name
  environment              = "dev"

  audiences = ["api://AzureADTokenExchange"]
  issuer    = "https://token.actions.githubusercontent.com"

  permissions = {
    contributor_permission = { subscription_id = local.subscription_id, role = "Contributor" },
    uaa_permission         = { subscription_id = local.subscription_id, role = "User Access Administrator" }
  }

  federation = {
    federated_identity_name = "${lower(local.github_organization_name)}-${lower(local.github_repository_name)}-env-${lower(local.environment)}",
    subject                 = "repo:${local.github_organization_name}/${local.github_repository_name}:environment:${local.environment}"
  }
  tags = {
    environment = local.environment
    location    = local.location
  }

  # Atlas

  # Flag to determine whether a MongoDB Atlas organization should be created. Set to true to create, false to skip.
  # If set to true, ensure the organization_name, first_name, last_name, and email_address fields are properly configured.
  should_create_mongo_org = true

  organization_name = "your-org"
  first_name        = "tester"
  last_name         = "tester"
  email_address     = "tester@example.com"
  publisher_id      = "mongodb"
  offer_id          = "mongodb_atlas_azure_native_prod"
  plan_id           = "azure_native"
  term_id           = "gmz7xq9ge3py"
  plan_name         = "Pay as You Go"
  term_unit         = "P1M"
}
