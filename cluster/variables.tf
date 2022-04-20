variable "region" {
  type    = string
}

variable "project_name" {
  type    = string
}

variable "cluster_name" {
  description = "The name for the GKE cluster"
  type    = string
}

variable "zone" {
  description = "The region to host the cluster in"
  type    = string
}

variable "machine_type" {
  description = "The region to host the cluster in"
  type    = string
}

variable "disk_size" {
  type    =  number
}

variable "network_name" {
  type    =  string
}

variable "ip_address_name" {
  type    =  string
}

variable "ssl_cert_name" {
  type    =  string
}

variable "ssl_cert_crt" {
  type    =  string
}

variable "ssl_cert_key" {
  type    =  string
}

variable "https" {
  type    =  bool
}

variable "num_nodes" {
  type = number
}

variable "max_num_nodes" {
  type = number
}