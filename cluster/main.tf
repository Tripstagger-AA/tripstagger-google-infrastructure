resource "google_compute_network" "default" {
  name                    = var.network_name
  auto_create_subnetworks = "false"
  project = var.project_name
  # Everything in this solution is deployed regionally
  routing_mode = "REGIONAL"
}