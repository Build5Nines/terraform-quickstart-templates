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

module "vnet_centralus" {
  source = "./modules/vnet"

  resource_group_name = module.rg_centralus.rg_name
  location            = local.primary_location
  vnet_address_space  = "172.16.0.0/16"
}

module "vnet_eastus2" {
  source = "./modules/vnet"

  resource_group_name = module.rg_eastus2.rg_name
  location            = local.secondary_location
  vnet_address_space  = "10.0.0.0/16"
}