terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.5.0"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.5.0"
    }

    local = {
      source = "hashicorp/local"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}

provider "google" {
  region  = var.region
  zone    = var.zone
  project = local.project_name
  #   credentials = "gcp-keys.json"
}

provider "google-beta" {
  region  = var.region
  project = local.project_name
  zone    = var.zone
}

provider "local" {
}

provider "random" {

}