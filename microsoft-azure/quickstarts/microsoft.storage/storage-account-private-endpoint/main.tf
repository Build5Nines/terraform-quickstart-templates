# #################################################################################
# Build5Nines: Terraform Quickstart Templates
# https://build5nines.com/teraform-quickstart-templates
# Copyright (c) 2024 Build5Nines.com, Chris Pietschmann
# MIT License - https://github.com/Build5Nines/terraform-quickstart-templates/blob/master/LICENSE
# WARNING: These scripts could either cause resume generating events or get you promoted.
# Please, proceed with extreme caution!
# #################################################################################
# PURPOSE:
# - Create an Azure Storage Account with Private Endpoint connection to a VNet/Subnet
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
      version = "~>3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
    resource_group_name       = "b59_storage"
    location                  = "eastus"
    
    storage_account_name      = "b59storagewebsite"
    account_kind              = "StorageV2"
    account_tier              = "Standard"
    account_replication_type  = "LRS"
    enable_https_traffic_only = true

    vnet_name             = "b59-vnet"
    subnet_name           = "ple"
    private_endpoint_name = "b59-ple-blob"
}

# Create a resource group
resource azurerm_resource_group "primary" {
  name     = local.resource_group_name
  location = local.location
}

# Create an Azure Storage Account
resource azurerm_storage_account "primary" {
  name                      = local.storage_account_name
  resource_group_name       = azurerm_resource_group.primary.name
  location                  = azurerm_resource_group.primary.location
  account_kind              = local.account_kind
  account_tier              = local.account_tier
  account_replication_type  = local.account_replication_type
  enable_https_traffic_only = local.enable_https_traffic_only

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [azurerm_subnet.primary.id]
    bypass                     = ["None"]
    ip_rules                   = []
  }
}


resource azurerm_virtual_network "primary" {
  name                = local.vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.primary.location
  resource_group_name = azurerm_resource_group.primary.name
}

resource azurerm_subnet "primary" {
  name                 = local.subnet_name
  resource_group_name  = azurerm_resource_group.primary.name
  virtual_network_name = azurerm_virtual_network.primary.name
  address_prefixes     = ["10.0.1.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
}

resource azurerm_private_endpoint "primary" {
  name                = local.private_endpoint_name
  location            = azurerm_resource_group.primary.location
  resource_group_name = azurerm_resource_group.primary.name
  subnet_id           = azurerm_subnet.primary.id

  private_service_connection {
    name                           = "${local.private_endpoint_name}-connection"
    private_connection_resource_id = azurerm_storage_account.primary.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}

resource azurerm_private_dns_zone "primary" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.primary.name
}

resource azurerm_private_dns_zone_virtual_network_link "primary" {
  name                  = "b59-vnet-link"
  resource_group_name   = azurerm_resource_group.primary.name
  private_dns_zone_name = azurerm_private_dns_zone.primary.name
  virtual_network_id    = azurerm_virtual_network.primary.id
}

resource azurerm_private_dns_a_record "primary" {
  name                = azurerm_storage_account.primary.name
  zone_name           = azurerm_private_dns_zone.primary.name
  resource_group_name = azurerm_resource_group.primary.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.primary.private_service_connection[0].private_ip_address]
}