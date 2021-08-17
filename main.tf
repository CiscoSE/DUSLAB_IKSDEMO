provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}
####

module "iks" {
    source = "./modules/iks"
}


