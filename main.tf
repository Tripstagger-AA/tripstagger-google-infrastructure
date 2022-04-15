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

module "orchestration" {
  source                = "./orchestration"
  cluster_name_in       = var.gke_cluster_name
  region_in             = var.region
  project_name_in       = local.project_name
  env_name_in           = "test"
  regional_in           = var.gke_regional
  zones_in              = local.zones
  min_count_in          = var.gke_min_count
  max_count_in          = var.gke_max_count
  max_surge_in          = var.gke_max_surge
  max_unavailable_in    = var.gke_max_unavailable
  enable_autoscaling_in = var.gke_enable_autoscaling

  providers = {
    google = google
  }
}