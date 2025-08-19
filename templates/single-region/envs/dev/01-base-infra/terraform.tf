terraform {
  required_version = "~> 1.12.2"

  backend "azurerm" {
    use_azuread_auth = true
  }

  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 1.39.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.37.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "mongodbatlas" {
}
