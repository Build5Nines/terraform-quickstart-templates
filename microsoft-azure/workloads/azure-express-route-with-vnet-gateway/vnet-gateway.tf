# Azure Virtual Network Gateway
resource azurerm_virtual_network_gateway "virtual_network_gateway" {
    name                = "${local.resource_name_prefix}-vgw"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    type     = "ExpressRoute"
    vpn_type = "PolicyBased"

    sku           = "HighPerformance"
    active_active = false
    enable_bgp    = false

    ip_configuration {
        name                          = "default"
        private_ip_address_allocation = "Dynamic"
        subnet_id                     = azurerm_subnet.gateway_subnet.id
        public_ip_address_id          = azurerm_public_ip.vnet_gateway_public_ip.id
    }
}

# Azure Virtual Network Gateway Connection to Express Route
resource azurerm_virtual_network_gateway_connection "virtual_network_gateway_connection" {
    name                = "${local.resource_name_prefix}-vgw-con"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    type                            = "ExpressRoute"
    virtual_network_gateway_id      = azurerm_virtual_network_gateway.virtual_network_gateway.id
    express_route_circuit_id        = azurerm_express_route_circuit.express_route.id
    
    tags = local.tags
}

# NOTE:
# The VNet Gateway Connection will error out if the Azure Express Route Circuit "Provider Status" is
# in a "Not provisioned" state. You'll need to wait for the Expres Route Provider to finish setting
# it up before the Azure VNet Gateway Connection resource can be provisioned.
#
# When this error ocurs, the 'azurerm' Terraform Provider may return an error message such as:
# "Error: ID was missing the `virtualNetworkGateways` element" for the virtual_network_gateway_connection
# Azure resource.