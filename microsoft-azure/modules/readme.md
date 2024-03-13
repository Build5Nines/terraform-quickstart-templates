# Azure Terraform Modules

These are reusable Terraform Modules for provisioning specific Microsoft Azure resources, using the `azurerm` Terraform provider.

## Example Usage

These Terraform Modules require using the `azurerm` provider version `3.x`. Including the following `required_providers` block is recommended in your Terraform project to be sure to use the correct Terraform version.

```terraform
# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
```

Here's a simple example of including one of these modules in a Terraform project. Simply use the `source` attribute on the `module` object in Terraform to specify which module to pull in and use.

```terraform
module "my_resource_group" {
    # Using HTTPS
    source = "github.com/Build5Nines/terraform-quickstart-templates.git//microsoft-azure/modules/azure_resource_group"

    name     = "name-rg"
    location = "eastus"
    tags     = {
        source = "terraform"
    }
}
```

> **Production Warning**: While you can reference these modules directly form your Terraform code, you will want to create your own Git repo or other source for the modules you use. You should not rely on the `main` branch of this repo for the modules you use in Production environments; as breaking changes could be made without notice.
