terraform {
  required_version = ">= 1.3.0"

  backend "azurerm" {
    use_azuread_auth = true
  }

  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "1.39.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "mongodbatlas" {
}
