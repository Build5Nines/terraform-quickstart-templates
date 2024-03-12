# #################################################################################
# Build5Nines: Terraform Quickstart Templates
# https://build5nines.com/teraform-quickstart-templates
# Copyright (c) 2022 Build5Nines.com, Chris Pietschmann
# MIT License - https://github.com/Build5Nines/terraform-quickstart-templates/blob/master/LICENSE
# WARNING: These scripts could either cause resume generating events or get you promoted.
# Please, proceed with extreme caution!
# #################################################################################
# PURPOSE:
# - 101 - Create a resource using just one file
# #################################################################################
# USAGE:
# - Run this one file using terraform to create the resource
# #################################################################################
# HELPFUL RESOURCES:
# - https://build5nines.com/?s=terraform
# - https://www.terraform.io/docs/providers/azurerm/r/virtual_network.html
# #################################################################################

terraform {
  required_providers {
    # AzureRM provider 3.x
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "b59s_rg" {
  location = "eastus2"
  name     = "b59s-eastus2-rg"
}

resource "azurerm_virtual_network" "b59s_vnet" {
  address_space       = ["172.16.0.0/16"]
  location            = "eastus2"
  name                = "b59s-eastus2-vnet"
  resource_group_name = azurerm_resource_group.b59s_rg.name
  subnet {
    address_prefix = "172.16.0.0/24"
    name           = "APPS"
  }
  subnet {
    address_prefix = "172.16.1.0/24"
    name           = "DATA"
  }
}

