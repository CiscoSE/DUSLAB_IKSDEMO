provider "CiscoDevNet/intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}
####

module "terraform-intersight-iks" {
    source = "./modules/terraform-intersight-iks"
    apikey = "${var.apikey}"
    secretkey = "${var.secretkey}"
    vc_password = "${var.vc_password}"
    ssh_user = "${var.ssh_user}"
    ssh_key = "${var.ssh_key}"

}


