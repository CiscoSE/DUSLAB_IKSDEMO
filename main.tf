provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}
####

module "iks_deploy" {
    source = "./modules/iks_deploy"
}


