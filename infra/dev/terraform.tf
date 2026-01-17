terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.50.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "ankurbackend01"                        # Example: "rg-backend"
    storage_account_name = "ankur01storage01ae01"                      # Example: "rgbackendtorageaccount"
    container_name       = "ankurstorage01container01"             # Example: "rgbackendstoragecontainer"
    key                  = "Project03.terraform.tfstate"
  }

  required_version = ">= 1.0.0"
}
