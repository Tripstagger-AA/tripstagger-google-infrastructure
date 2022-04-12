output "workload_identity_pool_provider_id" {
  value = "${module.gh_oidc.provider_name}"
}