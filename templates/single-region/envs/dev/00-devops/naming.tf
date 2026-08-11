module "devops_naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.2"
  suffix  = ["devops"]
}

module "infrastructure_naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.2"
  suffix  = ["infra"]
}

module "application_naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.2"
  suffix  = ["app"]
}
