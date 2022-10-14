# AzureRM Terraform Modules

These are reusable Terraform Modules for provisioning specific Microsoft Azure resources.

## Use these Modules

Here's a simple example of using one of these modules in a Terraform project. Simply use the `source` attribute on the `module` object in Terraform to specify which module to pull in and use.

```terraform
module "my_resource_group" {
    # Using HTTPS
    source = "github.com/Build5Nines/terraform-quickstart-templates.git//microsoft-azure/modules/azure_resource_group"

    name = "name-rg"
    location = "eastus"
    tags = {
        source = "terraform"
    }
}
```
