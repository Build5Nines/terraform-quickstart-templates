
# The Azure Resource group for all the resources to reside
resource azurerm_resource_group "rg" {
    location = local.azure_region
    name     = local.resource_group_name

    tags = local.tags
}