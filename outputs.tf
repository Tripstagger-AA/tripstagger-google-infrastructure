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

output "gke_workload_identity_pool_provider_id" {
  value = module.cluster.workload_identity_pool_provider_id
}

output "gke_kubernetes_service" {
  description = "Email address for the gke registry service"
  value       = module.cluster.kubernetes_service
}

output "gke_cluster_endpoint" {
  value = module.cluster.cluster_endpoint
}