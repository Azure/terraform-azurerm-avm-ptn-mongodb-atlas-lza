module "devops" {
  source = "../../../../../modules/devops"

  # Common
  location = local.location
  tags     = local.tags

  # Resource group
  resource_group_name = module.naming.resource_group.name

  # Identity
  audiences   = local.audiences
  issuer      = local.issuer
  permissions = local.permissions
  federation  = local.federation

  # Storage Account
  storage_account_name = module.naming.storage_account.name_unique
  replication_type     = local.replication_type
  account_tier         = local.account_tier
  container_name       = local.container_name
}

module "mongodb_marketplace" {
  source            = "../../../../../modules/mongodb-marketplace"
  count             = local.should_create_mongo_org ? 1 : 0
  location          = local.location
  subscription_id   = local.subscription_id
  resource_group_id = module.devops.identity_info.resource_group_id

  publisher_id = local.publisher_id
  offer_id     = local.offer_id
  plan_id      = local.plan_id
  term_id      = local.term_id
  plan_name    = local.plan_name
  term_unit    = local.term_unit

  organization_name = local.organization_name

  first_name              = local.first_name
  last_name               = local.last_name
  email_address           = local.email_address
  should_create_mongo_org = local.should_create_mongo_org
}
