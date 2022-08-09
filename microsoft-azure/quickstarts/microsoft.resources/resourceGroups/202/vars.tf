# #################################################################################
# Build5Nines: Terraform Kung-fu
# https://build5nines.com/teraform-kung-fu
# Copyright (c) 2020 Build5Nines.com
# MIT License - https://github.com/Build5Nines/terraform-kung-fu/blob/master/LICENSE
# WARNING: These scripts could either cause resume generating events or get you promoted.
# Please, proceed with extreme caution!
# #################################################################################
# PURPOSE:
# - 202 - Create a resource using locals and variables
# - Take note of the locations as a list of string. Adding a another region name to
#   the list will create another region. This is leveraging the count object 
#   and length function in rg.tf.
# #################################################################################
# USAGE:
# - Run terraform in this directory to create the resource(s)
# #################################################################################
# HELPFUL RESOURCES:
# - https://build5nines.com/?s=terraform
# - https://www.terraform.io/docs/providers/azurerm/r/resource_group.html
# #################################################################################
variable "locations" {
  type        = list(string)
  default     = ["centralus", "eastus", "eastus2", "westus"]
  description = "locations for the resource groups"
}