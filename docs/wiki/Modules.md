# Modules

## [Application Module](../modules/application/readme.md)

- Creates a dedicated resource group for the application.
- Deploys App Service Plan and Azure Web App (test app).
- Provisions virtual network and subnet for the app.
- Enables VNet integration for secure connectivity validation to MongoDB Atlas.

## [Network Module](../modules/network/readme.md)

- Deploys Azure virtual network, private subnet, NAT gateway, public IP, and network security group.
- Creates private endpoint for secure MongoDB Atlas connectivity.
- Integrates with MongoDB Atlas PrivateLink and secures all network traffic.

## [MongoDB Atlas Configuration Module For Single Region](../modules/atlas_config_single_region/readme.md)

- Provisions MongoDB Atlas project and advanced cluster using the official provider.
- Configures cluster sizing, region, backup, sharding, and high availability.
- Sets up PrivateLink endpoint and manages database users.
- Enables automated backup schedules with customizable policies.

## [MongoDB Atlas Configuration Module For Multi Region](../modules/atlas_config_multi_region/readme.md)

- Configures a MongoDB Atlas project and advanced cluster for multi-region deployments.
- Supports flexible cluster sizing, region replication, and high availability.
- Provisions Azure PrivateLink endpoints for secure connectivity.
- Enables automated backup schedules with customizable policies.
