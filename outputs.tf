output "github_workload_identity_pool_provider_id" {
  value = module.containers.workload_identity_pool_provider_id
}

output "docker_registry_address" {
  description = "Full address to the docker registry"
  value       = module.containers.registry_address
}