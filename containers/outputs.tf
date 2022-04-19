output "workload_identity_pool_provider_id" {
  value = "${module.gh_oidc.provider_name}"
}

output "registry_address" {
  value = "${var.region}-docker.pkg.dev/${var.project_name}/${google_artifact_registry_repository.docker.repository_id}"
}