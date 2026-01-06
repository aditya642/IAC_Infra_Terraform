output "loadbalancer_ids" {
  value = {
    for k, lb in azurerm_lb.this : k => lb.id
  }
}

output "backend_pool_ids" {
  value = {
    for k, pool in azurerm_lb_backend_address_pool.this : k => pool.id
  }
}