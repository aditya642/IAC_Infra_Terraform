variable "sqldb" {
  type = map(object({
    name                = string
    server_name         = string
    resource_group_name = string
    collation           = string
    license_type        = string
    tags                = optional(map(string))
  }))
}