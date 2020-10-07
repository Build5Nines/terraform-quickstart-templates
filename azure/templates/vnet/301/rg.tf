# #################################################################################
# Build5Nines: Terraform Kung-fu
# https://build5nines.com/teraform-kung-fu
# Copyright (c) 2020 Build5Nines.com
# MIT License - https://github.com/Build5Nines/terraform-kung-fu/blob/master/LICENSE
# WARNING: These scripts could either cause resume generating events or get you promoted.
# Please, proceed with extreme caution!
# #################################################################################
# PURPOSE:
# - <fill in purpose>
# #################################################################################
# USAGE:
# - Update the local variables to configure the resource
# #################################################################################
# HELPFUL RESOURCES:
# - <add-links>
# #################################################################################

locals {
  primary_location   = "centralus"
  secondary_location = "eastus2"
}

module "rg_centralus" {
  source = "./modules/rg"

  location = local.primary_location
}

module "rg_eastus2" {
  source = "./modules/rg"

  location = local.secondary_location
}