locals {
  environment = "dev"

  // This is a custom logic to increment by 3 the third octet of the private subnet prefix
  // for each region defined in the Step 1 outputs. You can adjust the logic as needed.
  // The incremented addresses will be used for the application resources.
  // Note: Ensure that the incremented addresses do not conflict with existing addresses.
  incremented_addresses = {
    for k, v in data.terraform_remote_state.common.outputs.regions_values :
    k => "${join(".", [
      split(".", split("/", v.private_subnet_prefixes[0])[0])[0],                         # first octet
      split(".", split("/", v.private_subnet_prefixes[0])[0])[1],                         # second octet
      tostring(tonumber(split(".", split("/", v.private_subnet_prefixes[0])[0])[2]) + 3), # incremented third octet
      split(".", split("/", v.private_subnet_prefixes[0])[0])[3]                          # fourth octet
    ])}/${split("/", v.private_subnet_prefixes[0])[1]}"                                   # mask
  }

  app_information_by_region = {
    for k, v in local.incremented_addresses :
    k => {
      resource_group_name   = "${module.naming.resource_group.name_unique}-${k}"
      location              = k
      app_service_plan_name = "${module.naming.app_service_plan.name_unique}-${k}"
      app_service_plan_sku  = "B1" # Minimum SKU for VNet integration is B1
      app_web_app_name      = "${module.naming.app_service.name_unique}-${k}"
      virtual_network_name  = data.terraform_remote_state.common.outputs.vnet_names[k]
      subnet_name           = "${module.naming.subnet.name_unique}-${k}"
      address_prefixes      = [v]
    }
  }

  tags = {
    environment = local.environment
  }
}
