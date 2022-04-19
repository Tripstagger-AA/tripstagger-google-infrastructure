locals {
  service_map = { for x in [var.docker_registry_service_name] : x => {
      sa_name   = "projects/${var.project_name}/serviceAccounts/${google_service_account.docker_registry_admin.email}"
      attribute = "*"
  }}
}