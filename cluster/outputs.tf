output "workload_identity_pool_provider_id" {
  value = "${module.gh_oidc.provider_name}"
}

output "kubernetes_service" {
  value = google_service_account.cluster_service_account.email
}

output "cluster_endpoint" {
  value = google_container_cluster.default.endpoint
}