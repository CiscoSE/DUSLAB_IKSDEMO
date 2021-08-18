provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = "https://intersight.com"
}
####

module "intersight-cluster-iks001" {
    source = "./modules/intersight-cluster-iks001"
    apikey = var.apikey
    secretkey = var.secretkey
    vc_password = var.vc_password
    ssh_user = var.ssh_user
    ssh_key = var.ssh_key
    organization = var.organization
  ### Cluster Config
    clusterName = var.clusterName
    loadBalancerCount = var.loadBalancerCount
  ### IP Pool Config  
    gateway = var.gateway
    netmask = var.netmask
    primaryDNS = var.primaryDNS
    IPPoolFromIP = var.IPPoolFromIP
    IPPoolSize = var.IPPoolSize
  ### Sysconfig Config 
    DNSDomainName = var.DNSDomainName
    DNSServers = var.DNSServers
    NTPServers = var.NTPServers
  ### Network Config
    cniType = var.cniType
    podNetworkCidr = var.podNetworkCidr
    serviceNetworkCidr = var.serviceNetworkCidr
  ### Control Plane Node Group  
    controlPlaneDesiredSize = var.controlPlaneDesiredSize
    controlPlaneMaxSize = var.controlPlaneMaxSize
    k8s_version = var.k8s_version




}


