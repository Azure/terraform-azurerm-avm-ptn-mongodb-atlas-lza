# Network Module

This Terraform module provisions core networking resources in Azure, including:

- Virtual Network (VNet)
- Private Subnet
- NAT Gateway and Public IP
- Network Security Group (NSG)
- Private Endpoint for MongoDB Atlas (with Atlas PrivateLink integration)

## Resources Created

- `azurerm_virtual_network` (VNet)
- `azurerm_subnet` (Private Subnet)
- `azurerm_nat_gateway` and `azurerm_public_ip`
- `azurerm_network_security_group` (NSG)
- `azurerm_private_endpoint` (for MongoDB Atlas)
- `mongodbatlas_privatelink_endpoint_service` (Atlas PrivateLink)

## Module Inputs

| Variable                        | Description                                               | Type           | Required / Default           |
|----------------------------------|-----------------------------------------------------------|----------------|-----------------------------|
| vnet_name                       | Name of the virtual network                               | string         | yes                        |
| location                        | Azure region for the resources                            | string         | yes                        |
| resource_group_name             | Resource group for all resources                          | string         | yes                        |
| address_space                   | Address space for the VNet                                | list(string)   | yes                        |
| private_subnet_name             | Name of the private subnet                                | string         | yes                        |
| private_subnet_prefixes         | Address prefixes for the private subnet                   | list(string)   | yes                        |
| name_prefix                     | Prefix for naming NAT, NSG, and Public IP resources       | string         | yes                        |
| tags                            | Tags to apply to all resources                            | map(string)    | no                         |
| public_ip_name                  | Name of the public IP resource                            | string         | yes                        |
| nat_gateway_name                | Name of the NAT gateway resource                          | string         | yes                        |
| nsg_name                        | Name of the network security group                        | string         | yes                        |
| private_endpoint_name           | Name of the private endpoint for MongoDB                  | string         | yes                        |
| private_service_connection_name | Name of the private service connection                    | string         | yes                        |
| manual_connection               | Whether approval is required for the private endpoint     | bool           | no (default: false)        |
| private_connection_resource_id  | Resource ID of the MongoDB Atlas instance                 | string         | yes                        |
| private_subnet_id               | ID of the private subnet                                  | string         | yes                        |
| request_message                 | Message for manual connection approval                    | string         | no (default provided)      |
| project_id                      | ID of the MongoDB Atlas project                           | string         | yes                        |
| private_link_id                 | Atlas Private Link ID                                     | any            | yes                        |

## Module Outputs

| Output                | Description                              |
|-----------------------|------------------------------------------|
| vnet_id               | ID of the Virtual Network                |
| vnet_name             | Name of the Virtual Network              |
| private_subnet_id     | ID of the private subnet                 |
| nat_gateway_id        | ID of the NAT Gateway                    |
| nat_gateway_public_ip | Public IP address of the NAT Gateway     |
| private_subnet_nsg_id | ID of the NSG associated with the subnet |
| private_endpoint_id   | ID of the MongoDB private endpoint       |
