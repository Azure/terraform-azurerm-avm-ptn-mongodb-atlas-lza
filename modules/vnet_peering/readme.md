# VNet Peering Module

This Terraform module provisions virtual network peering between two VNets in Azure.

## Resources Created

- `azurerm_virtual_network_peering` (Peering from this VNet to the peer VNet)
- `azurerm_virtual_network_peering` (Peering from the peer VNet to this VNet)

## Module Inputs

| Variable                  | Description                                      | Type   | Required / Default |
|---------------------------|--------------------------------------------------|--------|---------------------|
| name_this_to_peer         | Name of the peering from this VNet to the peer VNet | string | yes                 |
| name_peer_to_this         | Name of the peering from the peer VNet to this VNet | string | yes                 |
| resource_group_name_this  | Resource group of the first VNet                 | string | yes                 |
| resource_group_name_peer  | Resource group of the second VNet                | string | yes                 |
| vnet_name_this            | Name of the first VNet                          | string | yes                 |
| vnet_name_peer            | Name of the second VNet                         | string | yes                 |
| vnet_id_this              | ID of the first VNet                            | string | yes                 |
| vnet_id_peer              | ID of the second VNet                           | string | yes                 |
| allow_forwarded_traffic   | Whether to allow forwarded traffic              | bool   | no (default: false) |
| allow_gateway_transit     | Whether to allow gateway transit                | bool   | no (default: false) |
| use_remote_gateways       | Whether to use remote gateways                  | bool   | no (default: false) |

## Module Outputs

| Output        | Description                              |
|---------------|------------------------------------------|
| peering_ids   | IDs of both peerings                     |