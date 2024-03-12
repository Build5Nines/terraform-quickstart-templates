terraform {
  required_providers {
    # AzureRM provider 3.x
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0.0"
    }
  }
}

variable "name" {
  type        = string
  description = "The name of the storage account."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account."
}

variable "location" {
  type        = string
  description = "The Azure location where the resource exists."
}

variable "account_kind" {
  type        = string
  default     = "StorageV2"
  description = "The Kind of account."
}

variable "account_tier" {
  type        = string
  description = "The Tier to use for this storage account."
}

variable "account_replication_type" {
  type        = string
  description = "The type of replication to use for this storage account."
}

variable "access_tier" {
  type        = string
  default     = "Hot"
  description = "The Access Tier for BlobStorage, FileStorage, and StorageV2 accounts."
}

variable "enable_https_traffic_only" {
  type        = bool
  default     = true
  description = "Flag specifying to force HTTPS if enabled."
}

variable "min_tls_version" {
  type        = string
  default     = "TLS1_2"
  description = "The minimum supported TLS version for the storage account."
}

variable "is_hns_enabled" {
  type        = bool
  default     = false
  description = "Flag specifying if Hierarchical Namespace is enabled."
}

variable "custom_domain" {
  type = object({
    name          = string
    use_subdomain = bool
  })
  default     = null
  description = "Block specifying the Custom Domain Name for the storage account."
}

variable "identity" {
  type = object({
    type = string
  })
  default     = null
  description = "Block specifying the identity type of the storage account."
}

variable "blob_properties_cors_rule" {
  type = object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  })
  default     = null
  description = "Block specifying the CORS Blob properties for the storage account."
}

variable "blob_properties_delete_retention_policy" {
  type = object({
    days = number
  })
  default     = null
  description = "Block specifying the Blob delete retention policy for the storage account."
}

variable "queue_properties_cors_rule" {
  type = object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  })
  default     = null
  description = "Block specifying the CORS Blob properties for the storage account."
}

variable "queue_properties_logging" {
  type = object({
    delete                = bool
    read                  = bool
    version               = string
    write                 = bool
    retention_policy_days = number
  })
  default     = null
  description = "Block specifying the "
}

variable "queue_properties_minute_metrics" {
  type = object({
    enabled               = bool
    version               = string
    include_apis          = bool
    retention_policy_days = number
  })
  default     = null
  description = "Block specifying the "
}

variable "queue_properties_hour_metrics" {
  type = object({
    enabled               = bool
    version               = string
    include_apis          = bool
    retention_policy_days = number
  })
  default     = null
  description = "Block specifying the "
}

variable "static_website" {
  type = object({
    index_document     = string
    error_404_document = string
  })
  default     = null
  description = "Block specifying the configuration for static websites on the storage account."
}

variable "large_file_share_enabled" {
  type        = bool
  default     = null
  description = "Flag specifying if Large File Share is enabled."
}

variable "network_rules" {
  type = object({
    default_action             = string
    bypass                     = list(string)
    ip_rules                   = list(string)
    virtual_network_subnet_ids = list(string)
  })
  default     = null
  description = "Block specifying the network rules for the storage account."
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "A mapping of the tags to assign to the resource."
}


resource azurerm_storage_account sa {
  name                      = var.name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_kind              = var.account_kind
  account_tier              = var.account_tier
  account_replication_type  = var.account_replication_type
  access_tier               = var.access_tier
  enable_https_traffic_only = var.enable_https_traffic_only
  min_tls_version           = var.min_tls_version
  is_hns_enabled            = var.is_hns_enabled

  dynamic "custom_domain" {
    for_each = var.custom_domain == null ? [] : [1]
    content {
      name          = var.custom_domain.name
      use_subdomain = var.custom_domain.use_subdomain
    }
  }

  dynamic "identity" {
    for_each = var.identity == null ? [] : [1]
    content {
      type = var.identity.type
    }
  }

  dynamic "blob_properties" {
    for_each = var.blob_properties_cors_rule == null && var.blob_properties_delete_retention_policy == null ? [] : [1]
    content {
      dynamic "cors_rule" {
        for_each = var.blob_properties_cors_rule == null ? [] : [1]
        content {
          allowed_headers    = lookup(var.blob_properties_cors_rule, "allowed_headers", null)
          allowed_methods    = lookup(var.blob_properties_cors_rule, "allowed_methods", null)
          allowed_origins    = lookup(var.blob_properties_cors_rule, "allowed_origins", null)
          exposed_headers    = lookup(var.blob_properties_cors_rule, "exposed_headers", null)
          max_age_in_seconds = lookup(var.blob_properties_cors_rule, "max_age_in_seconds", null)
        }
      }
      dynamic "delete_retention_policy" {
        for_each = var.blob_properties_delete_retention_policy == null ? [] : [1]
        content {
          days = lookup(var.blob_properties_delete_retention_policy, "days", null)
        }
      }
    }
  }

  dynamic "queue_properties" {
    for_each = var.queue_properties_cors_rule == null && var.queue_properties_logging == null && var.queue_properties_minute_metrics == null && var.queue_properties_hour_metrics == null ? [] : [1]
    content {
      dynamic "cors_rule" {
        for_each = var.queue_properties_cors_rule == null ? [] : [1]
        content {
          allowed_headers    = lookup(var.queue_properties_cors_rule, "allowed_headers", null)
          allowed_methods    = lookup(var.queue_properties_cors_rule, "allowed_methods", null)
          allowed_origins    = lookup(var.queue_properties_cors_rule, "allowed_origins", null)
          exposed_headers    = lookup(var.queue_properties_cors_rule, "exposed_headers", null)
          max_age_in_seconds = lookup(var.queue_properties_cors_rule, "max_age_in_seconds", null)
        }
      }
      dynamic "logging" {
        for_each = var.queue_properties_logging == null ? [] : [1]
        content {
          delete                = lookup(var.queue_properties_logging, "delete", null)
          read                  = lookup(var.queue_properties_logging, "read", null)
          version               = lookup(var.queue_properties_logging, "version", null)
          write                 = lookup(var.queue_properties_logging, "write", null)
          retention_policy_days = lookup(var.queue_properties_logging, "retention_policy_days", null)
        }
      }
      dynamic "minute_metrics" {
        for_each = var.queue_properties_minute_metrics == null ? [] : [1]
        content {
          enabled               = lookup(var.queue_properties_minute_metrics, "enabled", null)
          version               = lookup(var.queue_properties_minute_metrics, "version", null)
          include_apis          = lookup(var.queue_properties_minute_metrics, "include_apis", null)
          retention_policy_days = lookup(var.queue_properties_minute_metrics, "retention_policy_days", null)
        }
      }
      dynamic "hour_metrics" {
        for_each = var.queue_properties_hour_metrics == null ? [] : [1]
        content {
          enabled               = lookup(var.queue_properties_hour_metrics, "enabled", null)
          version               = lookup(var.queue_properties_hour_metrics, "version", null)
          include_apis          = lookup(var.queue_properties_hour_metrics, "include_apis", null)
          retention_policy_days = lookup(var.queue_properties_hour_metrics, "retention_policy_days", null)
        }
      }
    }
  }

  dynamic "static_website" {
    for_each = var.static_website == null ? [] : [1]
    content {
      index_document     = var.static_website.index_document
      error_404_document = var.static_website.error_404_document
    }
  }

  dynamic "network_rules" {
    for_each = var.network_rules == null ? [] : [1]
    content {
      default_action             = var.network_rules["default_action"] # required
      bypass                     = lookup(var.network_rules, "bypass", null)
      ip_rules                   = lookup(var.network_rules, "ip_rules", null)
      virtual_network_subnet_ids = lookup(var.network_rules, "virtual_network_subnet_ids", null)
    }
  }

  large_file_share_enabled = var.large_file_share_enabled

  tags = var.tags
}


output storage_account {
  value = azurerm_storage_account.sa
}