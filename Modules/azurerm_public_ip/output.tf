output "public_ip_addresses" {
  description = "Output map of created Public IPs"
  value = {
    for k, v in azurerm_public_ip.pip : k => {
      name           = v.name
      ip_address     = v.ip_address
      fqdn           = v.fqdn
      allocation     = v.allocation_method
      sku            = v.sku
      location       = v.location
      resource_group = v.resource_group_name
    }
  }
}