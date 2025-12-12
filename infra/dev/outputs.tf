output "out_root_subnet_vnet_map" {
  description = "Expose subnet-to-vnet map from networking module"
  value       = module.module_networking.out_child_subnet_vnet_map
}

output "out_root_subnet_ids" {
  description = "Expose subnet-to-vnet map from networking module"
  value       = module.module_networking.out_child_subnet_ids
}