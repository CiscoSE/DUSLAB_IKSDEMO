variable "clusterName" {
  type = string
  description = "Name of the Kubernetes Cluster"
}
variable "apikey" {
  type        = string
  sensitive   = true
  description = "API Key"
}
variable "secretkey" {
  type        = string
  sensitive   = true
  description = "Secret Key or file location"
}
variable "endpoint" {
  type        = string
  description = "API Endpoint URL"
  default     = "https://www.intersight.com"
}
variable "organization" {
  type        = string
  description = "Organization Name"
  default     = "default"
}
variable "ssh_user" {
  type        = string
  description = "SSH Username for node login."
}
variable "ssh_key" {
  type        = string
  description = "SSH Public Key to be used to node login."
}
variable "vc_password" {
  sensitive   = true
  type        = string
  description = "Password of the account to be used with vCenter.  This should be the password for the account used to register vCenter with Intersight."
}
variable "tags" {
  type    = list(map(string))
  default = []
}
variable "loadBalancerCount" {
  type = string
  default = 1
}

#### IP Pool Variables

variable "IPPoolFromIP" {
  type        = string
}

variable "IPPoolSize" {
  type        = string
}
variable "gateway" {
  type        = string
}
variable "netmask" {
  type        = string
}
variable "primaryDNS" {
  type        = string
}


#### Sysconfig Variables

variable "DNSDomainName" {
  type = string
}

variable "DNSServers" {
    type = list(string)
}

variable "NTPServers" {
    type = list(string)
}


#### Network Config Variables
variable "cniType" {
  type = string
}

variable "podNetworkCidr" {
  type = string
}

variable "serviceNetworkCidr" {
  type = string
}