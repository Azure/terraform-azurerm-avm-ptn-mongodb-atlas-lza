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
