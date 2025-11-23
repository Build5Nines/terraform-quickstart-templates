
# #################################################################################
# Primary Region Resource Groups
# #################################################################################

# The Azure Resource Group for all Networking resources to reside in the Primary Region
resource "azurerm_resource_group" "primary_networking_rg" {
  name     = "${module.azure_primary.resources.resource_group.name}-${local.workload_suffix.networking}"
  location = module.azure_primary.location

  tags = merge(local.primary_tags, {
    Workload = local.workload_suffix.networking
  })
}

# The Azure Resource Group for all Database resources to reside in the Primary Region
resource "azurerm_resource_group" "primary_database_rg" {
  name     = "${module.azure_primary.resources.resource_group.name}-${local.workload_suffix.database}"
  location = module.azure_primary.location

  tags = merge(local.primary_tags, {
    Workload = local.workload_suffix.database
  })
}

# The Azure Resource Group for all Application resources to reside in the Primary Region
resource "azurerm_resource_group" "primary_application_rg" {
  name     = "${module.azure_primary.resources.resource_group.name}-${local.workload_suffix.app}"
  location = module.azure_primary.location

  tags = merge(local.primary_tags, {
    Workload = local.workload_suffix.app
  })
}

# #################################################################################
# Secondary Region Resource Groups
# #################################################################################

# The Azure Resource Group for all Networking resources to reside in the Secondary Region
resource "azurerm_resource_group" "secondary_networking_rg" {
  name     = "${module.azure_secondary.resources.resource_group.name}-${local.workload_suffix.networking}"
  location = module.azure_secondary.location

  tags = merge(local.secondary_tags, {
    Workload = local.workload_suffix.networking
  })
}

# The Azure Resource Group for all Database resources to reside in the Secondary Region
resource "azurerm_resource_group" "secondary_database_rg" {
  name     = "${module.azure_secondary.resources.resource_group.name}-${local.workload_suffix.database}"
  location = module.azure_secondary.location

  tags = merge(local.secondary_tags, {
    Workload = local.workload_suffix.database
  })
}

# The Azure Resource Group for all Application resources to reside in the Secondary Region
resource "azurerm_resource_group" "secondary_application_rg" {
  name     = "${module.azure_secondary.resources.resource_group.name}-${local.workload_suffix.app}"
  location = module.azure_secondary.location

  tags = merge(local.secondary_tags, {
    Workload = local.workload_suffix.app
  })
}