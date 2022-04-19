variable "region" {
  type    = string
}

variable "project_name" {
  type    = string
}

variable "docker_registry_service_name" {
  type    = string
}

variable "pool_id" {
  type    = string
}

variable "provider_id" {
  type    = string
}

variable "allowed_audiences" {
  type        = list(string)
}