data "azurerm_mssql_server" "msqlserver" {
    for_each = var.sqldb
  name                = each.value.server_name
  resource_group_name = each.value.resource_group_name
  
}

resource "azurerm_mssql_database" "sqldb" {
    for_each = var.sqldb
  name         = each.value.name
  server_id    = data.azurerm_mssql_server.msqlserver[each.key].id
  collation    = each.value.collation
  license_type = each.value.license_type
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"

  tags = each.value.tags

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}