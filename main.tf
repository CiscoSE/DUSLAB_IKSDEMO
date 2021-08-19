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
  ### Worker Node Group
    workerDesiredSize = var.workerDesiredSize
    workerMaxSize = var.workerMaxSize
  ### K8S Version 
    k8sVersion = var.k8sVersion
  ### VC Infra Config 
    vcName = var.vcName
    vcCluster = var.vcCluster
    vcDataStore = var.vcDataStore
    vcResourcePool = var.vcResourcePool
    vcPortGroup = var.vcPortGroup
    vcPassword = var.vcPassword






}


