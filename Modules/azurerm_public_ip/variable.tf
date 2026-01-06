variable "pip" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string
    sku                 = optional(string, "Standard")
    sku_tier            = optional(string, "Regional")
    tags                = optional(map(string))
  }))
}
