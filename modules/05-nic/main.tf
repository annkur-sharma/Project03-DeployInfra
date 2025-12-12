# ==================================
# Network Interface (NIC) Resource(s)
# ==================================
resource "azurerm_network_interface" "child_nic" {
  for_each = var.var_child_nic

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  auxiliary_mode                 = try(each.value.auxiliary_mode, null)
  auxiliary_sku                  = try(each.value.auxiliary_sku, null)
  dns_servers                    = try(each.value.dns_servers, null)
  edge_zone                      = try(each.value.edge_zone, null)
  ip_forwarding_enabled          = try(each.value.ip_forwarding_enabled, false)
  accelerated_networking_enabled = try(each.value.accelerated_networking_enabled, false)
  internal_dns_name_label        = try(each.value.internal_dns_name_label, null)
  tags                           = try(each.value.tags, {})

  # =====================
  # IP Configuration(s)
  # =====================
  dynamic "ip_configuration" {
    for_each = try(each.value.ip_configurations, [])
    content {
      name                                               = ip_configuration.value.name
      subnet_id                                          = try(var.subnet_ids[each.value.subnet_key], null)
      # subnet_id                                          = (contains(keys(var.subnet_ids), each.value.subnet_key) ? var.subnet_ids[each.value.subnet_key] : null)
      private_ip_address_version                         = try(ip_configuration.value.private_ip_address_version, "IPv4")
      private_ip_address_allocation                      = ip_configuration.value.private_ip_address_allocation
      private_ip_address                                 = try(ip_configuration.value.private_ip_address, null)
      public_ip_address_id                               = try(var.public_ip_ids[each.value.public_ip_name], null)
      # public_ip_address_id                               = (contains(keys(var.public_ip_ids), each.value.public_ip_name) ? var.public_ip_ids[each.value.public_ip_name] : null)
      primary                                            = try(ip_configuration.value.primary, false)
      gateway_load_balancer_frontend_ip_configuration_id = try(ip_configuration.value.gateway_load_balancer_frontend_ip_configuration_id, null)
    }
  }
}


# ====================================================================
# Network Interface (NIC) & Network Security Group (NSG) association
# ====================================================================
resource "azurerm_network_interface_security_group_association" "example" {
    # Only NICs with a valid NSG key will have this association
  for_each = {
    for k, v in var.var_child_nic : k => v
    if (
      try(v.nsg_key, null) != null &&
      contains(keys(var.nsg_ids), v.nsg_key)
    )
  }

  network_interface_id      = azurerm_network_interface.child_nic[each.key].id
  network_security_group_id = var.nsg_ids[each.value.nsg_key]
}