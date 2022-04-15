locals {
  network_name = "${var.network_name_in}-${var.env_name_in}"
  subnetwork_name = "${var.subnetwork_name_in}-${var.env_name_in}"
  network_ip_pods_name = "random-ip-range-pods-${var.env_name_in}"
  network_ip_services_name = "random-ip-range-services-${var.env_name_in}"
  cluster_name = "${var.cluster_name_in}-${var.env_name_in}"
}