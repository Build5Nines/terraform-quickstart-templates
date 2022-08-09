
locals {
  primary_location   = "centralus"
  secondary_location = "eastus2"
}

module "rg_centralus" {
  source = "../../../modules/rg"

  location = local.primary_location
}

module "rg_eastus2" {
  source = "../../../modules/rg"

  location = local.secondary_location
}