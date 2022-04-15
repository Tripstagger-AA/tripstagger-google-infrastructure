
data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gcp-network" {
  source  = "terraform-google-modules/network/google"

  project_id   = var.project_name_in
  network_name = local.network_name

  subnets = [
    {
      subnet_name           = local.subnetwork_name
      subnet_ip             = "10.0.0.0/17"
      subnet_region         = var.region_in
      subnet_private_access = "true"
    },
  ]

  secondary_ranges = {
    (local.subnetwork_name) = [
      {
        range_name    = local.network_ip_pods_name
        ip_cidr_range = "192.168.0.0/18"
      },
      {
        range_name    = local.network_ip_services_name
        ip_cidr_range = "192.168.64.0/18"
      },
    ]
  }
}

  data "google_compute_subnetwork" "subnetwork" {
  name       = local.subnetwork_name
  project    = var.project_name_in
  region     = var.region_in
  depends_on = [module.gcp-network]
  }

  module "gke" {
    source     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
    project_id = var.project_name_in
    name       = local.cluster_name
    regional   = var.regional_in
    region     = var.region_in
    zones      = var.zones_in

    network                 = module.gcp-network.network_name
    subnetwork              = module.gcp-network.subnets_names[0]
    ip_range_pods           = local.network_ip_pods_name
    ip_range_services       = local.network_ip_services_name
    create_service_account  = true
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.0.0/28"

    http_load_balancing         = false
    horizontal_pod_autoscaling  = var.enable_autoscaling_in

    master_authorized_networks = [
      {
        cidr_block   = data.google_compute_subnetwork.subnetwork.ip_cidr_range
        display_name = "VPC"
      },
    ]


  node_pools = [
    {
      name            = "zonal-pool"
      min_count       = var.min_count_in
      max_count       = var.max_count_in
      image_type            = "UBUNTU"
      tags            = "gke-node"
      auto_upgrade    = true
      auto_repair           = true
      preemptible           = true
    },
  ]

    node_pools_oauth_scopes = {
    all     = []
    zonal-pool = []
  }

    node_pools_metadata = {
    all = {}
    zonal-pool = {
       shutdown-script = file("${path.module}/data/shutdown-script.sh")
    }
  }

  node_pools_labels = {
    all = {}

    zonal-pool = {
      default-pool = true
    }
  }

    node_pools_tags = {
    all = []

    zonal-pool = [
     "gke-node", "${var.project_name_in}-gke"
    ]
  }
}