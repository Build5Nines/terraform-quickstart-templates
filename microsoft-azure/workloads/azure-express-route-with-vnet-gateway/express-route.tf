# Azure Express Route Circuit
resource azurerm_express_route_circuit "express_route" {
    name                  = "${local.resource_name_prefix}-erc"
    resource_group_name   = azurerm_resource_group.rg.name
    location              = azurerm_resource_group.rg.location

    # https://docs.microsoft.com/en-us/azure/expressroute/expressroute-locations-providers
    service_provider_name = "Equinix"
    peering_location      = "Washington DC"
    bandwidth_in_mbps     = 1000

    sku {
        tier   = "Standard"  
        family = "MeteredData" 
    }

    tags = local.tags
}

# NOTE:
# Once the Express Route Circuit is provisioned, the "Service Key" for the Express Route Circuit
# will need to be given to the Express Route Service Provider, so they can finish setting up
# the Azure Express Route. Once it's setup, the "Provider Status" will show "Provisioned".

# Azure Express Route Private Peering
resource azurerm_express_route_circuit_peering "express_route_peering" {
    resource_group_name           = azurerm_resource_group.rg.name

    express_route_circuit_name    = azurerm_express_route_circuit.express_route.name

    peering_type                  = "AzurePrivatePeering"
    primary_peer_address_prefix   = "10.0.0.0/30"
    secondary_peer_address_prefix = "10.0.0.0/30"
    vlan_id                       = 100
    peer_asn                      = 100
}
