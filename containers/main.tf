resource "google_artifact_registry_repository" "docker" {
  location = var.region_in
  description = join(" ", [var.project_name_in, "Docker container registry"])
  repository_id = join("-", [var.project_name_in, "docker", "registry"])
  format = "DOCKER"
  provider = google-beta
}