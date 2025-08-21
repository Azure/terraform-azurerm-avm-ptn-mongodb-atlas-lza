# Known Issues

## Table of Contents

- [MongoDB Marketplace Organization Uniqueness](#mongodb-marketplace-organization-uniqueness)
- [Manual Atlas Organization Cleanup Required](#manual-atlas-organization-cleanup-required)

## MongoDB Marketplace Organization Uniqueness

**Issue**: When using the `mongodb_marketplace` module, the MongoDB organization name must be globally unique across all MongoDB Atlas deployments.

**Details**:

- The `azapi_resource` provider used in the MongoDB marketplace integration does not have the ability to fetch the current MongoDB Atlas organization status.
- This means Terraform will always attempt to create a new organization, even if one with the same name already exists.
- If an organization with the specified name already exists, the deployment will fail.

**Workaround**:

- Ensure your organization name is unique before deployment
- If you already have a MongoDB Atlas Organization, consider providing the necessary details in the step #1 of the chosen implementation (single-region or multi-region).

## Manual Atlas Organization Cleanup Required

**Issue**: When you delete the Atlas organization instance in Azure (either manually or with `terraform destroy`), the MongoDB Atlas organization is not automatically deleted from the Atlas portal.

**Details**:

- Terraform can create MongoDB Atlas organizations through the Azure marketplace integration, but deletion is not handled automatically.
- Running `terraform destroy` will remove the Azure resources but leave the MongoDB Atlas organization active.
- This can lead to orphaned organizations in your MongoDB Atlas account and potential billing issues.

**Workaround**:

- After destroying the Azure infrastructure, manually delete the MongoDB Atlas organization through the Atlas portal.
- Follow the official MongoDB documentation for [deleting an organization](https://www.mongodb.com/docs/atlas/access/orgs-create-view-edit-delete/#delete-an-organization).
- Ensure all projects and clusters within the organization are deleted before removing the organization itself.
- Verify that the organization is completely removed from your MongoDB Atlas account to avoid unexpected charges.

## Getting a "Provider produced inconsistent result after apply" error when running the pipeline

**Issue**: When you update some MongoDB Atlas values in Terraform, and it has to recreate resources, you could get a `Provider produced inconsistent result after apply` error.

**Details**:

The error could be similar to the following one:

``` tf
Error: Provider produced inconsistent result after apply
 
When applying changes to
module.mongodb_atlas_config.mongodbatlas_project.project, provider
"provider[\"registry.terraform.io/mongodb/mongodbatlas\"]" produced an
unexpected new value: .ip_addresses.services.clusters: element 0 has
vanished.
 
This is a bug in the provider, which should be reported in the provider's
own issue tracker.

```

**Workaround**:

- Re-run the pipeline, since it can be a transitive issue.
