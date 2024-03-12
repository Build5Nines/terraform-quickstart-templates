terraform {
  required_providers {
    # AzureRM provider 3.x
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0.0"
    }
  }
}

variable resource_group_name {
  type        = string
  description = "The name of the resource group in which to create the resource(s)."
}

variable location {
  type        = string
  description = "The Azure location where the resource(s) exists."
}

variable name {
  type        = string
  description = "The name of the App Service Plan."
}

variable sku {
  type = object({
    size = string
    tier = string
  })
  default = {
    size = "S1"
    tier = "Standard"
  }
  description = "The sku for the App Service Plan"
}

variable tags {
  type        = map(string)
  default     = null
  description = "A mapping of the tags to assign to the resource."
}


resource azurerm_app_service_plan plan {
  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
  sku {
    size = var.sku.size
    tier = var.sku.tier
  }

  tags = var.tags
}


output plan {
  value = azurerm_app_service_plan.plan
}