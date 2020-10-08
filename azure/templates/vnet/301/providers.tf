# #################################################################################
# Build5Nines: Terraform Kung-fu
# https://build5nines.com/teraform-kung-fu
# Copyright (c) 2020 Build5Nines.com
# MIT License - https://github.com/Build5Nines/terraform-kung-fu/blob/master/LICENSE
# WARNING: These scripts could either cause resume generating events or get you promoted.
# Please, proceed with extreme caution!
# #################################################################################
# PURPOSE:
# - 301 - Create a resource using a shared module. Take note that the module path
#         must be set correctly. Update the locals and variables.
# #################################################################################
# USAGE:
# - Run terraform in this directory to create the resource(s), make sure path to
#   the module is set correctly if moving the folders to your own project.
# #################################################################################
# HELPFUL RESOURCES:
# - https://build5nines.com/?s=terraform
# - https://www.terraform.io/docs/providers/azurerm/r/virtual_network.html
# #################################################################################

provider "azurerm" {
  # AzureRM provider 2.x
  version = "~>2.0"
  # v2.x required "features" block
  features {}
  # subscription_id = "YOUR_SUBSCRIPTION_ID_HERE" optional if using the CLI
  # tenant_id       = "YOUR_TENANT_ID_HERE" optional if using the CLI
}