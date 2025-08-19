resource "azapi_resource" "mongodb_atlas_org" {
  count     = var.should_create_mongo_org ? 1 : 0
  type      = "mongodb.atlas/organizations@2025-06-01"
  name      = var.organization_name
  location  = var.location
  parent_id = var.resource_group_id

  body = {
    properties = {
      marketplace = {
        subscriptionId = var.subscription_id
        offerDetails = {
          publisherId = var.publisher_id
          offerId     = var.offer_id
          planId      = var.plan_id
          planName    = var.plan_name
          termUnit    = var.term_unit
          termId      = var.term_id
        }
      }
      user = {
        firstName    = var.first_name
        lastName     = var.last_name
        emailAddress = var.email_address
      }
      partnerProperties = {
        organizationName = var.organization_name
      }
    }
  }
}

