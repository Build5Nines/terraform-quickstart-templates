# #################################################################################
# Build5Nines: Terraform Quickstart Templates
# https://build5nines.com/teraform-quickstart-templates
# Copyright (c) 2025 Build5Nines.com, Chris Pietschmann
# MIT License - https://github.com/Build5Nines/terraform-quickstart-templates/blob/master/LICENSE
# WARNING: These scripts could either cause resume generating events or get you promoted.
# Please, proceed with extreme caution!
# #################################################################################
# PURPOSE:
# - Set up the foundation for a multi-region Azure deployment with consistent naming conventions
# #################################################################################
# USAGE:
# - Update the local variables to configure the resource
# #################################################################################
# HELPFUL RESOURCES:
# - https://github.com/build5nines/terraform-azure-naming
# #################################################################################


locals {
  # Define the organization abbreviation for naming conventions
  organization_abbreviation = "b59"

  # Define suffixes for different workload types
  # These will be appended to the names created by the naming module
  # according to the naming convention defined
  # e.g., Resource Group name for Networking resources --> rg-b59-eus-prod-net
  workload_suffix = {
    networking = "net"
    database   = "db"
    app        = "app"
  }

  tags = {
    Environment = var.environment
    Project     = "Multi-Region Naming"
    Management  = "Terraform"
  }

  primary_tags = merge(
    local.tags,
    {
      Region = "Primary"
    }
  )

  secondary_tags = merge(
    local.tags,
    {
      Region = "Secondary"
    }
  )
}


# Define the Primary Azure Region and Naming Convention
module "azure_primary" {
  source       = "Build5Nines/naming/azure"
  organization = local.organization_abbreviation
  environment  = var.environment
  location     = var.location

  # Define naming convention pattern
  name_suffix = ["{org}", "{loc}", "{env}"]
  # Example output: {abbr}-b59-eus-prod
  # where {org}=b59, {loc}=var.location, {env}=prod
  # You can customize the pattern as needed
  # If 'var.location' is 'eastus', then Resource Group name example: rg-b59-eus-prod
}

# Define the Secondary Azure Region and Naming Convention
# based on the Secondary Location (aka Azure Region Pair) of the
# Primary Location.
module "azure_secondary" {
  source       = "Build5Nines/naming/azure"
  organization = module.azure_primary.organization
  environment  = module.azure_primary.environment
  location     = module.azure_primary.location_secondary
  name_suffix  = module.azure_primary.base_suffix
  # This uses the same naming convention as the primary region
  # while targeting the Azure Region Pair for the secondary location
  # Resource Group name example: rg-b59-wus-prod
}

