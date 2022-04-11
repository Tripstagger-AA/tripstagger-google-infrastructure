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
  type    = string
  default = "dockerregistryadminservice"
}