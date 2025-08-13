variable "org_id" {
  description = "MongoDB Atlas organization ID."
  type        = string
}

variable "cluster_name" {
  description = "Name of the MongoDB cluster."
  type        = string
}

variable "cluster_type" {
  description = "Type of the cluster (e.g., REPLICASET)."
  type        = string
}

variable "instance_size" {
  description = "Size of the cluster instance (e.g., M10)."
  type        = string
}

variable "backup_enabled" {
  description = "Whether backup is enabled for the cluster."
  type        = bool
}

variable "project_name" {
  description = "MongoDB Atlas project name."
  type        = string
}

variable "reference_hour_of_day" {
  description = "Hour of the day for backup reference time (0-23)."
  type        = number
  default     = 3
}

variable "reference_minute_of_hour" {
  description = "Minute of the hour for backup reference time (0-59)."
  type        = number
  default     = 45
}

variable "restore_window_days" {
  description = "Number of days for the restore window."
  type        = number
  default     = 4
}

variable "region_configs" {
  description = "Map of region configurations for multi-region cluster."
  type = map(object({
    atlas_region = string # e.g., "EAST_US_2" — Atlas Azure region code, see https://www.mongodb.com/docs/atlas/reference/microsoft-azure/#std-label-microsoft-azure-availability-zones
    azure_region = string # e.g., "eastus2" — Azure region name for Azure resources
    priority     = number
    electable_specs = object({
      instance_size = string
      node_count    = number
    })
  }))

  validation {
    condition = contains([3, 5, 7],
      sum([for rc in var.region_configs : rc.electable_specs.node_count])
    )
    error_message = "MongoDB Atlas only allows 3, 5, or 7 total nodes. Got ${sum([for region in var.region_configs : region.electable_specs.node_count])}."
  }
}
