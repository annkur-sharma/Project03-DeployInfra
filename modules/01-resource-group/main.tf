resource "azurerm_resource_group" "child_resource_group" {
  for_each = var.var_child_resource_group

  name     = each.value.resource_group_name
  location = each.value.location
  tags     = each.value.tags
}

resource "azurerm_storage_account" "sa" {
  for_each = var.var_child_resource_group
  
  name                     = "annkursaprod12321"
  location                 = each.value.location
  resource_group_name      = each.value.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}