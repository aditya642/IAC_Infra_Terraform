variable "rg_names" {
  type = map(object({
    name       = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
  }))
}

variable "nic" {}
variable "vnet" {}
variable "pip" {}
variable "vm" {}
variable "key_vault" {}
variable "msqlserver" {}
variable "sqldb" {}
variable "loadbalancers" {}
# variable "loadbalancer" {}