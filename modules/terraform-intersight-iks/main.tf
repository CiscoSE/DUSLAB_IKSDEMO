module "terraform-intersight-iks" {
  
  cluster_name = "iksITS001"
  cluster_action   = "Deploy"
  vc_target_name   = "dcdus-co-vcsa01.cisco.com"
  vc_portgroup     = ["sgplayground|iks_AP|iksits001_EPG"]
  vc_datastore     = "ISCSI-NETAPP001"
  vc_cluster       = "ACI-Cluster01"
  vc_resource_pool = "iks-its001"
  vc_password      = var.vc_password

  # IP Pool Information
  ip_starting_address = "10.1.179.10"
  ip_pool_size        = "40"
  ip_netmask          = "255.255.255.0"
  ip_gateway          = "10.1.179.1"
  ntp_servers         = ["10.1.11.11"]
  dns_servers         = ["10.1.11.11"]
#
  addons_list = [{
    addon_policy_name = "dashboard"
    addon             = "kubernetes-dashboard"
    description       = "K8s Dashboard Policy"
    upgrade_strategy  = "AlwaysReinstall"
    install_strategy  = "InstallOnly"
    },
    {
      addon_policy_name = "monitor"
      addon             = "ccp-monitor"
      description       = "Grafana Policy"
      upgrade_strategy  = "AlwaysReinstall"
      install_strategy  = "InstallOnly"
    }
  ]
  # Network Configuration Settings
  # pod_cidr = "100.65.0.0/16"
  # service_cidr = "100.64.0.0/24"
  # cni = "Calico"
  domain_name = "dc.dus.lab"
  timezone    = "Europe/Berlin"


  # Trusted Registry Entry
  # unsigned_registries = ["10.101.128.128"]
  # root_ca_registries  = [""]

  # Cluster information
  ssh_user       = var.ssh_user
  ssh_key        = var.ssh_key
  worker_size    = "medium"
  worker_count   = 4
  master_count   = 3
  load_balancers = 1
  # Organization and Tag
  organization = "default"
  #  tags         = var.tags
}