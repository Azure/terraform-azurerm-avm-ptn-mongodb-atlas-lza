# Modules

## [Application Module](../../modules/application/readme.md)

- Deploys an App Service Plan and an Azure Web App. The Test DB Connection app has to be deployed to this Web App to test the connection with the deployed cluster. For more information, please refer the [Test DB Connection App Guide](./Test_DB_connection_steps.md).
- Provisions virtual network and subnet for the app.
- Enables VNet integration for secure connectivity validation to MongoDB Atlas.

## [DevOps Module](../../modules/devops/readme.md)

- Provisions the core resource group for state and identity management.
- Creates the Infrastructure resource group (which will be used in the step 01)
- Creates the Application resource group (which will be used in the step 02). This is optional since the step 02 is just to test the connection with the deployed cluster.
- Creates a storage account and container for Terraform remote state.
- Sets up federated identity and role assignments for automation.

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

## [Network Module](../../modules/network/readme.md)

- Deploys Azure virtual network, private subnet, NAT gateway, public IP, and network security group.
- Creates Azure Private Endpoints to connect securely to MongoDB Atlas PrivateLink services.
- Establishes secure private network connectivity between Azure and MongoDB Atlas.

## [VNet Peering Module](../../modules/vnet_peering/readme.md)

- Provisions virtual network peering between two VNets in Azure.
- Creates bidirectional peering connections with configurable traffic and gateway settings.
- Used in multi-region deployments to connect VNets across different regions.

## [Observability Module](../../modules/observability/readme.md)

- Provisions observability infrastructure for monitoring MongoDB Atlas metrics in Azure. It creates all necessary resources to host a scheduled metrics collection Function App. The MongoAtlasMetrics app has to be deployed to the created Function App resource to send the metrics to the Application Insights. For more information, please refer the [MongoAtlasMetrics App Guide](./MongoAtlasMetrics_deployment_steps.md).