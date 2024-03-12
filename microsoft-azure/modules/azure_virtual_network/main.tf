terraform {
  required_providers {
    # AzureRM provider 3.x
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0.0"
    }
  }
}


variable name {
  type        = string
  description = "Name of vnet."
}

variable location {
  type        = string
  description = "Location of vnet."
}

variable resource_group_name {
  type        = string
  description = "Name of the resource group for vnet."
}

variable vnet_address_spaces {
  type        = list(string)
  description = "Address space(s) for vnet."
}

variable tags {
  type        = map(string)
  default     = null
  description = "A mapping of the tags to assign to the resource."
}


resource azurerm_virtual_network vnet {
  address_space       = var.vnet_address_spaces
  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}


output virtual_network {
  value = azurerm_virtual_network.vnet
}