variable "github_organization_name" {
  description = "GitHub organization name"
  type        = string
  sensitive   = true
}

variable "github_repository_name" {
  description = "GitHub repository name"
  type        = string
  sensitive   = true
}

variable "mongodb_atlas_organization_name" {
  description = "Name of the MongoDB Atlas organization"
  type        = string
  sensitive   = true
  default     = ""
}

variable "email_address" {
  description = "Email of the MongoDB Atlas user"
  type        = string
  default     = ""

  validation {
    condition     = var.should_create_mongo_org == false || length(var.email_address) > 0
    error_message = "email_address must be set for MongoDB Atlas org creation."
  }
}

variable "first_name" {
  description = "First name of MongoDB Atlas user"
  type        = string
  default     = ""

  validation {
    condition     = var.should_create_mongo_org == false || length(var.first_name) > 0
    error_message = "first_name must be set for MongoDB Atlas org creation."
  }
}

variable "last_name" {
  description = "Last name of MongoDB Atlas user"
  type        = string
  default     = ""

  validation {
    condition     = var.should_create_mongo_org == false || length(var.last_name) > 0
    error_message = "last_name must be set for MongoDB Atlas org creation."
  }
}

variable "should_create_mongo_org" {
  description = "Flag to determine whether a MongoDB Atlas organization should be created. Set to true to create, false to skip."
  type        = bool
  default     = true
}
