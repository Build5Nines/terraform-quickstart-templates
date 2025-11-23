# #################################################################################
# Build5Nines: Terraform Quickstart Templates
# https://build5nines.com/teraform-quickstart-templates
# Copyright (c) 2023 Build5Nines LLC
# MIT License - https://github.com/Build5Nines/terraform-quickstart-templates/blob/master/LICENSE
# WARNING: These scripts could either cause resume generating events or get you promoted.
# Please, proceed with extreme caution!
# #################################################################################
# PURPOSE:
# - Create an Azure Front Door instance using Standard/Premium pricing
# #################################################################################
# USAGE:
# - Update the local variables to configure the resource
# #################################################################################
# HELPFUL RESOURCES:
# - 
# #################################################################################

terraform {
  required_providers {
    # AzureRM provider 2.x
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
    resource_group_name       = "b59_frontdoor"
        
    front_door_name           = "b50_front_door"
    front_door_sku            = "Standard_AzureFrontDoor" # "Premium_AzureFrontDoor"
    front_door_host_name      = "build5nines.com"
}


/*
Microsoft.Cdn/profiles
kind: 'frontdoor'
*/
resource azurerm_cdn_frontdoor_profile "primary" {
  name                = local.front_door_name
  resource_group_name = local.resource_group_name
  sku_name            = local.front_door_sku
}

/*
Microsoft.Cdn/profiles/afdendpoints
*/
resource azurerm_cdn_frontdoor_endpoint "primary" {
  name                     = "${local.front_door_name}-endpoint"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.primary.id
}

/*
Microsoft.Cdn/profiles/origingroups
*/
resource azurerm_cdn_frontdoor_origin_group "primary" {
  name                     = "default-origin-group"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.primary.id
  session_affinity_enabled = true

  # restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 10

  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Http"
    request_type        = "HEAD"
  }

  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }
}

/*
Microsoft.Cdn/profiles/customdomains
*/
resource azurerm_cdn_frontdoor_custom_domain "primary" {
  name                     = "default-domain"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.primary.id
  host_name                = local.front_door_host_name

  tls {
    # Use an Azure managed Certificate
    certificate_type    = "ManagedCertificate"
    minimum_tls_version = "TLS12"
  }
}

/*
Microsoft.Cdn/profiles/origingroups/origins
*/
resource azurerm_cdn_frontdoor_origin "primary" {
  name                          = "default-origin"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.primary.id
  enabled                       = true

  certificate_name_check_enabled = true

  host_name          = local.front_door_host_name
  http_port          = 80
  https_port         = 443
  origin_host_header = local.front_door_host_name
  priority           = 1
  weight             = 1000
}

/*
Microsoft.Cdn/profiles/afdendpoints/routes
*/
resource azurerm_cdn_frontdoor_route "primary" {
  name                          = "default-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.primary.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.primary.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.primary.id]
  cdn_frontdoor_rule_set_ids    = [azurerm_cdn_frontdoor_rule_set.primary.id]
  enabled                       = true

  forwarding_protocol    = "MatchRequest"
  https_redirect_enabled = true
  patterns_to_match      = ["/*"]
  supported_protocols    = ["Http", "Https"]

  cdn_frontdoor_custom_domain_ids = [
    azurerm_cdn_frontdoor_custom_domain.primary.id
  ]

  link_to_default_domain          = true

  cache {
    query_string_caching_behavior = "IgnoreSpecifiedQueryStrings"
    query_strings                 = ["account", "settings"]
    compression_enabled           = true
    content_types_to_compress     = ["text/html", "text/javascript", "text/xml"]
  }
}

resource azurerm_cdn_frontdoor_custom_domain_association "association" {
  cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.primary.id 
  cdn_frontdoor_route_ids        = [azurerm_cdn_frontdoor_route.primary.id]
}

/*
Microsoft.Cdn/profiles/rulesets
*/
resource azurerm_cdn_frontdoor_rule_set "primary" {
  name                     = "default"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.primary.id
}

/*
NEXT STEPS:
The next step would be to add 'azurerm_cdn_frontdoor_rule' resources to configure
routing rules for the Front Door instance.
*/