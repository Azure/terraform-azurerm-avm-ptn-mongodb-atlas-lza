terraform {
  required_version = "~> 1.13.1"
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 1.39.0"
    }
  }
}
