# #################################################################################
# Build5Nines: Terraform Quickstart Templates
# https://build5nines.com/teraform-quickstart-templates
# Copyright (c) 2023 Build5Nines.com, Chris Pietschmann
# MIT License - https://github.com/Build5Nines/terraform-quickstart-templates/blob/master/LICENSE
# WARNING: These scripts could either cause resume generating events or get you promoted.
# Please, proceed with extreme caution!
# #################################################################################
# PURPOSE:
# - Create an Azure Storage Account and Container
# #################################################################################
# USAGE:
# - Update the local variables to configure the resource
# #################################################################################
# HELPFUL RESOURCES:
# - https://build5nines.com/get-started-with-terraform-on-microsoft-azure/
# - https://build5nines.com/terraform-deploy-azure-storage-account-and-blob-container/
# #################################################################################

terraform {
  required_providers {
    # AzureRM provider 3.x
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
    resource_group_name       = "b59_storage"
    location                  = "eastus"
    
    storage_account_name      = "b59storagewebsite"
    account_kind              = "StorageV2"
    account_tier              = "Standard"
    account_replication_type  = "LRS"
    enable_https_traffic_only = true

    container_name = "myblobs"
    container_access_type = "private"
}

# Create a resource group
resource azurerm_resource_group "primary" {
  name     = local.resource_group_name
  location = local.location
}

# Create an Azure Storage Account
resource azurerm_storage_account "primary" {
  name                      = local.storage_account_name
  resource_group_name       = azurerm_resource_group.primary.name
  location                  = azurerm_resource_group.primary.location
  account_kind              = local.account_kind
  account_tier              = local.account_tier
  account_replication_type  = local.account_replication_type
  enable_https_traffic_only = local.enable_https_traffic_only
}

// Create a Container in the Azure Storage Account
resource azurerm_storage_container "primary" {
  name                  = local.container_name
  storage_account_name  = azurerm_storage_account.primary.name
  container_access_type = local.container_access_type
}
