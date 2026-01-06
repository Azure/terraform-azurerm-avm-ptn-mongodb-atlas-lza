terraform {
  required_version = "~> 1.13.1"
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.6.0"
    }
  }
}
