locals {
  gcp_service_name = "${var.cluster_name}service"

  service_map = { for x in [local.gcp_service_name ] : x => {
      sa_name   = "projects/${var.project_name}/serviceAccounts/${google_service_account.cluster_service_account.email }"
      attribute = "*"
  }}
}