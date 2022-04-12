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