output "out_root_subnet_vnet_map" {
  description = "Expose subnet-to-vnet map from networking module"
  value       = module.module_networking.out_child_subnet_vnet_map
}

output "out_root_subnet_ids" {
  description = "Expose subnet-to-vnet map from networking module"
  value       = module.module_networking.out_child_subnet_ids
}

output "out_root_nsg_key_name_id" {
  value = module.module_nsg.out_child_nsg_key_name_id
}

output "out_root_nsg_ids" {
  description = "Map of NSG names to their IDs"
  value = module.module_nsg.out_child_nsg_ids
}

output "out_root_nsg_names" {
  description = "Map of NSG keys to their names"
  value = module.module_nsg.out_child_nsg_names
}

# output "out_root_public_ip_details" {
#   description = "Map of public IP names to their IDs"
#   value = module.module_public_ip.out_child_public_ip_details
# }

output "out_root_nsg_name_ids" {
  value = module.module_nsg.out_child_nsg_name_ids
}