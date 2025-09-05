data "terraform_remote_state" "common" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.resource_group_name_tfstate_01
    storage_account_name = var.storage_account_name_tfstate_01
    container_name       = var.container_name_tfstate_01
    key                  = var.key_name_tfstate_01
    use_oidc             = true
  }
}
