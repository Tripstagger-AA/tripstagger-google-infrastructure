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

resource "google_artifact_registry_repository_iam_member" "docker_registry_admin_iam_repoadmin_github" {
  provider = google-beta

  location = google_artifact_registry_repository.docker.location
  repository = google_artifact_registry_repository.docker.name
  role   = "roles/artifactregistry.repoAdmin"
  member = "serviceAccount:${google_service_account.docker_registry_admin.email}"
}

resource "google_project_iam_member" "docker_registry_admin_iam_accountTokenCreator" {
  provider = google-beta
  project = var.project_name_in

  role   = "roles/iam.serviceAccountTokenCreator"
  member = "serviceAccount:${google_service_account.docker_registry_admin.email}"
}

resource "google_project_iam_member" "docker_registry_admin_iam_repoadmin" {
  provider = google-beta
  project = var.project_name_in

  role   = "roles/artifactregistry.repoAdmin"
  member = "serviceAccount:${google_service_account.docker_registry_admin.email}"
}

resource "google_project_iam_member" "docker_registry_admin_iam_registryadmin" {
  provider = google-beta
  project = var.project_name_in

  role   = "roles/artifactregistry.admin"
  member = "serviceAccount:${google_service_account.docker_registry_admin.email}"
}

module "gh_oidc" {
  source      = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  project_id  = var.project_name_in
  pool_id     = var.pool_id_in
  provider_id = var.provider_id_in
  sa_mapping = local.service_map
  allowed_audiences = var.allowed_audiences_in
}
