variable "var_child_vm" {
  description = "Map of virtual machines with configuration"
  type = map(object({
    name                            = string
    location                        = string
    resource_group_name             = string
    size                            = string
    admin_username_key              = optional(string)
    admin_password_key              = optional(string)
    disable_password_authentication = bool
    # network_interface_id         = string
    nic_name             = string
    storage_account_type = string

    image = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })

    ssh_public_key        = optional(string)
    computer_name         = string
    boot_diag_storage_uri = optional(string)
    tags                  = optional(map(string))

    child_custom_data_file = optional(string)

    # Key Vault variables
    key_Vault_name                = string
    key_Vault_resource_group_name = string
    # key_vm_username = string
    # key_vm_password = string
  }))
}

# variable "variable_child_keyvault_1" {
#   type = object({
#     key_Vault_name      = string
#     resource_group_name = string
#   })
# }

# variable "variable_child_vm1_credentials" {
#   type = object({
#     key_vm_username = string
#     key_vm_password = string
#   })
# }
