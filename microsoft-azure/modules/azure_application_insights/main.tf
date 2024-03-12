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

variable application_type {
  type        = string
  default     = "web"
  description = "Specifies the type of Application Insights to create."
}

variable tags {
  type        = map(string)
  default     = null
  description = "A mapping of the tags to assign to the resource."
}



resource azurerm_application_insights app_insights {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = var.application_type 
  tags                = var.tags
}


output app_insights {
  value = azurerm_application_insights.app_insights
}