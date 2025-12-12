output "out_child_nsg_ids" {
  description = "Map of NSG names to their IDs"
  value       = { for k, nsg in azurerm_network_security_group.child_nsg : k => nsg.id }
}

###############################
# Below is the output
# 👉 Maps NSG key → NSG ID
###############################
# out_child_nsg_ids = {
#   "nsg1" = "/subscriptions/xxx-xxx-xxx-xxx/resourceGroups/eagle-rg1/providers/Microsoft.Network/networkSecurityGroups/eagle-nsg1"
# }
###############################


output "out_child_nsg_names" {
  description = "Map of NSG keys to their names"
  value       = { for k, nsg in azurerm_network_security_group.child_nsg : k => nsg.name }
}

###############################
# Below is the output
# 👉 Maps NSG key → NSG name
###############################
# out_child_nsg_names = {
#   "nsg1" = "eagle-nsg1"
# }
###############################

output "out_child_nsg_key_name_id" {
  value = {
    for k, v in azurerm_network_security_group.child_nsg :
    k => {
      nsg_name = v.name
      nsg_id = v.id
    }
  }
}


output "out_child_nsg_name_ids" {
  description = "Map of NSG names to their IDs"
  value       = { 
    for k, nsg in azurerm_network_security_group.child_nsg : 
    nsg.name => nsg.id 
    }
}