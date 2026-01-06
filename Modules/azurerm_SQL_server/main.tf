resource "azurerm_mssql_server" "msqlserver" {
  for_each                     = var.msqlserver
  name                         = each.value.name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = "12.0"
  administrator_login          = "missadministrator"
  administrator_login_password = "P@ssw0rd1234"
  minimum_tls_version          = "1.2"

  azuread_administrator {
    login_username = "AzureAD Admin"
    object_id      = "00000000-0000-0000-0000-000000000000"
  }

  tags = each.value.tags
}
