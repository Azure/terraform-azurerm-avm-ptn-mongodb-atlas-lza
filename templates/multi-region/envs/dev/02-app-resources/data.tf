data "terraform_remote_state" "common" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.resource_group_name_tfstate
    storage_account_name = var.storage_account_name_tfstate
    container_name       = var.container_name_tfstate
    key                  = var.key_name_infra_tfstate
    use_oidc             = true
  }
}

data "terraform_remote_state" "devops" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.resource_group_name_tfstate
    storage_account_name = var.storage_account_name_tfstate
    container_name       = var.container_name_tfstate
    key                  = var.key_name_tfstate
    use_oidc             = true
  }
}
