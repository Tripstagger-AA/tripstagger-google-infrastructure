terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.85.0"
    }
  }
}

provider "google" {
  region  = var.region
  project = join("-", "tripstagger", terraform.workspace)
}