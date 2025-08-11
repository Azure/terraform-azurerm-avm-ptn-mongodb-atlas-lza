resource "azurerm_user_assigned_identity" "identity" {
  location            = var.location
  name                = "root-identity"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_federated_identity_credential" "federated_identity" {
  name                = var.federation.federated_identity_name
  subject             = var.federation.subject
  audience            = var.audiences
  issuer              = var.issuer
  resource_group_name = azurerm_resource_group.rg.name
  parent_id           = azurerm_user_assigned_identity.identity.id
}

resource "azurerm_role_assignment" "permissions" {
  for_each = var.permissions

  scope                = "/subscriptions/${each.value.subscription_id}"
  role_definition_name = each.value.role
  role_definition_id   = null
  principal_id         = azurerm_user_assigned_identity.identity.principal_id
}

resource "azurerm_role_assignment" "blob_data_contributor" {
  scope                = azurerm_storage_account.sa.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.identity.principal_id
}
