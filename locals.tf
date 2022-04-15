locals {
  project_name = coalesce(var.project_name, terraform.workspace)

  zones = ["${var.region}-a", "${var.region}-b"]
}