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

#### Control Plane Node Profile

variable "controlPlaneDesiredSize" {
  type= string
}

variable "controlPlaneMaxSize" {
  type= string
}


#### Worker Node Profile

variable "workerDesiredSize" {
  type= string
}

variable "workerMaxSize" {
  type= string
}
variable "k8sVersion" {
  type        = string
  description = "Version of the Kubernetes cluster"
}

#### VM Infra Config Policy Var
variable "vcName" {
  type= string
}

variable "vcPortGroup" {
  type= list(string)
}

variable "vcDataStore" {
  type= string
}

variable "vcCluster" {
  type= string
}

variable "vcPassword" {
  type= string
  sensitive = true
}

variable "vcResourcePool" {
  type= string
  sensitive = true
}
#### Addon Policy
