variable "msqlserver" {
  type = map(object({
    name                         = string
    resource_group_name          = string
    location                     = string
    tags                         = optional(map(string))
  }))
}