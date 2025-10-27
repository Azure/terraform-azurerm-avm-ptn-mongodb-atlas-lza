locals {
  environment = "dev"

  // These addresses will be used for the application resources.
  // You can adjust the addresses as needed.
  // Note: Ensure that these addresses do not conflict with existing subnet addresses and that
  // they are part of the same step 1 VNet.
  region_addresses = {
    eastus = {
      app_subnet = ["10.0.0.32/29"]
    }
    eastus2 = {
      app_subnet = ["10.0.0.72/29"]
    }
    westus = {
      app_subnet = ["10.0.0.88/29"]
    }
  }

  app_information_by_region = {
    for k, v in local.region_addresses :
    k => {
      location              = k
      app_service_plan_name = "${module.naming.app_service_plan.name_unique}-${k}"
      app_service_plan_sku  = "B1" # Minimum SKU for VNet integration is B1
      app_web_app_name      = "${module.naming.app_service.name_unique}-${k}"
      virtual_network_name  = data.terraform_remote_state.common.outputs.vnet_names[k]
      subnet_name           = "${module.naming.subnet.name_unique}-${k}"
      address_prefixes      = v.app_subnet
    }
  }

  tags = {
    environment = local.environment
  }
}
