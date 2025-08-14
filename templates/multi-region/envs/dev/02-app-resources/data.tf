data "terraform_remote_state" "common" {
  backend = "azurerm"
  config = {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstatestorageaccount"
    container_name       = "tfstate"
    key                  = "01-base-infra-multi-region.tfstate" # If you have a different key, update it accordingly
    use_oidc             = true
  }
}
