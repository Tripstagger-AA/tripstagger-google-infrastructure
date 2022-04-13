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
}

variable "gke_min_count" {
  type    = number
  default = 1
}

variable "gke_max_count" {
  type    = number
  default = 1
}

variable "gke_max_surge" {
  type    = number
  default = 2
}

variable "gke_max_unavailable" {
  type    = number
  default = 1
}