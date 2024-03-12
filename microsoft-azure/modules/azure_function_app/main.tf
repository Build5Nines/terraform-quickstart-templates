terraform {
  required_providers {
    # AzureRM provider 3.x
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0.0"
    }
  }
}


variable name { type = string }

variable location { type = string }

variable resource_group_name { type = string}

variable storage_account {
  type = object({
    name = string
    primary_access_key = string
  })
}

variable app_service_plan_id { type = string }

variable always_on {
  type = bool
  default = true
}

variable app_settings { type = map(string) }

variable runtime_version {
    type = string
    default = "~3"
}

variable tags {
    type        = map(string)
    default     = null
    description = "A mapping of the tags to assign to the resource."
}


resource azurerm_function_app app {
  app_service_plan_id = var.app_service_plan_id
  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name

  storage_account_name       = var.storage_account.name
  storage_account_access_key = var.storage_account.primary_access_key

  site_config {
    always_on = var.always_on
  }

  version      = var.runtime_version
  app_settings = var.app_settings

  tags = var.tags
}


output app {
  value = azurerm_function_app.app
}