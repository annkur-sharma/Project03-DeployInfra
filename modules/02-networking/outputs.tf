# Output map of Subnet name → Virtual Network name
output "out_child_subnet_vnet_map" {
  description = "Map of Subnet name to its parent Virtual Network"
  value = {
    for k, v in azurerm_subnet.child_subnet :
    v.name => v.virtual_network_name
  }
}

###############################
# Below is the output
# 👉 Loops through each subnet and maps:
# subnet_name → virtual_network_name
###############################
# subnet_vnet_map = {
  # "eagle-subnet1-frontend" = "eagle-vnet1"
  # "eagle-subnet2-backend" = "eagle-vnet1"
# }
###############################


output "out_child_subnet_ids" {
  description = "Map of subnet names to subnet IDs"
  value = { 
    for k, v in azurerm_subnet.child_subnet : 
    k => v.id 
    }
}

###############################
# Below is the output
# 👉 Maps subnet key → subnet ID
###############################
# subnet_ids = {
#   "subnet1" = "/subscriptions/xxx-xxx-xxx-xxx/resourceGroups/eagle-rg1/providers/Microsoft.Network/virtualNetworks/eagle-vnet1/subnets/eagle-subnet1"
#   "subnet2" = "/subscriptions/xxx-xxx-xxx-xxx/resourceGroups/eagle-rg1/providers/Microsoft.Network/virtualNetworks/eagle-vnet1/subnets/AzureBastionSubnet"
# }
###############################

