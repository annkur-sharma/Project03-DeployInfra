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

# Public IP resource
variable "var_root_dev_public_ip"  {
    type = map(any)
}

# "Map of Network Security Groups to create with optional security rules."
variable "var_root_dev_nsg"  {
    type = map(any)
}

# "Map of virtual machines with configuration"
variable "var_root_dev_vms"  {
    type = map(any)
}

# "Map of Network Interfaces with their IP configuration details."
variable "var_root_dev_nic_private_ip"  {
    type = map(any)
}