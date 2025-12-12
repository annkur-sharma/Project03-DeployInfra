resource "azurerm_linux_virtual_machine" "child_vm" {
  for_each = var.var_child_vm

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.size

  admin_username                  = data.azurerm_key_vault_secret.get_key_vault_secret_vm1_username_1[each.key].value
  admin_password                  = data.azurerm_key_vault_secret.get_key_vault_secret_vm1_password_1[each.key].value
  disable_password_authentication = each.value.disable_password_authentication

  network_interface_ids = [
    data.azurerm_network_interface.get_child_nic[each.key].id
  ]

  os_disk {
    name                 = "${each.value.name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = each.value.storage_account_type
  }

  source_image_reference {
    publisher = each.value.image.publisher
    offer     = each.value.image.offer
    sku       = each.value.image.sku
    version   = each.value.image.version
  }

  custom_data = try(base64encode(file(each.value.child_custom_data_file)), null)

  #   admin_ssh_key {
  #     username   = each.value.admin_username
  #     public_key = try(each.value.ssh_public_key, null)
  #   }

  computer_name              = each.value.computer_name
  provision_vm_agent         = true
  allow_extension_operations = true

  boot_diagnostics {
    storage_account_uri = try(each.value.boot_diag_storage_uri, null)
  }

  tags = try(each.value.tags, {})

}
