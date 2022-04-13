data "google_client_config" "default" {}
module "gcp-network" {
  source       = "terraform-google-modules/network/google"
  project_id   = var.project_name_in
  network_name = "${var.network_name_in}-${var.env_name_in}"
  subnets = [
    {
      subnet_name   = "${var.subnetwork_name_in}-${var.env_name_in}"
      subnet_ip     = "10.10.0.0/16"
      subnet_region = var.region_in
    },
  ]
  secondary_ranges = {
    "${var.subnetwork_name_in}-${var.env_name_in}" = [
      {
        range_name    = var.ip_range_pods_name_in
        ip_cidr_range = "10.20.0.0/16"
      },
      {
        range_name    = var.ip_range_services_name_in
        ip_cidr_range = "10.30.0.0/16"
      },
    ]
  }
}

data "google_compute_subnetwork" "subnetwork" {
  name       = "${var.subnetwork_name_in}-${var.env_name_in}"
  project    = var.project_name_in
  region     = var.region_in
  depends_on = [module.gcp-network]
}

module "gke" {
  source                      = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                  = var.project_name_in

  name                        = "${var.cluster_name_in}-${var.env_name_in}"
  regional                    = var.regional_in
  region                      = var.region_in
  zones                       = var.zones_in
  network                     = module.gcp-network.network_name
  subnetwork                  = module.gcp-network.subnets_names[0]
  ip_range_pods               = var.ip_range_pods_name_in
  ip_range_services           = var.ip_range_services_name_in
  http_load_balancing         = false
  horizontal_pod_autoscaling  = true
  network_policy              = false
  remove_default_node_pool    = true
  release_channel             = "RAPID"
  kubernetes_version          = "latest"

  create_service_account  = true
  enable_private_endpoint = true
  enable_private_nodes    = true
  master_ipv4_cidr_block  = "172.16.0.0/28"

  node_pools = [
    {
      name                  = "zonal-pool"
      preeptible            = false
      machine_type          = "e2-custom-4-4096"
      image_type            = "UBUNTU"
      disk_type             = "pd-balanced"
      disk_size_gb          = 30
      local_ssd_count       = 0
      tags                  = "gke-node"
      min_count             = 1
      max_count             = 1
      max_surge             = 2
      max_unavailable       = 1
      autoscaling           = true
      auto_upgrade          = true
      auto_repair           = true
      node_metadata         = "GKE_METADATA"
    },
  ]

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-pool = true
    }
  }

    node_pools_tags = {
    all = []

    default-pool = [
     "gke-node", "${var.project_name_in}-gke"
    ]
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "instance_type"
        value  = "spot"
        effect = "NO_SCHEDULE"
      },
    ]
  }

    node_pools_oauth_scopes = {
    all = []

    regional-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
    ]
  }
    master_authorized_networks = [
    {
      cidr_block   = data.google_compute_subnetwork.subnetwork.ip_cidr_range
      display_name = "VPC"
    },
  ]

}

module "gke_auth" {
  source = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  depends_on   = [module.gke]
  project_id   = var.project_name_in
  location     = module.gke.location
  cluster_name = module.gke.name
}

resource "local_file" "kubeconfig" {
  content  = module.gke_auth.kubeconfig_raw
  filename = "kubeconfig-${var.env_name_in}-${timestamp()}"
}