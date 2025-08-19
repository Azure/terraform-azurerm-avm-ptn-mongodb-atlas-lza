terraform {
  required_version = "~> 1.12.2"
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.6.0"
    }
  }
}
