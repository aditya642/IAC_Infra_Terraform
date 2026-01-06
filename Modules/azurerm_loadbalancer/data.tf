data "azurerm_public_ip" "pip1" {
  for_each            = var.loadbalancers
  name                = each.value.public_ip_name
  resource_group_name = each.value.resource_group_name
}
