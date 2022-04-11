locals {
  project_name = coalesce(var.project_name, terraform.workspace)
}