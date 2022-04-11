module "containers" {
  source                          = "./containers"
  project_name_in                 = local.project_name
  region_in                       = var.region
  docker_registry_service_name_in = var.docker_registry_service_name
  providers = {
    google-beta = google-beta
  }
}
