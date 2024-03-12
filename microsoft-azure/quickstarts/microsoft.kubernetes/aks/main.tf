# #################################################################################
# Build5Nines: Terraform Quickstart Templates
# https://build5nines.com/teraform-quickstart-templates
# Copyright (c) 2022 Build5Nines.com, Chris Pietschmann
# MIT License - https://github.com/Build5Nines/terraform-quickstart-templates/blob/master/LICENSE
# WARNING: These scripts could either cause resume generating events or get you promoted.
# Please, proceed with extreme caution!
# #################################################################################
# PURPOSE:
# - Create a Kubernetes cluster on Azure with the Azure Kubernetes Service
# #################################################################################
# USAGE:
# - Update the local variables to configure the resource
# #################################################################################
# HELPFUL RESOURCES:
# - <add-links>
# #################################################################################

terraform {
  # Use a recent version of Terraform
  required_version = ">= 0.13"

  # Map providers to thier sources, required in Terraform 13+
  required_providers {
    # Azure Active Directory 1.x
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 1.0"
    }
    # Azure Resource Manager 3.x
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
    # Random 3.x
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider azurerm {
  # v2.x required "features" block
  features {}
}

locals {
  aks_cluster_name    = "aks-${local.resource_group_name}"
  location            = "centralus"
  resource_group_name = "b59"
}

resource "random_pet" "primary" {}