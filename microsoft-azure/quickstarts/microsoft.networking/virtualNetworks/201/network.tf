
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




