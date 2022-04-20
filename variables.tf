variable "region" {
  type    = string
  default = "europe-west3"
}

variable "zone" {
  type    = string
  default = "europe-west3-a"
}

variable "location" {
  type    = string
  default = "EU"
}

variable "project_name" {
  type    = string
  default = null
}

variable "docker_registry_service_name" {
  type = string
}

variable "pool_id" {
  type = string
}

variable "provider_id" {
  type = string
}

variable "allowed_audiences" {
  type        = list(string)
  description = "Workload Identity Pool Provider allowed audiences."
  default     = []
}

variable "gke_cluster_name" {
  description = "The name for the GKE cluster"
  type        = string
}

variable "gke_machine_type" {
  description = "The region to host the cluster in"
  type        = string
  default     = "e2-standard-2"
}

variable "gke_disk_size" {
  type    = number
  default = 20
}

variable "gke_network_name" {
  type    = string
  default = "gke-network"
}

variable "gke_ip_address_name" {
  type    = string
  default = "gke-ip-address"
}

variable "gke_https" {
  type    = bool
  default = false
}

variable "gke_num_nodes" {
  type    = number
  default = 3
}

variable "gke_max_num_nodes" {
  type    = number
  default = 5
}

variable "gke_ssl_cert_crt" {
  type = string
}

variable "gke_ssl_cert_key" {
  type = string
}

variable "gke_ssl_cert_name" {
  type = string
}