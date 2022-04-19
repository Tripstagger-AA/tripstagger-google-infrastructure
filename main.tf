module "containers" {
  source                          = "./containers"
  project_name_in                 = local.project_name
  region_in                       = var.region
  docker_registry_service_name_in = var.docker_registry_service_name
  pool_id_in                      = var.pool_id
  provider_id_in                  = var.provider_id
  allowed_audiences_in            = var.allowed_audiences
  providers = {
    google-beta = google-beta
  }
}