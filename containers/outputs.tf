output "workload_identity_pool_provider_id" {
  value = "${module.gh_oidc.provider_name}"
}

output "registry_address" {
  value = "${var.region}-docker.pkg.dev/${var.project_name}/${google_artifact_registry_repository.docker.repository_id}"
}

output "registry_service" {
  value = google_service_account.docker_registry_admin.email
}