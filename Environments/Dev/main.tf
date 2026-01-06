module "resource_group" {
  source   = "../../Modules/azurerm_resource_group"
  rg_names = var.rg_names
}

module "virtual_network" {
  source = "../../Modules/azurerm_networking"
  vnet   = var.vnet
}

module "pip" {
  depends_on = [module.resource_group]
  source     = "../../Modules/azurerm_public_ip"
  pip        = var.pip
}

module "key_vault" {
  source    = "../../Modules/azurerm_key_vault"
  key_vault = var.key_vault
}

module "vm" {
  depends_on = [module.pip, module.virtual_network, module.key_vault]
  source     = "../../Modules/azurerm_compute"
  vm         = var.vm
}

module "sqlserver" {
  depends_on = [module.resource_group]
  source     = "../../Modules/azurerm_SQL_server"
  msqlserver = var.msqlserver
}

module "sqldb" {
  depends_on = [module.sqlserver]
  source     = "../../Modules/azurerm_SQL_database"
  sqldb      = var.sqldb
}

module "loadbalancers" {
  source = "../../Modules/azurerm_loadbalancer"
  loadbalancers = var.loadbalancers
}