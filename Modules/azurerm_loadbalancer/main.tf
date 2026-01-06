resource "azurerm_lb" "Todo_LoadBalancer" {
  for_each            = var.loadbalancers
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku

  frontend_ip_configuration {
    name                 = each.value.ip_configuration_name
    public_ip_address_id = data.azurerm_public_ip.pip1[each.key].id
  }
}

resource "azurerm_lb_backend_address_pool" "bkndpool" {
  depends_on = [ azurerm_lb.Todo_LoadBalancer ]
  for_each        = var.loadbalancers
  loadbalancer_id = azurerm_lb.Todo_LoadBalancer[each.key].id
  name            = each.value.backend_address_pool_name
}

resource "azurerm_lb_probe" "healthprobe" {
  depends_on = [ azurerm_lb.Todo_LoadBalancer ]
  for_each        = var.loadbalancers
  loadbalancer_id = azurerm_lb.Todo_LoadBalancer[each.key].id
  name            = each.value.healthprobe_name
  port            = each.value.healthprobe_port
  protocol        = each.value.healthprobe_protocol
}


resource "azurerm_lb_rule" "lbrule" {
  depends_on = [ azurerm_lb.Todo_LoadBalancer, azurerm_lb_backend_address_pool.bkndpool, azurerm_lb_probe.healthprobe ]
  for_each                       = var.loadbalancers
  name                           = each.value.lbrule_name
  loadbalancer_id                = azurerm_lb.Todo_LoadBalancer[each.key].id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = each.value.ip_configuration_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bkndpool[each.key].id]
  probe_id                       = azurerm_lb_probe.healthprobe[each.key].id
}
#============================== Load Balancer ============================#
# resource "azurerm_lb" "lb" {
#   for_each            = var.loadbalancer
#   name                = each.value.name
#   location            = each.value.location
#   resource_group_name = each.value.resource_group_name
#   sku                 = each.value.sku

#   dynamic "frontend_ip_configuration" {
#     for_each = each.value.frontend_ip_configurations
#     content {
#       name                 = frontend_ip_configuration.value.name
#       public_ip_address_id = frontend_ip_configuration.value.public_ip_address_id
#     }
#   }
# }

# resource "azurerm_lb_backend_address_pool" "bap" {
#   for_each = merge([
#     for lb_key, lb in var.loadbalancer : {
#       for pool in lb.backend_pools :
#       "${lb_key}-${pool.name}" => {
#         lb_key = lb_key
#         name   = pool.name
#       }
#     }
#   ]...)

#   name            = each.value.name
#   loadbalancer_id = azurerm_lb.lb[each.value.lb_key].id
# }

# resource "azurerm_lb_probe" "healthprobe_name" {
#   for_each = merge([
#     for lb_key, lb in var.loadbalancer : {
#       for probe in lb.probes :
#       "${lb_key}-${probe.name}" => {
#         lb_key = lb_key
#         probe  = probe
#       }
#     }
#   ]...)

#   name            = each.value.probe.name
#   protocol        = each.value.probe.protocol
#   port            = each.value.probe.port
#   loadbalancer_id = azurerm_lb.lb[each.value.lb_key].id
# }

# resource "azurerm_lb_rule" "lbrule" {
#   for_each = merge([
#     for lb_key, lb in var.loadbalancer : {
#       for rule in lb.rules :
#       "${lb_key}-${rule.name}" => {
#         lb_key = lb_key
#         rule   = rule
#       }
#     }
#   ]...)

#   name                           = each.value.rule.name
#   protocol                       = each.value.rule.protocol
#   frontend_port                  = each.value.rule.frontend_port
#   backend_port                   = each.value.rule.backend_port
#   frontend_ip_configuration_name = each.value.rule.frontend_ip_name

#   loadbalancer_id = azurerm_lb.this[each.value.lb_key].id

#   backend_address_pool_ids = [
#     azurerm_lb_backend_address_pool.this[
#       "${each.value.lb_key}-${each.value.rule.backend_pool_name}"
#     ].id
#   ]

#   probe_id = azurerm_lb_probe.this[
#     "${each.value.lb_key}-${each.value.rule.probe_name}"
#   ].id
# }