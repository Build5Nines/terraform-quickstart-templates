# Build5Nines: Terraform Quickstart Templates

This project contains quickstart templates to use for more easily building and learning [Terraform](https://build5nines.com/get-started-with-terraform-on-microsoft-azure/) for building [Intrastructure as Code (IaC)](https://build5nines.com/what-is-infrastructure-as-code/) deployments.

## Project Organization

This project contains helpful Terraform examples and templates that are organized in the following folder structure:

- **Cloud Infrastructure**
  - **[Microsoft Azure](microsoft-azure/readme.md)** - This is where the Microsoft Azure resource specific quickstarts and other templates reside. _The `azurerm` provider is primarily used._
    - [Modules](microsoft-azure/modules/readme.md) - These are reusable Terraform Modules for provisioning specific Microsoft Azure resources.
    - [Quickstarts](microsoft-azure/quickstarts/readme.md) - These are sample Terraform templates that can be used to quickly provision single or sets of Microsoft Azure resources.
    - [Workloads](microsoft-azure/workloads/readme.md) - These are example Terraform workload templates that model specific workload deployments to Microsoft Azure.
- **Generic Terraform**
  - [Terraform Tips](terraform-tips/readme.md) - This is where helpful tips and best practice examples of Terraform code that are not cloud provider specific are located.

## Related Helpful Articles

The following are a few helpful related articles to working with Terraform code. These range from "introduction" content to a little more in depth:

- [Get Started with Terraform on Azure](https://build5nines.com/get-started-with-terraform-on-microsoft-azure/) by Chris Pietschmann
- [Terraform: Overview of Azure Providers and Tools](https://build5nines.com/terraform-overview-of-azure-providers-and-tools/) by Chris Pietschmann
- [Terraform Modules: Create Reusable Infrastructure as Code](https://build5nines.com/terraform-modules-create-reusable-infrastructure-as-code/) by Chris Pietschmann
- [Terraform Feature Flags and Environment Toggle Design Patterns](https://build5nines.com/terraform-feature-flags-environment-toggle-design-patterns/) by Chris Pietschmann
- [Terraform: Create Azure IoT Hub and Device Provisioning Service (DPS)](https://build5nines.com/terraform-create-azure-iot-hub-and-dps/) by Chris Pietschmann
