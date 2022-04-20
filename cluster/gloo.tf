data "google_client_config" "current" {}


provider "helm" {

  kubernetes {
    host                   = "${google_container_cluster.default.endpoint}"
    token                  = "${data.google_client_config.current.access_token}"

    client_certificate     = "${base64decode(google_container_cluster.default.master_auth.0.client_certificate)}"
    client_key             = "${base64decode(google_container_cluster.default.master_auth.0.client_key)}"
    cluster_ca_certificate = "${base64decode(google_container_cluster.default.master_auth.0.cluster_ca_certificate)}"
  }
}

resource "helm_release" "gloo" {
  name  = "gloo"
  repository =  "https://storage.googleapis.com/solo-public-helm"
  chart = "gloo"
  namespace = "gloo-system"
  create_namespace = true

  values = [<<EOF
gatewayProxies:
  gatewayProxy:
    service:
      type: ClusterIP
      extraAnnotations:
        cloud.google.com/neg: '{"exposed_ports": {"80":{"name": "ingressgateway"}}}'
    kind:
      deployment:
        replicas: 2
    antiAffinity: true
EOF
  ]

  depends_on = [
    time_sleep.wait_for_kube,
  ]
}