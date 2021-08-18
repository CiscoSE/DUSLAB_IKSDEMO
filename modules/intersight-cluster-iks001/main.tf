
resource "intersight_kubernetes_cluster_profile" "intersight_k8s_cluster_profile" {
  description = "Terraform deployed K8s Cluster" 
  name        = var.ClusterName
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
    moid        = var.organization
  }
  workflow_info {
    object_type = "workflow.WorkflowInfo"
    moid        = var.workflow_workflow_info
  }
}

