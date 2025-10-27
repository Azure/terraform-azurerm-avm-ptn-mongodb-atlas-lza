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

variable "region" {
  description = "Azure region where the cluster will be deployed."
  type        = string
}

variable "electable_nodes" {
  description = "Number of electable nodes."
  type        = number
}

variable "priority" {
  description = "Priority of the region."
  type        = number
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
