# #################################################################################
# Build5Nines: Terraform Quickstart Templates
# https://build5nines.com/teraform-quickstart-templates
# Copyright (c) 2022 Build5Nines.com, Chris Pietschmann
# MIT License - https://github.com/Build5Nines/terraform-quickstart-templates/blob/master/LICENSE
# WARNING: These scripts could either cause resume generating events or get you promoted.
# Please, proceed with extreme caution!
# #################################################################################
# PURPOSE:
# - Setup an Azure ExpressRoute with VNet Gateway
# #################################################################################
# USAGE:
# - Update the local variables to configure the resource
# #################################################################################
# HELPFUL RESOURCES:
# - https://build5nines.com/terraform-deploy-azure-expressroute-circuit-with-vnet-gateway/
# #################################################################################

locals {
    # Azure region to deploy to
    azure_region = "eastus"

    # define the Azure resource names
    resource_name_prefix = "E1-B59-PRD-NET" # {region}-{org}-{env}-{app}

    # set of common tags to apply to all Azure resources
    tags = {
        source = "terraform"
    }
}
