output "github_workload_identity_pool_provider_id" {
  value = module.containers.workload_identity_pool_provider_id
}

output "kubernetes_endpoint" {
  description = "The cluster endpoint"
  sensitive   = true
  value       = module.orchestration.kubernetes_endpoint
}

output "client_token" {
  description = "The bearer token for auth"
  sensitive   = true
  value       = module.orchestration.client_token
}

output "ca_certificate" {
  description = "The cluster ca certificate (base64 encoded)"
  sensitive   = true
  value       = module.orchestration.ca_certificate
}

output "service_account" {
  description = "The default service account used for running nodes."
  value       = module.orchestration.service_account
}

output "cluster_name" {
  description = "Cluster name"
  value       = module.orchestration.cluster_name
}

output "network_name" {
  description = "The name of the VPC being created"
  value       = module.orchestration.network_name
}

output "subnet_name" {
  description = "The name of the subnet being created"
  value       = module.orchestration.subnet_name
}

output "subnet_secondary_ranges" {
  description = "The secondary ranges associated with the subnet"
  value       = module.orchestration.subnet_secondary_ranges
}

output "peering_name" {
  description = "The name of the peering between this cluster and the Google owned VPC."
  value       = module.orchestration.peering_name
}