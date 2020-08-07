# #################################################################################
# Build5Nines Terraform Kung-fu
# https://build5nines.com/teraform-kung-fu
# Copyright (c) 2020 Build5Nines.com
# MIT License - https://github.com/Build5Nines/terraform-kung-fu/blob/master/LICENSE
# WARNING: These scripts could either cause resume generating events or get you promoted.
# Please, proceed with extreme caution!
# #################################################################################
# PURPOSE:
# - Create an Azure Databricks Workspace within a Resource Group
# #################################################################################
# USAGE:
# - Update the local variables for the
# #################################################################################
# HELPFUL RESOURCES:
# - https://www.terraform.io/docs/providers/azurerm/r/databricks_workspace.html
# #################################################################################

provider "azurerm" {
  # AzureRM provider 2.x
  version = "~>2.0"
  # v2.x required "features" block
  features {}
}

locals {
    resource_group_name = "b59_databricks"
    location            = "eastus"
    databricks_sku      = "standard"
}

# Create a resource group
resource "azurerm_resource_group" "primary" {
  name     = local.resource_group_name
  location = local.location
}

# Create Azure Databricks Workspace
resource "azurerm_databricks_workspace" "primary" {
  name                      = local.databricks_workspace_name

  # Provision in the Resource Group that was created above
  resource_group_name       = azurerm_resource_group.primary.name

  # Provision in the same Azure Region / Location as the Resource Group above
  location                  = azurerm_resource_group.primary.location

  sku                       = local.databricks_sku
}
