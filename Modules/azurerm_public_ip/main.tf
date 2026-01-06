resource "azurerm_public_ip" "pip" {
  for_each            = var.pip
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = each.value.allocation_method
  sku                 = lookup(each.value, "sku", "Standard")
  sku_tier            = lookup(each.value, "sku_tier", "Regional")
  tags                = each.value.tags

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      tags["last_modified"], # example of dynamic tag ignore
    ]
   }
 }  