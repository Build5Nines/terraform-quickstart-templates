# #################################################################################
# Build5Nines: Terraform Kung-fu
# https://build5nines.com/teraform-kung-fu
# Copyright (c) 2020 Build5Nines.com
# MIT License - https://github.com/Build5Nines/terraform-kung-fu/blob/master/LICENSE
# WARNING: These scripts could either cause resume generating events or get you promoted.
# Please, proceed with extreme caution!
# #################################################################################
# PURPOSE:
# - <fill in purpose>
# #################################################################################
# USAGE:
# - Update the variable to configure the resource
# #################################################################################
# HELPFUL RESOURCES:
# - <add-links>
# #################################################################################

variable "location" {
  type        = string
  description = "location for all resources"
}

variable "resource_group_name" {
  type = string
  description = "name of the resource group for all networking resources"
}

variable "vnet_address_space" {
  type = string
  description = "address spaces for vnet"
}