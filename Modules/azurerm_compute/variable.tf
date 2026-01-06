variable "vm" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    size                = string
    admin_username      = string
    publisher           = string
    offer               = string
    sku                 = string
    version             = string
    public_ip_name      = string
    nic_name            = string
    subnet_name         = string
    key_vault_name      = string
    source_image_reference = map(string)
    vnet_name           = string
    tags                = optional(map(string))
  }))
}
