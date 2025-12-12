variable "var_child_vnet" {
  description = "Map of virtual network configurations"
  type = map(object({
    # Virtual Network resource block arguments
    vnet_name                      = string
    location                       = string
    resource_group_name            = string
    address_space                  = optional(list(string))
    dns_servers                    = optional(list(string))
    bgp_community                  = optional(string)
    vnet_edge_zone                 = optional(string)
    flow_timeout_in_minutes        = optional(number)
    private_endpoint_vnet_policies = optional(string)
    vnet_tags                      = optional(map(string))

    # Optional: DDoS Protection Plan block
    ddos_protection_plan = optional(object({
      id     = string
      enable = bool
    }))

    # Optional: Encryption block
    encryption = optional(object({
      enforcement = string
    }))

    # Optional: IP Address Pool block
    ip_address_pool = optional(map(object({
      id                     = string
      number_of_ip_addresses = string
    })))
  }))
}


variable "var_child_subnet" {
  description = "Subnet definitions for each VNet"
  type = map(object({
    subnet_name         = string
    resource_group_name = string
    virtual_network_name            = string # Links this subnet to the VNet map key

    address_prefixes    = optional(list(string))
    ip_address_pool = optional(object({
      id                     = string
      number_of_ip_addresses = string
    }))
    default_outbound_access_enabled               = optional(bool, true)
    private_endpoint_network_policies             = optional(string)
    private_link_service_network_policies_enabled = optional(bool, true)
    sharing_scope                                 = optional(string)
    service_endpoints                             = optional(list(string))
    service_endpoint_policy_ids                   = optional(list(string))
    
    delegation = optional(list(object({
      name = string
      service_delegation = object({
        name    = string
        actions = optional(list(string))
      })
    })))
  }))
}
