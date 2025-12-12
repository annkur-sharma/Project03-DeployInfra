data "azurerm_network_interface" "get_child_nic" {
  for_each = var.var_child_vm

  name                = each.value.nic_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault" "get_azure_key_vault_1" {
  for_each = var.var_child_vm

  name                = each.value.key_Vault_name
  resource_group_name = each.value.key_Vault_resource_group_name
}

data "azurerm_key_vault_secret" "get_key_vault_secret_vm1_username_1" {
  for_each = var.var_child_vm

  name         = each.value.admin_username_key
  key_vault_id = data.azurerm_key_vault.get_azure_key_vault_1[each.key].id
}

data "azurerm_key_vault_secret" "get_key_vault_secret_vm1_password_1" {
  for_each = var.var_child_vm

  name         = each.value.admin_password_key
  key_vault_id = data.azurerm_key_vault.get_azure_key_vault_1[each.key].id
}
