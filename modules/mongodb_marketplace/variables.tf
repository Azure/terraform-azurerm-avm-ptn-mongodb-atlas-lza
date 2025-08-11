variable "organization_name" {
  description = "Name of the MongoDB Atlas organization"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "resource_group_id" {
  description = "Resource group ID for the organization"
  type        = string
}

variable "offer_id" {
  description = "Marketplace offer ID"
  type        = string
}

variable "plan_id" {
  description = "Marketplace plan ID"
  type        = string
}

variable "publisher_id" {
  description = "Marketplace publisher ID"
  type        = string
}

variable "term_id" {
  description = "Marketplace term ID"
  type        = string
}

variable "plan_name" {
  description = "Marketplace plan name"
  type        = string
}

variable "term_unit" {
  description = "Marketplace term unit"
  type        = string
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "email_address" {
  description = "Email address of the user"
  type        = string
  default     = ""

  validation {
    condition     = var.should_create_mongo_org == false || length(var.email_address) > 0
    error_message = "email_address must be set if should_create_mongo_org is true."
  }
}

variable "first_name" {
  description = "First name of the user"
  type        = string
  default     = ""

  validation {
    condition     = var.should_create_mongo_org == false || length(var.first_name) > 0
    error_message = "first_name must be set if should_create_mongo_org is true."
  }
}

variable "last_name" {
  description = "Last name of the user"
  type        = string
  default     = ""

  validation {
    condition     = var.should_create_mongo_org == false || length(var.last_name) > 0
    error_message = "last_name must be set if should_create_mongo_org is true."
  }
}

variable "should_create_mongo_org" {
  description = "Whether to create a new MongoDB Atlas organization"
  type        = bool
  default     = false
}
