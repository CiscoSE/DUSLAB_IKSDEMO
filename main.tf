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
  ### IP Pool Config  
    gateway = var.gateway
    netmask = var.netmask
    primaryDNS = var.primaryDNS
    IPPoolFromIP = var.IPPoolFromIP
    IPPoolSize = var.IPPoolSize
    DNSDomainName = var.DNSDomainName


}


