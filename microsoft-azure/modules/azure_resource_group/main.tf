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
    description = "Name for the resource group."
}

variable location {
    type        = string
    description = "Location of the resource group."
}

variable tags {
    type        = map(string)
    default     = null
    description = "A mapping of the tags to assign to the resource."
}


resource azurerm_resource_group rg {
    location = var.location
    name     = var.name
    tags     = var.tags
}


output resource_group {
  value = azurerm_resource_group.rg
}
