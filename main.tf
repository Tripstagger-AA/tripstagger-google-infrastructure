module "containers" {
  source          = "./containers"
  project_name_in = local.project_name
  region_in       = var.region
  providers = {
    google-beta = google-beta
  }
}
