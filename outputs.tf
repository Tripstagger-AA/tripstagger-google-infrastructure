output "github_workload_identity_pool_provider_id" {
  value = module.containers.workload_identity_pool_provider_id
}

output "docker_registry_address" {
  description = "Full address to the docker registry"
  value       = module.containers.registry_address
}

output "docker_registry_service" {
  description = "Email address for the docker registry service"
  value       = module.containers.registry_service
}