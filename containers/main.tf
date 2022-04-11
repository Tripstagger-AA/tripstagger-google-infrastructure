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