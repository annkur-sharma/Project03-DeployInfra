variable "var_child_nsg" {
  description = "Map of Network Security Groups to create with optional security rules."
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    tags                = optional(map(string))
    
    security_rules = optional(list(object({
      name                                       = string
      description                                = optional(string)
      protocol                                   = string
      source_port_range                          = optional(string)
      source_port_ranges                         = optional(list(string))
      destination_port_range                     = optional(string)
      destination_port_ranges                    = optional(list(string))
      source_address_prefix                      = optional(string)
      source_address_prefixes                    = optional(list(string))
      destination_address_prefix                 = optional(string)
      destination_address_prefixes               = optional(list(string))
      source_application_security_group_ids      = optional(list(string))
      destination_application_security_group_ids = optional(list(string))
      access                                     = string
      priority                                   = number
      direction                                  = string
    })))
  }))
}