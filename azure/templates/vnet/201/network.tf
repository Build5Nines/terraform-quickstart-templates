# #################################################################################
# Build5Nines: Terraform Kung-fu
# https://build5nines.com/teraform-kung-fu
# Copyright (c) 2020 Build5Nines.com
# MIT License - https://github.com/Build5Nines/terraform-kung-fu/blob/master/LICENSE
# WARNING: These scripts could either cause resume generating events or get you promoted.
# Please, proceed with extreme caution!
# #################################################################################
# PURPOSE:
# - 201 - Create a resource using locals and variables
# #################################################################################
# USAGE:
# - Run terraform in this directory to create the resource(s)
# #################################################################################
# HELPFUL RESOURCES:
# - https://build5nines.com/?s=terraform
# - https://www.terraform.io/docs/providers/azurerm/r/virtual_network.html
# #################################################################################
locals {
  vnet_address_space = "172.16.0.0/16"
}

resource "azurerm_virtual_network" "b59s_vnet" {
  address_space       = [local.vnet_address_space]
  location            = var.location
  name                = "${local.prefix}-vnet"
  resource_group_name = azurerm_resource_group.b59s_rg.name
}

resource "azurerm_subnet" "apps_subnet" {
  name                 = "APPS"
  resource_group_name  = azurerm_resource_group.b59s_rg.name
  virtual_network_name = azurerm_virtual_network.b59s_vnet.name
  address_prefixes     = [cidrsubnet(local.vnet_address_space, 8, 0)]
}

resource "azurerm_subnet" "data_subnet" {
  name                 = "DATA"
  resource_group_name  = azurerm_resource_group.b59s_rg.name
  virtual_network_name = azurerm_virtual_network.b59s_vnet.name
  address_prefixes     = [cidrsubnet(local.vnet_address_space, 8, 1)]
}




