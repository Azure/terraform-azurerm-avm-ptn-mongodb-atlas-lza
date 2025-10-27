data "azurerm_client_config" "current" {
}

resource "azurerm_resource_group" "devops_rg" {
  name     = var.resource_group_name_devops
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "infrastructure_rg" {
  name     = var.resource_group_name_infrastructure
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "application_rg" {
  count    = length(var.resource_group_name_app) > 0 ? 1 : 0
  name     = var.resource_group_name_app
  location = var.location
  tags     = var.tags
}

resource "azurerm_storage_account" "sa" {
  name                            = var.storage_account_name
  resource_group_name             = azurerm_resource_group.devops_rg.name
  location                        = var.location
  account_tier                    = var.account_tier
  account_replication_type        = var.replication_type
  tags                            = var.tags
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  blob_properties {
    delete_retention_policy {
      days = 7
    }

    versioning_enabled = true
  }

  infrastructure_encryption_enabled = true
}

resource "azurerm_storage_container" "container" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.sa.id
  container_access_type = var.container_access_type
}
