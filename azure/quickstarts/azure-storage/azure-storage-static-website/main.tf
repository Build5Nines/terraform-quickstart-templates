# #################################################################################
# Build5Nines: Terraform Kung-fu
# https://build5nines.com/teraform-kung-fu
# Copyright (c) 2020 Build5Nines.com
# MIT License - https://github.com/Build5Nines/terraform-kung-fu/blob/master/LICENSE
# WARNING: These scripts could either cause resume generating events or get you promoted.
# Please, proceed with extreme caution!
# #################################################################################
# PURPOSE:
# - Create an Azure Storage Account to host a Static Website
# #################################################################################
# USAGE:
# - Update the local variables to configure the resource
# #################################################################################
# HELPFUL RESOURCES:
# - https://build5nines.com/get-started-with-terraform-on-microsoft-azure/
# #################################################################################

provider "azurerm" {
  # AzureRM provider 2.x
  version = "~>2.0"
  # v2.x required "features" block
  features {}
}

locals {
    resource_group_name       = "b59_iot"
    location                  = "eastus"
    
    storage_account_name      = "b59_storage_website"
    account_kind              = "StorageV2"
    account_tier              = "Standard"
    account_replication_type  = "LRS"
    enable_https_traffic_only = true
}

# Create a resource group
resource "azurerm_resource_group" "primary" {
  name     = local.resource_group_name
  location = local.location
}

# Create an Azure Storage Account
resource "azurerm_storage_account" "primary" {
  name                      = local.storage_account_name
  resource_group_name       = azurerm_resource_group.primary.name
  location                  = azurerm_resource_group.primary.location
  account_kind              = local.account_kind
  account_tier              = local.account_tier
  account_replication_type  = local.account_replication_type
  enable_https_traffic_only = local.enable_https_traffic_only

  # Configure Storage Account to host a Static Website
  provisioner "local-exec" {
    command = "az storage blob service-properties update --account-name ${azurerm_storage_account.primary.name} --static-website  --index-document index.html --404-document 404.html"
  }
}
