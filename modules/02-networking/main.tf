# ========================
# Virtual Network Resource
# ========================
resource "azurerm_virtual_network" "child_virtual_network" {
  for_each = var.var_child_vnet

  name                = each.value.vnet_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  # One of address_space or ip_address_pool must be defined
  address_space                  = try(each.value.address_space, null)
  dns_servers                    = try(each.value.dns_servers, null)
  bgp_community                  = try(each.value.bgp_community, null)
  edge_zone                      = try(each.value.edge_zone, null)
  flow_timeout_in_minutes        = try(each.value.flow_timeout_in_minutes, null)
  private_endpoint_vnet_policies = try(each.value.private_endpoint_vnet_policies, null)
  tags                           = try(each.value.vnet_tags, {})

  # Optional: DDoS Protection Plan block
  dynamic "ddos_protection_plan" {
    for_each = try(each.value.ddos_protection_plan, null) != null ? [each.value.ddos_protection_plan] : []
    content {
      id     = ddos_protection_plan.value.id
      enable = ddos_protection_plan.value.enable
    }
  }

  # Optional: Encryption block
  dynamic "encryption" {
    for_each = try(each.value.encryption, null) != null ? [each.value.encryption] : []
    content {
      enforcement = encryption.value.enforcement
    }
  }

  # Optional: IP Address Pool block
  dynamic "ip_address_pool" {
    for_each = try(each.value.ip_address_pool, null) != null ? each.value.ip_address_pool : {}
    content {
      id                     = ip_address_pool.value.id
      number_of_ip_addresses = ip_address_pool.value.number_of_ip_addresses
    }
  }
}

# ===================
# Subnet Resource
# ===================
resource "azurerm_subnet" "child_subnet" {
  depends_on = [ azurerm_virtual_network.child_virtual_network ]
  
  for_each = var.var_child_subnet

  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  # virtual_network_name = azurerm_virtual_network.child_virtual_network[each.value.vnet_key].vnet_name

  # Either address_prefixes or ip_address_pool must be defined
  address_prefixes = try(each.value.address_prefixes, null)

  default_outbound_access_enabled               = try(each.value.default_outbound_access_enabled, true)
  private_endpoint_network_policies             = try(each.value.private_endpoint_network_policies, null)
  private_link_service_network_policies_enabled = try(each.value.private_link_service_network_policies_enabled, true)
  # sharing_scope                                 = try(each.value.sharing_scope, null)
  service_endpoints                             = try(each.value.service_endpoints, null)
  service_endpoint_policy_ids                   = try(each.value.service_endpoint_policy_ids, null)

  # Optional: IP Address Pool block
  dynamic "ip_address_pool" {
    for_each = try(each.value.ip_address_pool, null) != null ? [each.value.ip_address_pool] : []
    content {
      id                     = ip_address_pool.value.id
      number_of_ip_addresses = ip_address_pool.value.number_of_ip_addresses
    }
  }

  # Optional: Delegation block
  dynamic "delegation" {
    for_each = try(each.value.delegation, null) != null ? [each.value.delegation] : []
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = try(delegation.value.service_delegation.actions, null)
      }
    }
  }
}
