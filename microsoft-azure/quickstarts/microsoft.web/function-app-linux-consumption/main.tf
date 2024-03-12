# #################################################################################
# Build5Nines: Terraform Quickstart Templates
# https://build5nines.com/teraform-quickstart-templates
# Copyright (c) 2023 Build5Nines.com, Chris Pietschmann
# MIT License - https://github.com/Build5Nines/terraform-quickstart-templates/blob/master/LICENSE
# WARNING: These scripts could either cause resume generating events or get you promoted.
# Please, proceed with extreme caution!
# #################################################################################
# PURPOSE:
# - Create an Azure Function App using Linux and Consumption plan pricing
# #################################################################################
# USAGE:
# - Update the local variables to configure the resource
# #################################################################################
# HELPFUL RESOURCES:
# - https://build5nines.com/get-started-with-terraform-on-microsoft-azure/
# - https://build5nines.com/terraform-deploy-azure-function-app-with-consumption-plan/
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
    resource_group_name       = "b59_functions"
    location                  = "eastus"
    
    function_app_name         = "b59-func-app"
    app_service_plan_name     = "b59_func_app_plan"
    storage_account_name      = "b59funcappsa"
}

# Create a resource group
resource "azurerm_resource_group" "primary" {
  name     = local.resource_group_name
  location = local.location
}

# Create Azure Storage Account required for Function App
resource azurerm_storage_account "primary" {
  name                     = local.storage_account_name
  resource_group_name      = azurerm_resource_group.primary.name
  location                 = azurerm_resource_group.primary.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create Azure App Service Plan using Consumption pricing
resource azurerm_app_service_plan "primary" {
  name                = local.app_service_plan_name
  location            = azurerm_resource_group.primary.location
  resource_group_name = azurerm_resource_group.primary.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

# Create an Azure Function App on Linux
resource azurerm_function_app "primary" {
  name                       = local.function_app_name
  resource_group_name        = azurerm_resource_group.primary.name
  location                   = azurerm_resource_group.primary.location

  app_service_plan_id        = azurerm_app_service_plan.primary.id
  
  storage_account_name       = azurerm_storage_account.primary.name
  storage_account_access_key = azurerm_storage_account.primary.primary_access_key
  
  os_type                    = "linux"
  version                    = "~3"

  site_config {
    always_on = true
  }
}

