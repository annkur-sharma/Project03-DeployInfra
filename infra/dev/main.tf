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

module "module_nsg" {
  depends_on    = [module.module_resource_group, module.module_networking]
  source        = "../../modules/03-nsg"
  var_child_nsg = var.var_root_dev_nsg
}

# module "module_public_ip" {
#   depends_on          = [module.module_resource_group]
#   source              = "../../modules/04-public-ip"
#   var_child_public_ip = var.var_root_dev_public_ip
# }

module "module_nic_vms" {
  depends_on    = [module.module_resource_group, module.module_networking, module.module_nsg ]
  source        = "../../modules/05-nic"
  var_child_nic = var.var_root_dev_nic_private_ip
  subnet_ids    = module.module_networking.out_child_subnet_ids
  nsg_ids       = module.module_nsg.out_child_nsg_name_ids
  public_ip_ids = {}
}

module "module_vm" {
  depends_on   = [module.module_resource_group, module.module_networking, module.module_nic_vms]
  source       = "../../modules/06-vm"
  var_child_vm = var.var_root_dev_vms
}

# output "hello_world" {
#   value = "Hello, World!"
# }