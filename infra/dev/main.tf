module "module_resource_group" {
  source                   = "../../modules/01-resource-group"
  var_child_resource_group = var.var_root_dev_resource_group
}

module "module_networking" {
  depends_on       = [module.module_resource_group]
  source           = "../../modules/02-networking"
  var_child_vnet   = var.var_root_dev_vnet
  var_child_subnet = var.var_root_dev_subnet
}