### Create registry and admin service account for the given registry
resource "google_artifact_registry_repository" "docker" {
  location = var.region_in
  description = join(" ", [var.project_name_in, "Docker container registry"])
  repository_id = join("-", [var.project_name_in, "docker", "registry"])
  format = "DOCKER"
  provider = google-beta
}

resource "google_service_account" "docker_registry_admin" {
  provider = google-beta

  account_id   = var.docker_registry_service_name_in
  display_name = "Admin for the google artifact registry repository"
}

resource "google_artifact_registry_repository_iam_member" "docker_registry_admin_iam_repoadmin" {
  provider = google-beta

  location = google_artifact_registry_repository.docker.location
  repository = google_artifact_registry_repository.docker.name
  role   = "roles/artifactregistry.repoAdmin"
  member = "serviceAccount:${google_service_account.docker_registry_admin.email}"
}

# Create a service account impersonation
resource "google_iam_workload_identity_pool" "github_pool" {
  provider                  = google-beta

  workload_identity_pool_id = substr("github-pool-${var.project_name_in}", 0, 30)
}

resource "google_iam_workload_identity_pool_provider" "github_provider" {
  provider                           = google-beta
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = substr("github-provider-${var.project_name_in}", 0, 32)
  display_name                       = "GitHub provider"
  attribute_mapping = {
    "google.subject"  = "assertion.sub"
    "attribute.aud"   = "assertion.aud"
    "attribute.actor" = "assertion.actor"
  }
  oidc {
   # This is the only audience GitHub send today.
    allowed_audiences = ["sigstore"]
    issuer_uri        = "https://vstoken.actions.githubusercontent.com"
  }
}

resource "google_service_account_iam_member" "pool_impersonation" {
  provider           = google-beta
  service_account_id = "projects/${var.project_name_in}/serviceAccounts/${google_service_account.docker_registry_admin.email}"
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_pool.name}/*"
}