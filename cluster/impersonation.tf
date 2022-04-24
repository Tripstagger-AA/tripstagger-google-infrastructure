provider "kubernetes" {
    host                   = "${google_container_cluster.default.endpoint}"
    token                  = "${data.google_client_config.current.access_token}"

    client_certificate     = "${base64decode(google_container_cluster.default.master_auth.0.client_certificate)}"
    client_key             = "${base64decode(google_container_cluster.default.master_auth.0.client_key)}"
    cluster_ca_certificate = "${base64decode(google_container_cluster.default.master_auth.0.cluster_ca_certificate)}"
}


resource "kubernetes_namespace" "apps" {

  depends_on = [time_sleep.wait_for_kube]
  metadata {
    name = var.impersonation_namespace
  }
}

resource "google_service_account" "cluster_service_account" {
  provider = google-beta

  account_id   = local.gcp_service_name
  display_name = "GKE service account"
  project    = var.project_name
}

resource "kubernetes_service_account" "main" {
  depends_on = [kubernetes_namespace.apps]
  metadata {
    name      = local.gcp_service_name
    namespace = var.impersonation_namespace
    annotations = {
      "iam.gke.io/gcp-service-account" = google_service_account.cluster_service_account.email
    }
  }
}

module "gh_oidc" {
  source      = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  project_id  = var.project_name
  pool_id     = var.pool_id
  provider_id = var.provider_id
  sa_mapping = local.service_map
  allowed_audiences = var.allowed_audiences
}
