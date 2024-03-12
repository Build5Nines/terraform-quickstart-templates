# #################################################################################
# Build5Nines: Terraform Quickstart Templates
# https://build5nines.com/teraform-quickstart-templates
# Copyright (c) 2022 Build5Nines.com, Chris Pietschmann
# MIT License - https://github.com/Build5Nines/terraform-quickstart-templates/blob/master/LICENSE
# WARNING: These scripts could either cause resume generating events or get you promoted.
# Please, proceed with extreme caution!
# #################################################################################
# PURPOSE:
# - Create an Azure Databricks Workspace within a Resource Group
# #################################################################################
# USAGE:
# - Update the local variables to configure the resource
# #################################################################################
# HELPFUL RESOURCES:
# - https://build5nines.com/get-started-with-terraform-on-microsoft-azure/
# #################################################################################

terraform {
  required_providers {
    # AzureRM provider 3.x
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
    resource_group_name       = "b59_databricks"
    location                  = "eastus"

    databricks_workspace_name = "b59_databricks_workspace"
    databricks_sku            = "standard"
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
