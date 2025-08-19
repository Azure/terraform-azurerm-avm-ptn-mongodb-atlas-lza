terraform {
  required_version = "~> 1.12.2"
  backend "local" {
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.37.0"
    }
  }
}

provider "azurerm" {
  subscription_id = local.subscription_id
  features {}
}
