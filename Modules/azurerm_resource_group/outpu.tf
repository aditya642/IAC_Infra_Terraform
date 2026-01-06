output "rg_ids" {
  value = { for k, v in azurerm_resource_group.rg : k => v.id }
}