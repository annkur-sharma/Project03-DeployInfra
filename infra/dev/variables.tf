variable "var_root_dev_resource_group" {
    type = map(any)
}

# "Map of Virtual Network, Subnet, Public IP"
variable "var_root_dev_vnet"  {
    type = map(any)
}

# "Subnet definitions for each VNet"
variable "var_root_dev_subnet"  {
    type = map(any)
}