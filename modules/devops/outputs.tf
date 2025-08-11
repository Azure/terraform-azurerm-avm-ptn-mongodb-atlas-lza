output "identity_info" {
  value = {
    tenant_id            = data.azurerm_client_config.current.tenant_id
    subscription_id      = data.azurerm_client_config.current.subscription_id
    client_id            = azurerm_user_assigned_identity.identity.client_id
    resource_group_id    = azurerm_resource_group.rg.id
    state_storage_name   = azurerm_storage_account.sa.name
    state_container_name = azurerm_storage_container.container.name
    storage_account_id   = azurerm_storage_account.sa.id
  }
}
