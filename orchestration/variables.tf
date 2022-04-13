variable "region_in" {
  type    = string
}

variable "project_name_in" {
  type    = string
}

variable "cluster_name_in" {
  description = "The name for the GKE cluster"
}

variable "zones_in" {
  description = "The region to host the cluster in"
}

variable "regional_in" {
    type = bool
}

variable "env_name_in" {
  type    = string
  description = "The environment for the GKE cluster"
}

variable "network_name_in" {
  type    = string
  description = "The VPC network created to host the cluster in"
  default     = "gke-network"
}

variable "subnetwork_name_in" {
  description = "The subnetwork created to host the cluster in"
  default     = "gke-subnet"
}

variable "subnetwork_ipv4_cidr_range_in" {
  description = "The subnetwork ip cidr block range."
  default     = "10.20.0.0/14"
}

variable "ip_range_pods_name_in" {
  description = "The secondary ip range to use for pods"
  default     = "ip-range-pods"
}

variable "pod_ipv4_cidr_range_in" {
  description = "The cidr ip range to use for pods"
  default     = "10.24.0.0/14"
}

variable "ip_range_services_name_in" {
  description = "The secondary ip range name to use for services"
  default     = "ip-range-services"
}

variable "services_ipv4_cidr_range_in" {
  description = "The cidr ip range to use for services"
  default     = "10.28.0.0/20"
}

variable "min_count_in" {
  type = number
}

variable "max_count_in" {
  type = number
}

variable "max_surge_in" {
  type = number
}

variable "max_unavailable_in" {
  type = number
}