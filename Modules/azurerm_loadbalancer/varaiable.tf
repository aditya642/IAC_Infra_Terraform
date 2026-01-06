variable "loadbalancers" {
  description = "Load balancer configurations"
  type = map(object({
    name                      = string
    location                  = string
    resource_group_name       = string
    sku                       = string
    public_ip_name            = string
    ip_configuration_name     = string
    backend_address_pool_name = string
    healthprobe_name          = string
    healthprobe_port          = number
    healthprobe_protocol      = string
    lbrule_name               = string
    frontend_ip_configurations = list(object({
      name                 = string
      public_ip_address_id = string
    }))

    backend_pools = list(object({
      name = string
    }))

    probes = list(object({
      name     = string
      protocol = string
      port     = number
    }))

    rules = list(object({
      name               = string
      protocol           = string
      frontend_port      = number
      backend_port       = number
      frontend_ip_name   = string
      backend_pool_name  = string
      probe_name         = string
    }))
  }))
}

# variable "loadbalancer" {
#   description = "Load balancer configurations"
#   type = map(object({
#     name                      = string
#     location                  = string
#     resource_group_name       = string
#     sku                       = string
#     public_ip_name            = string
#     ip_configuration_name     = string
#     backend_address_pool_name = string
#     healthprobe_name          = string
#     healthprobe_port          = number
#     healthprobe_protocol      = string
#     lbrule_name               = string
#     frontend_ip_configurations = list(object({
#       name                 = string
#       public_ip_address_id = string
#     }))

#     backend_pools = list(object({
#       name = string
#     }))

#     probes = list(object({
#       name     = string
#       protocol = string
#       port     = number
#     }))

#     rules = list(object({
#       name               = string
#       protocol           = string
#       frontend_port      = number
#       backend_port       = number
#       frontend_ip_name   = string
#       backend_pool_name  = string
#       probe_name         = string
#     }))
#   }))
# }