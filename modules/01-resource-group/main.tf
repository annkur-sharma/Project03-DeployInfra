resource "azurerm_resource_group" "child_resource_group" {
  for_each = var.var_child_resource_group

  name     = each.value.resource_group_name
  location = each.value.location
  tags     = each.value.tags
}