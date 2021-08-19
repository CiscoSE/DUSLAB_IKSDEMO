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
  ### Management Config
  management_config {
    load_balancer_count = var.loadBalancerCount
    ssh_keys = [
      var.ssh_key
    ]
    ssh_user = var.ssh_user
  }
  ### IP Pool Association
  cluster_ip_pools {
    moid = intersight_ippool_pool.IPPool.moid
  }
  ### Sysconfig Association
  sys_config {
    moid = intersight_kubernetes_sys_config_policy.kubernetes_sys_config_policy1.moid
  }
  ### Networkconfig Association
  net_config{
     moid = intersight_kubernetes_network_policy.kubernetes_network_policy1.moid
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
    primary_dns = var.primaryDNS
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
##### Sysconfig Policy

resource "intersight_kubernetes_sys_config_policy" "kubernetes_sys_config_policy1" {
  description     = "Profile for K8s Cluster ${var.clusterName}"
  name            = "SYSCONFIGPOL-${var.clusterName}"
  dns_servers     = var.DNSServers
  ntp_servers     = var.NTPServers
  timezone        = "Europe/Berlin"
  dns_domain_name = var.DNSDomainName
  
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.orgID.results.0.moid
  }
}


##### Network Policy


resource "intersight_kubernetes_network_policy" "kubernetes_network_policy1" {
  description = "Profile for K8s Cluster ${var.clusterName}"
  name        = "NETWORKPOL-${var.clusterName}"
  cni_type    = var.cniType
  pod_network_cidr = var.podNetworkCidr
  service_cidr = var.serviceNetworkCidr
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.orgID.results.0.moid
  }
}


### Cluster Node Profile
resource "intersight_kubernetes_node_group_profile" "intersight_k8s_node_group_profile_controlplane" {

  name        = "NODEGROUPPROF-${var.clusterName}"
  description = "NodeGroupProfile for K8s Cluster ${var.clusterName}"
  node_type   = "ControlPlane"
  desiredsize = var.controlPlaneDesiredSize
  maxsize     = var.controlPlaneMaxSize
  ip_pools {
    object_type = "ippool.Pool"
    moid        = intersight_ippool_pool.IPPool.moid
  }
  kubernetes_version {
    object_type = "kubernetes.VersionPolicy"
    moid        = intersight_kubernetes_version_policy.k8s_version_policy.moid
  }

  cluster_profile {
    object_type = "kubernetes.ClusterProfile"
    moid        = intersight_kubernetes_cluster_profile.intersight_k8s_cluster_profile.moid
  }

  infra_config_policy {
    object_type = "kubernetes.kubernetes.EsxiVirtualMachineInfraConfig"
    moid = data.intersight_kubernetes_virtual_machine_infra_config_policy.intersight_k8s_virtual_machine_infra_config_policy.moid
  }

}

#### Version Policy
data "intersight_kubernetes_version" "kubernetes_version1" {

  kubernetes_version = var.k8sVersion

}

resource "intersight_kubernetes_version_policy" "k8s_version_policy" {

  name = "K8SVERSION-${var.k8sVersion}"
  nr_version {

    object_type = "kubernetes.Version"
    moid        = data.intersight_kubernetes_version.kubernetes_version1.results.0.moid

  }


  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.orgID.results.0.moid
  }
}

#### Virtual Machine Infra Config Policy

# Looking up Asset Target
data "intersight_asset_target" "intersight_asset_target1" {
  name = var.vcName
}

resource "intersight_kubernetes_virtual_machine_infra_config_policy" "intersight_k8s_virtual_machine_infra_config_policy" {
  name        = "VMINFRACONFIGPOL-${var.clusterName}"
  description = "VM Virtual Infra Config Policy for K8s Cluster ${var.clusterName}"
  vm_config {
    object_type = "kubernetes.EsxiVirtualMachineInfraConfig"
    interfaces  = var.vcPortGroup
    additional_properties = jsonencode({
      Datastore    = var.vcDataStore
      Cluster      = var.vcCluster
      Passphrase   = var.vcPassword
      ResourcePool = var.vcResourcePool
    })
  }
  target {
    object_type = "asset.DeviceRegistration"
    moid        = data.intersight_asset_target.intersight_asset_target1.results.0.registered_device[0].moid
  }

  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.orgID.results.0.moid
  }
}