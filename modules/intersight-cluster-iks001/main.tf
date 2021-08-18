# Looking up Organization MOID
data "intersight_organization_organization" "orgID" {
  name = var.organization
}

resource "intersight_kubernetes_cluster_profile" "intersight_k8s_cluster_profile" {
  description = "Terraform deployed K8s Cluster" 
  name        = var.clusterName
  type        = "instance"
  action      = "Deploy"
  config_context {
    control_action = "Deploy"
    error_state    = "Pre-config-error"
  }
  managed_mode = "Managed"
  status       = "Deploying"
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.orgID.results.0.moid
  }

}

