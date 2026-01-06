data "azurerm_key_vault" "kv" {
  for_each            = var.vm
  name                = each.value.key_vault_name
  resource_group_name = each.value.resource_group_name

}

data "azurerm_key_vault_secret" "vm_username" {
  for_each     = var.vm
  name         = "vm-admin-username"
  key_vault_id = data.azurerm_key_vault.kv[each.key].id

}

data "azurerm_key_vault_secret" "vm_password" {
  for_each     = var.vm
  name         = "vm-admin-password"
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}

data "azurerm_subnet" "sub" {
  for_each             = var.vm
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name

}

data "azurerm_public_ip" "pip" {
  for_each            = var.vm
  name                = each.value.public_ip_name
  resource_group_name = each.value.resource_group_name

}

resource "azurerm_network_interface" "nic" {
  for_each            = var.vm
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tags                = each.value.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.sub[each.key].id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = data.azurerm_public_ip.pip[each.key].id
  }

}
resource "azurerm_linux_virtual_machine" "vm" {
  for_each                        = var.vm
  name                            = each.value.name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  disable_password_authentication = false
  network_interface_ids           = data.azurerm_public_ip.pip[each.key].id != null ? [azurerm_network_interface.nic[each.key].id] : []
  admin_password                  = data.azurerm_key_vault_secret.vm_password[each.key].value
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }

  custom_data = base64encode(<<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    systemctl enable nginx
    systemctl start nginx
  EOF
  )
}
