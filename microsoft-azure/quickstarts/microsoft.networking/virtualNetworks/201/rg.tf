


resource "azurerm_resource_group" "b59s_rg" {
  location = var.location
  name     = "${local.prefix}-rg"
}