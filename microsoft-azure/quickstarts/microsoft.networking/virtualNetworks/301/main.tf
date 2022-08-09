# #################################################################################
# Build5Nines: Terraform Quickstart Templates
# https://build5nines.com/teraform-quickstart-templates
# Copyright (c) 2022 Build5Nines.com, Chris Pietschmann
# MIT License - https://github.com/Build5Nines/terraform-quickstart-templates/blob/master/LICENSE
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

module "vnet_centralus" {
  source = "../../../modules/vnet"

  resource_group_name = module.rg_centralus.rg_name
  location            = local.primary_location
  vnet_address_space  = "172.16.0.0/16"
}

module "vnet_eastus2" {
  source = "../../../modules/vnet"

  resource_group_name = module.rg_eastus2.rg_name
  location            = local.secondary_location
  vnet_address_space  = "10.0.0.0/16"
}