locals {
  service_map = { for x in [var.docker_registry_service_name_in] : x => {
      sa_name   = "projects/${var.project_name_in}/serviceAccounts/${google_service_account.docker_registry_admin.email}"
      attribute = "*"
  }}
}