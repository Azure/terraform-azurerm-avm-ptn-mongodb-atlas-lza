output "identity_info" {
  value = {
    tenant_id                        = data.azurerm_client_config.current.tenant_id
    subscription_id                  = data.azurerm_client_config.current.subscription_id
    client_id                        = azurerm_user_assigned_identity.identity.client_id
    devops_resource_group_id         = azurerm_resource_group.devops_rg.id
    infrastructure_resource_group_id = azurerm_resource_group.infrastructure_rg.id
    application_resource_group_id    = length(var.resource_group_name_app) > 0 ? azurerm_resource_group.application_rg[0].id : null
    state_storage_name               = azurerm_storage_account.sa.name
    state_container_name             = azurerm_storage_container.container.name
    storage_account_id               = azurerm_storage_account.sa.id
  }
}

output "resource_group_names" {
  value = {
    devops         = var.resource_group_name_devops
    infrastructure = var.resource_group_name_infrastructure
    app            = length(var.resource_group_name_app) > 0 ? var.resource_group_name_app : null
  }

}
