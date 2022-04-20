terraform {
  required_providers {
     google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.5.0"
    }

    random = {
      source = "hashicorp/random"
      version = "3.1.0"
    }
  }
}