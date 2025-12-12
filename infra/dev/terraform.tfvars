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

var_root_dev_nsg = {
  nsg1 = {
    name                = "eagle-nsg1-frontend"
    location            = "francecentral"
    resource_group_name = "eagle-rg1"

    tags = {
      env      = "dev"
      resource = "nsg"
      app      = "terraform"
      env_type = "frontend"
    }

    security_rules = [
      {
        name                       = "Allow-SSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Allow-HTTP"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }

  nsg2 = {
    name                = "eagle-nsg2-backend"
    location            = "francecentral"
    resource_group_name = "eagle-rg1"

    tags = {
      env      = "dev"
      resource = "nsg"
      app      = "terraform"
      env_type = "backend"
    }

    security_rules = [
      {
        name                       = "Allow-SSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Allow-HTTP"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}

var_root_dev_nic_private_ip = {
  nic_vm1 = {
    name                           = "eagle-nic1-frontend"
    location                       = "francecentral"
    resource_group_name            = "eagle-rg1"
    accelerated_networking_enabled = false
    ip_forwarding_enabled          = false

    tags = {
      env      = "dev"
      resource = "nic"
      app      = "terraform"
      env_type = "frontend"
    }

    subnet_key           = "subnet1"
    subnet_name          = "eagle-subnet1-frontend"
    virtual_network_name = "eagle-vnet1"
    nsg_key              = "eagle-nsg1-frontend"


    ip_configurations = [
      {
        name                          = "eagle-ipconfig1-frontend"
        private_ip_address_allocation = "Dynamic"
        primary                       = true
      }
    ]
  }

  nic_vm2 = {
    name                = "eagle-nic2-backend"
    location            = "francecentral"
    resource_group_name = "eagle-rg1"
    accelerated_networking_enabled = false
    ip_forwarding_enabled          = false
    
    tags = {
      env      = "dev"
      resource = "nic"
      app      = "terraform"
      env_type = "backend"
    }
    subnet_key           = "subnet2"
    subnet_name          = "eagle-subnet2-backend"
    virtual_network_name = "eagle-vnet1"
    nsg_key              = "eagle-nsg2-backend"


    ip_configurations = [
      {
        name                          = "eagle-ipconfig2-backend"
        private_ip_address_allocation = "Dynamic"
        primary                       = true
      }
    ]
  }
}


var_root_dev_vms = {
  vm1 = {
    name                = "eagle-vm1-frontend"
    location            = "francecentral"
    resource_group_name = "eagle-rg1"
    size                = "Standard_B1ms"

    key_Vault_name                = "ankurKeyVault5"
    key_Vault_resource_group_name = "ankurbackend01"

    admin_username_key              = "vmuser"
    admin_password_key              = "vmpassword"
    disable_password_authentication = false

    # network_interface_id         = "/subscriptions/xxxx/resourceGroups/eagle-rg1/providers/Microsoft.Network/networkInterfaces/eagle-nic-frontend"
    nic_name             = "eagle-nic1-frontend"
    storage_account_type = "Standard_LRS"

    image = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
      version   = "latest"
    }

    computer_name          = "frontendvm"
    child_custom_data_file = "../scripts/init_blue.sh"
    tags = {
      env      = "dev"
      resource = "vm"
      app      = "terraform"
      env_type = "frontend"
    }
  }

  vm2 = {
    name                = "eagle-vm2-backend"
    location            = "francecentral"
    resource_group_name = "eagle-rg1"
    size                = "Standard_B1s"

    key_Vault_name                = "ankurKeyVault5"
    key_Vault_resource_group_name = "ankurbackend01"

    admin_username_key              = "vmuser"
    admin_password_key              = "vmpassword"
    disable_password_authentication = false

    # network_interface_id = "/subscriptions/xxxx/resourceGroups/eagle-rg1/providers/Microsoft.Network/networkInterfaces/eagle-nic-backend"
    nic_name             = "eagle-nic2-backend"
    storage_account_type = "Standard_LRS"

    image = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
      version   = "latest"
    }

    computer_name          = "backendvm"
    child_custom_data_file = "../scripts/init_green.sh"
    tags = {
      env      = "dev"
      resource = "vm"
      app      = "terraform"
      env_type = "backend"
    }
  }
}