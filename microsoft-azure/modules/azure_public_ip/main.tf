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
    description = "The name of the storage account."
}

variable resource_group_name {
    type        = string
    description = "The name of the resource group in which to create the storage account."
}

variable location {
    type        = string
    description = "The Azure location where the resource exists."
}

variable sku {
    type        = string
    default     = null
    description = "The SKU of the Public IP."
}

variable allocation_method {
    type        = string
    default     = null
    description = "Defines the allocation method for this IP address."
}

variable domain_name_label {
    type        = string
    default     = null
}

variable tags {
    type        = map(string)
    default     = null
    description = "A mapping of the tags to assign to the resource."
}


resource azurerm_public_ip ip {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku                 = var.sku
  allocation_method   = var.allocation_method

  domain_name_label   = var.domain_name_label

  tags                = var.tags

}


output public_ip {
  value = azurerm_public_ip.ip
}