provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = "https://intersight.com"
}
####

module "terraform-intersight-iks" {
    source = "./modules/terraform-intersight-iks"
    apikey = var.apikey
    secretkey = var.secretkey
    vc_password = var.vc_password
    ssh_user = var.ssh_user
    ssh_key = var.ssh_key
    organization = var.organization

}


