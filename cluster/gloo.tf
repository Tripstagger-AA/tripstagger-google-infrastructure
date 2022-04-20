data "google_client_config" "current" {}

resource "kubernetes_service_account" "helm_account" {
  depends_on = [
    google_container_cluster.default,
  ]
  metadata {
    name      = "${var.helm_account_name}"
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role_binding" "helm_role_binding" {
  metadata {
    name = "${kubernetes_service_account.helm_account.metadata.0.name}"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    api_group = ""
    kind      = "ServiceAccount"
    name      = "${kubernetes_service_account.helm_account.metadata.0.name}"
    namespace = "kube-system"
  }
  provisioner "local-exec" {
    command = "sleep 15"
  }
}

provider "helm" {
  service_account = "${kubernetes_service_account.helm_account.metadata.0.name}"
  tiller_image = "gcr.io/kubernetes-helm/tiller:${var.helm_version}"
  #install_tiller = false # Temporary

  kubernetes {
    host                   = "${google_container_cluster.default.endpoint}"
    token                  = "${data.google_client_config.current.access_token}"

    client_certificate     = "${base64decode(google_container_cluster.default.master_auth.0.client_certificate)}"
    client_key             = "${base64decode(google_container_cluster.default.master_auth.0.client_key)}"
    cluster_ca_certificate = "${base64decode(google_container_cluster.default.master_auth.0.cluster_ca_certificate)}"
  }
}