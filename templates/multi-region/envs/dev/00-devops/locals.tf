locals {
  # Common
  location = "eastus2"

  # Storage Account
  account_tier     = "Standard"
  replication_type = "ZRS"
  container_name   = "tfstate"
  subscription_id  = data.azurerm_client_config.current.subscription_id

  # Identity
  github_organization_name = var.github_organization_name
  github_repository_name   = var.github_repository_name
  environment              = "dev"

  audiences = ["api://AzureADTokenExchange"]
  issuer    = "https://token.actions.githubusercontent.com"

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

  organization_name = var.mongodb_atlas_organization_name
  first_name        = var.first_name
  last_name         = var.last_name
  email_address     = var.email_address
  publisher_id      = "mongodb"
  offer_id          = "mongodb_atlas_azure_native_prod"
  plan_id           = "azure_native"
  term_id           = "gmz7xq9ge3py"
  plan_name         = "Pay as You Go"
  term_unit         = "P1M"
}
