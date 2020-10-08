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

locals {
  primary_location   = "centralus"
  secondary_location = "eastus2"
}

module "rg_centralus" {
  source = "../../../modules/rg"

  location = local.primary_location
}

module "rg_eastus2" {
  source = "../../../modules/rg"

  location = local.secondary_location
}