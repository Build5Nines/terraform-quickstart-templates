# #################################################################################
# Build5Nines: Terraform Kung-fu
# https://build5nines.com/teraform-kung-fu
# Copyright (c) 2020 Build5Nines.com
# MIT License - https://github.com/Build5Nines/terraform-kung-fu/blob/master/LICENSE
# WARNING: These scripts could either cause resume generating events or get you promoted.
# Please, proceed with extreme caution!
# #################################################################################
# PURPOSE:
# - <fill in purpose>
# #################################################################################
# USAGE:
# - Update the local variables to configure the resource
# #################################################################################
# HELPFUL RESOURCES:
# - <add-links>
# #################################################################################

resource "azurerm_virtual_network" "b59s_vnet" {
  address_space       = [var.vnet_address_space]
  location            = var.location
  name                = "${local.prefix}-vnet"
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "apps_subnet" {
  name                 = "APPS"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.b59s_vnet.name
  address_prefixes     = [cidrsubnet(var.vnet_address_space, 8, 0)]
}

resource "azurerm_subnet" "data_subnet" {
  name                 = "DATA"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.b59s_vnet.name
  address_prefixes     = [cidrsubnet(var.vnet_address_space, 8, 1)]
}




