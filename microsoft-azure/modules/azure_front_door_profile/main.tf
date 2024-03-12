terraform {
  required_providers {
    # AzureRM provider 3.x
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3"
    }
  }
}

variable name {
    type        = string
    description = "The name of the Front Door."
}

variable resource_group_name {
    type        = string
    description = "The name of the resource group in which to create the Front Door."
}

variable sku {
    type        = string
    description = "The SKU for the Front Door"
    default     = "Standard_AzureFrontDoor"

    validation {
        condition     = var.sku == "Standard_AzureFrontDoor" || var.sku == "Premium_AzureFrontDoor"
        error_message = "SKU must be either 'Standard_AzureFrontDoor' or 'Premium_AzureFrontDoor'."
    }
}



/*
Microsoft.Cdn/profiles
kind: 'frontdoor'
*/
resource azurerm_cdn_frontdoor_profile "primary" {
  name                = var.name
  resource_group_name = var.resource_group_name
  sku_name            = var.sku
}

/*
Microsoft.Cdn/profiles/afdendpoints
*/
resource azurerm_cdn_frontdoor_endpoint "primary" {
  name                     = "${var.name}-endpoint"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.primary.id
}




output front_door_profiile {
    value = azurerm_cdn_frontdoor_profile.primary
}

output front_door_endpoint {
    value = azurerm_cdn_frontdoor_endpoint.primary
}