var_root_dev_resource_group = {
  resource_group1 = {
    resource_group_name = "eagle-rg1"
    location            = "francecentral"
    tags = {
      Environment  = "dev"
      owner        = "annkur"
      cost_center  = "1234"
      project      = "my-app"
      Service = "devops"
    }
  }
}


var_root_dev_vnet = {
  vnet1 = {
    # Required variables of VNet
    vnet_name           = "eagle-vnet1"
    location            = "francecentral"
    resource_group_name = "eagle-rg1"
    address_space       = ["10.0.0.0/16"]
    dns_servers         = ["10.0.0.4", "10.0.0.5"]

    tags = {
      Environment  = "dev"
      owner        = "annkur"
      cost_center  = "1234"
      project      = "my-app"
      Service = "devops"
    }
  }
}


var_root_dev_subnet = {
  subnet1 = {
    subnet_name          = "eagle-subnet1-frontend"
    virtual_network_name = "eagle-vnet1"
    vnet_key             = "vnet1"
    resource_group_name  = "eagle-rg1"
    address_prefixes     = ["10.0.1.0/24"]
  }
  subnet2 = {
    subnet_name          = "eagle-subnet2-backend"
    virtual_network_name = "eagle-vnet1"
    vnet_key             = "vnet1"
    resource_group_name  = "eagle-rg1"
    address_prefixes     = ["10.0.2.0/24"]
  }
}