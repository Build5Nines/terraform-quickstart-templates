# Azure Virtual Network
resource azurerm_virtual_network "virtual_network" {
    name                = "${local.resource_name_prefix}-vnet"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    address_space = ["172.16.0.0/12"]
  
    tags = local.tags
}

# GatewaySubnet within the Virtual Network
resource azurerm_subnet "gateway_subnet" {
    name                 = "GatewaySubnet"
    resource_group_name = azurerm_resource_group.rg.name

    virtual_network_name = azurerm_virtual_network.virtual_network.name
    address_prefixes     = ["172.16.0.0/24"]

    enforce_private_link_endpoint_network_policies = true
}