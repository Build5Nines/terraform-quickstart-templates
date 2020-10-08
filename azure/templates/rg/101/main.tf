# #################################################################################
# Build5Nines: Terraform Kung-fu
# https://build5nines.com/teraform-kung-fu
# Copyright (c) 2020 Build5Nines.com
# MIT License - https://github.com/Build5Nines/terraform-kung-fu/blob/master/LICENSE
# WARNING: These scripts could either cause resume generating events or get you promoted.
# Please, proceed with extreme caution!
# #################################################################################
# PURPOSE:
# - 101 - Create a resource using just one file
# #################################################################################
# USAGE:
# - Run this one file using terraform to create the resource
# #################################################################################
# HELPFUL RESOURCES:
# - https://build5nines.com/?s=terraform
# - https://www.terraform.io/docs/providers/azurerm/r/resource_group.html
# #################################################################################

provider "azurerm" {
  # AzureRM provider 2.x
  version = "~>2.0"
  # v2.x required "features" block
  features {}
  # subscription_id = "YOUR_SUBSCRIPTION_ID_HERE" optional if using the CLI
  # tenant_id       = "YOUR_TENANT_ID_HERE" optional if using the CLI
}

resource "azurerm_resource_group" "b59s_rg" {
  location = "eastus2"
  name     = "b59s-eastus2-rg"
}
