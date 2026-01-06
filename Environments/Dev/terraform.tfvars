rg_names = {
  "rg1" = {
    name       = "rg_todo"
    location   = "centralIndia"
    managed_by = "Terraform"
    tags = {
      Environment = "dev"
      Project     = "todoapp_aditya"
    }
  }
}

nic = {
  "nic1" = {
    name                = "nsg-todoapp"
    location            = "centralIndia"
    resource_group_name = "rg_todo"
    tags = {
      Environment = "dev"
      Project     = "todoapp_aditya"
    }
  }
}

vnet = {
  "vnet1" = {
    name                = "vnet-todoapp"
    location            = "centralIndia"
    resource_group_name = "rg_todo"
    address_space       = ["10.0.0.0/16"]
    dns_servers         = ["10.0.0.1"]
    tags = {
      Environment = "dev"
      Project     = "todoapp_aditya"
    }
    subnets = {
      "subnet1" = {
        name             = "frontend-subnet"
        address_prefixes = ["10.0.1.0/24"]
      }
      "subnet2" = {
        name             = "backend-subnet"
        address_prefixes = ["10.0.2.0/24"]
      }
    }
  }
}

pip = {
  "pip1" = {
    name                = "frontend-pip"
    resource_group_name = "rg_todo"
    location            = "centralIndia"
    allocation_method   = "Static"
    sku                 = "Standard"
    tags = {
      Environment = "dev"
      Project     = "todoapp_aditya"
    }
  }

  pip2 = {
    name                = "backend-pip"
    resource_group_name = "rg_todo"
    location            = "centralIndia"
    allocation_method   = "Static"
    sku                 = "Standard"
    tags = {
      Environment = "dev"
      Project     = "todoapp_aditya"
    }
  }
}

key_vault = {
  "kv1" = {
    name                        = "kv-todoapp"
    location                    = "centralIndia"
    resource_group_name         = "rg_todo"
    enabled_for_disk_encryption = false
    soft_delete_retention_days  = 7
    purge_protection_enabled    = true

    sku_name = "standard"
    tags = {
      Environment = "dev"
      Project     = "todoapp_aditya"
    }
  }

}

vm = {
  "vm1" = {
    nic_name            = "nic-frontend"
    name                = "frontend-vm"
    resource_group_name = "rg_todo"
    location            = "centralIndia"
    vnet_name           = "vnet-todoapp"
    subnet_name         = "frontend-subnet"
    public_ip_name      = "frontend-pip"
    size                = "Standard_F2"
    admin_username      = "adminuser"
    publisher           = "Canonical"
    offer               = "0001-com-ubuntu-server-jammy"
    sku                 = "22_04-lts"
    version             = "latest"
    key_vault_name      = "kv-todoapp"
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
    tags = {
      Environment = "dev"
      Project     = "todoapp_aditya"
    }
  }

  "vm2" = {
    nic_name            = "nic-backend"
    name                = "back-vm"
    resource_group_name = "rg_todo"
    location            = "centralIndia"
    vnet_name           = "vnet-todoapp"
    subnet_name         = "backend-subnet"
    public_ip_name      = "backend-pip"
    size                = "Standard_F2"
    admin_username      = "adminuser"
    publisher           = "Canonical"
    offer               = "0001-com-ubuntu-server-jammy"
    sku                 = "22_04-lts"
    version             = "latest"
    key_vault_name      = "kv-todoapp"
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
    tags = {
      Environment = "dev"
      Project     = "todoapp_aditya"
    }
  }

}

msqlserver = {
  "sql1" = {
    name                = "sqlserver-todoapp"
    resource_group_name = "rg_todo"
    location            = "centralIndia"
    tags = {
      Environment = "dev"
      Project     = "todoapp_aditya"
    }
  }
}

sqldb = {
  "sqldb1" = {
    name                = "sqldb-todoapp"
    server_name         = "sqlserver-todoapp"
    resource_group_name = "rg_todo"
    collation           = "SQL_Latin1_General_CP1_CI_AS"
    license_type        = "LicenseIncluded"
    tags = {
      Environment = "dev"
      Project     = "todoapp_aditya"
    }
  }
}

loadbalancers = {
  "lb1" = {
    name                      = "lb-todoapp"
    location                  = "centralIndia"
    resource_group_name       = "rg_todo"
    sku                       = "Standard"
    public_ip_name            = "frontend-ip-config-pip"
    ip_configuration_name     = "frontend-ip-config"
    backend_address_pool_name = "todoapp-backend-pool"
    healthprobe_name          = "todoapp-health-probe"
    healthprobe_port          = 80
    healthprobe_protocol      = "Http"
    lbrule_name               = "todoapp-lb-rule"
 }
}

# loadbalancer = {
#     lb1 = {
#       name                = "todo-lb"
#       location            = "eastus"
#       resource_group_name = "rg-todo"
#       sku                 = "Standard"

#       frontend_ip_configurations = [
#         {
#           name                 = "public-fe"
#           public_ip_address_id = azurerm_public_ip.pip1.id
#         }
#       ]

#       backend_pools = [
#         { name = "todo-bepool" }
#       ]

#       probes = [
#         {
#           name     = "http-probe"
#           protocol = "Tcp"
#           port     = 80
#         }
#       ]

#       rules = [
#         {
#           name              = "http-rule"
#           protocol          = "Tcp"
#           frontend_port     = 80
#           backend_port      = 80
#           frontend_ip_name  = "public-fe"
#           backend_pool_name = "todo-bepool"
#           probe_name        = "http-probe"
#         }
#       ]
#     }
#   }
