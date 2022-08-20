
# The Azure Resource group for all the resources to reside
resource azurerm_resource_group "rg" {
    name     = "${local.resource_name_prefix}-rg"
    location = local.azure_region

    tags = local.tags
}