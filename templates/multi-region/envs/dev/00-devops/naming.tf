module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.2"
  suffix  = [local.suffix]
}
