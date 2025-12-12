variable "var_child_nic" {
  description = "Map of Network Interfaces with their IP configuration details."
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string

    auxiliary_mode                 = optional(string)
    auxiliary_sku                  = optional(string)
    dns_servers                    = optional(list(string))
    edge_zone                      = optional(string)
    ip_forwarding_enabled          = optional(bool)
    accelerated_networking_enabled = optional(bool)
    internal_dns_name_label        = optional(string)
    tags                           = optional(map(string))

    ip_configurations = list(object({
      name                                               = string
      subnet_id                                          = optional(string)
      private_ip_address_version                         = optional(string)
      private_ip_address_allocation                      = string
      private_ip_address                                 = optional(string)
      public_ip_address_id                               = optional(string)
      primary                                            = optional(bool)
      gateway_load_balancer_frontend_ip_configuration_id = optional(string)
    }))

    # Required values for data block of subnet
    subnet_name          = optional(string)
    virtual_network_name = string
    subnet_key           = optional(string)

    # Required values for data block of public ip address
    public_ip_name = optional(string)

    # Required values for data block of nsg
    nsg_key = optional(string)
  }))
}

variable "subnet_ids" {
  description = "Map of subnet names to subnet IDs"
  type        = map(string)
  default     = {}
}

variable "public_ip_ids" {
  description = "Map of public IP names to public IP IDs"
  type        = map(string)
  default     = {}
}

variable "nsg_ids" {
  description = "Map of NSG Name to NSG IDs"
  type        = map(string)
  default     = {}
}
