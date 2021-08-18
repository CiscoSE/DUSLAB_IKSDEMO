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
    clusterName = var.clusterName

}


