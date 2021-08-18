# Looking up Organization MOID
data "intersight_organization_organization" "orgID" {
  name = var.organization
}

#### Cluster Profile

resource "intersight_kubernetes_cluster_profile" "intersight_k8s_cluster_profile" {
  description = "Terraform deployed K8s Cluster" 
  name        = var.clusterName
  type        = "instance"
  action      = "Unassign"
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
  cluster_ip_pools {
    moid = intersight_ippool_pool.IPPool.moid
  }
  sys_config {
    moid = intersight_kubernetes_sys_config_policy.kubernetes_sys_config_policy1.moid
  }

}

#### Configure IP Pool

resource "intersight_ippool_pool" "IPPool" {
  name             = "IPPOOL-${var.clusterName}"
  description      = "IP Pool for K8s Cluster ${var.clusterName}"
  assignment_order = "sequential"
  ip_v4_config {
 #   moid        = var.ippool_ip_v4_config
    object_type = "ippool.IpV4Config"
    gateway     = var.gateway
    netmask     = var.netmask
    primary_dns = var.DNSServers
  }
  ip_v4_blocks {
    from = var.IPPoolFromIP
    size = var.IPPoolSize
  }
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.orgID.results.0.moid
  }

}
##### Sysconfig

resource "intersight_kubernetes_sys_config_policy" "kubernetes_sys_config_policy1" {
  description     = "Profile for K8s Cluster ${var.clusterName}"
  name            = "SYSCONFIGPOL-${var.clusterName}"
  dns_servers     = var.primaryDNS
  ntp_servers     = var.primaryDNS
  timezone        = "Europe/Berlin"
  dns_domain_name = var.DNSDomainName
  
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.orgID.results.0.moid
  }
}