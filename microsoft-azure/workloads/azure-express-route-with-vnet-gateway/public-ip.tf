# Azure Public IP Address for the VNet Gateway
resource azurerm_public_ip "vnet_gateway_public_ip" {
    name                = "${local.resource_name_prefix}-vgw-pip"
    resource_group_name   = azurerm_resource_group.rg.name
    location              = azurerm_resource_group.rg.location

    sku               = "Basic"
    allocation_method = "Dynamic"

    tags = local.tags
}