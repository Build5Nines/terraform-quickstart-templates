terraform {
  required_providers {
    # AzureRM provider 3.x
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0.0"
    }
  }
}

provider "azurerm" {

}