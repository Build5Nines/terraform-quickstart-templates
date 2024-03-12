terraform {
  required_providers {
    # AzureRM provider 3.x
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3"
    }
  }
}

variable front_door_profile_id {
  type        = string
  description = "The Azure Resource ID of the Azure Front Door Profile"
}

variable host_name {
    type        = string
    description = "The Host Name of the Custom Domain."
}


/*
Microsoft.Cdn/profiles/customdomains
*/
resource azurerm_cdn_frontdoor_custom_domain "primary" {
  name                     = "default-domain"
  cdn_frontdoor_profile_id = var.front_door_profile_id
  host_name                = var.host_name

  tls {
    # Use an Azure managed Certificate
    certificate_type    = "ManagedCertificate"
    minimum_tls_version = "TLS12"
  }
}


output custom_domain {
  value = azurerm_cdn_frontdoor_custom_domain.primary
}