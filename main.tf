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

module "cluster" {
  source          = "./cluster"
  region          = var.region
  project_name    = local.project_name
  cluster_name    = var.gke_cluster_name
  zone            = var.zone
  machine_type    = var.gke_machine_type
  disk_size       = var.gke_disk_size
  network_name    = var.gke_network_name
  ip_address_name = var.gke_ip_address_name
  https           = var.gke_https
  num_nodes       = var.gke_num_nodes
  max_num_nodes   = var.gke_max_num_nodes
  ssl_cert_name   = var.gke_ssl_cert_name
  ssl_cert_key    = var.gke_ssl_cert_key
  ssl_cert_crt    = var.gke_ssl_cert_crt

  providers = {
    google-beta = google-beta
    random      = random
  }
}