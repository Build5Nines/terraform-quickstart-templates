# #################################################################################
# Build5Nines: Terraform Quickstart Templates
# https://build5nines.com/teraform-quickstart-templates
# Copyright (c) 2024 Build5Nines.com, Chris Pietschmann
# MIT License - https://github.com/Build5Nines/terraform-quickstart-templates/blob/master/LICENSE
# WARNING: These scripts could either cause resume generating events or get you promoted.
# Please, proceed with extreme caution!
# #################################################################################
# PURPOSE:
# - Create an Azure OpenAI Service Account
# #################################################################################
# USAGE:
# - Update the local variables to configure the resource
# #################################################################################
# HELPFUL RESOURCES:
# - https://build5nines.com/get-started-with-terraform-on-microsoft-azure/
# #################################################################################

terraform {
  required_providers {
    # AzureRM provider 3.x
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
    resource_group_name       = "b59_openai"
    location                  = "eastus2"
    
    openai_account_name       = "b59-oai"
    openai_sku                = "S0"
}

resource azurerm_cognitive_account azureopenai {
    name                = local.openai_account_name
    resource_group_name = local.resource_group_name
    location            = local.location
    kind                = "OpenAI"
    sku_name            = local.openai_sku
}