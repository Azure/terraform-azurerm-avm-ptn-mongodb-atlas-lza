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

variable "first_name" {
  description = "First name of MongoDB Atlas admin user"
  type        = string
  default     = ""
}

variable "last_name" {
  description = "Last name of MongoDB Atlas admin user"
  type        = string
  default     = ""
}

variable "email_address" {
  description = "Email of the MongoDB Atlas user"
  type        = string
  sensitive   = true
  default     = ""
}
