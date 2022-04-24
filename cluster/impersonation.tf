resource "google_service_account" "cluster_service_account" {
  provider = google-beta

  account_id   = local.gcp_service_name
  display_name = "GKE service account"
  project    = var.project_name
}

resource "kubernetes_service_account" "main" {

  metadata {
    name      = local.gcp_service_name
    namespace = var.impersonation_namespace
    annotations = {
      "iam.gke.io/gcp-service-account" = google_service_account.cluster_service_account.email
    }
  }
}

module "annotate-sa" {
  source  = "terraform-google-modules/gcloud/google//modules/kubectl-wrapper"
  version = "~> 3.1"

  skip_download               = true
  cluster_name                = var.cluster_name
  cluster_location            = var.region
  project_id                  = var.project_name

  kubectl_create_command  = "kubectl annotate --overwrite sa -n ${var.impersonation_namespace} ${local.gcp_service_name} iam.gke.io/gcp-service-account=${google_service_account.cluster_service_account.email}"
  kubectl_destroy_command = "kubectl annotate sa -n ${var.impersonation_namespace} ${local.gcp_service_name} iam.gke.io/gcp-service-account-"
}


module "gh_oidc" {
  source      = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  project_id  = var.project_name
  pool_id     = var.pool_id
  provider_id = var.provider_id
  sa_mapping = local.service_map
  allowed_audiences = var.allowed_audiences
}
