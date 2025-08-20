# Modules

## [Application Module](../../modules/application/readme.md)

- Creates a dedicated resource group for the application.
- Deploys App Service Plan and Azure Web App (test app).
- Provisions virtual network and subnet for the app.
- Enables VNet integration for secure connectivity validation to MongoDB Atlas.

## [DevOps Module](../../modules/devops/readme.md)

- Provisions the core resource group for state and identity management.
- Creates a storage account and container for Terraform remote state.
- Sets up federated identity and role assignments for automation.
- Optionally provisions a MongoDB Atlas Organization via Azure Marketplace (if enabled).

## [MongoDB Atlas Configuration Module For Multi Region](../../modules/atlas_config_multi_region/readme.md)

- Configures a MongoDB Atlas project and advanced cluster for multi-region deployments.
- Supports flexible cluster sizing, region replication, and high availability.
- Enables automated backup schedules with customizable policies.

## [MongoDB Atlas Configuration Module For Single Region](../../modules/atlas_config_single_region/readme.md)

- Provisions MongoDB Atlas project and advanced cluster using the official provider.
- Configures cluster sizing, region, backup, sharding, and high availability.
- Enables automated backup schedules with customizable policies.

## [MongoDB Marketplace Module](../../modules/mongodb_marketplace/readme.md)

- Provisions a MongoDB Atlas Organization using Azure Marketplace integration and the azapi provider.
- Used only if you want to automate Atlas org creation from Azure.

## [Network Module](../../modules/network/readme.md)

- Deploys Azure virtual network, private subnet, NAT gateway, public IP, and network security group.
- Creates Azure Private Endpoints to connect securely to MongoDB Atlas PrivateLink services.
- Establishes secure private network connectivity between Azure and MongoDB Atlas.

## [VNet Peering Module](../../modules/vnet_peering/readme.md)

- Provisions virtual network peering between two VNets in Azure.
- Creates bidirectional peering connections with configurable traffic and gateway settings.
- Used in multi-region deployments to connect VNets across different regions.
