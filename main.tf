provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = "https://5c5aff1a68783235342beca8.intersight.com"
}
####

module "terraform-intersight-iks" {
    source = "./modules/terraform-intersight-iks"
    apikey = "${var.apikey}"
    secretkey = "${var.secretkey}"
    vc_password = "${var.vc_password}"
    ssh_user = "${var.ssh_user}"
    ssh_key = "${var.ssh_key}"
    organization = "${var.organization}"

}


