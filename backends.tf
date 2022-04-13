terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "aas"

    workspaces {
      name = "tripstagger-google-infrastructure-dev"
    }
  }
}