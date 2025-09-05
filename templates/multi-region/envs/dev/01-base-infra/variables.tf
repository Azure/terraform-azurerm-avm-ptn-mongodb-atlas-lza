variable "org_id" {
  description = "ID of the MongoDB Atlas organization"
  type        = string
}

variable "cluster_name" {
  description = "Name of MongoDB Atlas cluster"
  type        = string
}

variable "project_name" {
  description = "Name of MongoDB Atlas project"
  type        = string
}

variable "mongo_atlas_client_id" {
  description = "MongoDB Atlas Client ID"
  type        = string
  sensitive   = true
}

variable "mongo_atlas_client_secret" {
  description = "MongoDB Atlas Client Secret"
  type        = string
  sensitive   = true
}

variable "function_frequency_cron" {
  description = "Function frequency in cron format"
  type        = string
  default     = "0 * * * *"
}
