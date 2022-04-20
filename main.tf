module "containers" {
  source                       = "./containers"
  project_name                 = local.project_name
  region                       = var.region
  docker_registry_service_name = var.docker_registry_service_name
  pool_id                      = var.pool_id
  provider_id                  = var.provider_id
  allowed_audiences            = var.allowed_audiences
  providers = {
    google-beta = google-beta
  }
}