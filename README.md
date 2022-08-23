# Build5Nines: Terraform Quickstart Templates

This project contains quickstart templates to use for more easily building and learning [Terraform](https://build5nines.com/get-started-with-terraform-on-microsoft-azure/) for building [Intrastructure as Code (IaC)](https://build5nines.com/what-is-infrastructure-as-code/) deployments.

_Currently, the project is mostly focused on using the `azurerm` Terraform Provider for managing Microsoft Azure resources._

## Project Organization

This project contains helpful Terraform examples and templates that are organized in the following folder structure:

- **Microsoft Azure**
  - [`microsoft-azure`](microsoft-azure) - This is where the Microsoft Azure resource specific quickstarts and other templates reside.
    - [`microsoft-azure/quickstarts`](microsoft-azure/quickstarts) - These are sample Terraform templates that can be used to quickly provision single or sets of Microsoft Azure resources.
    - [`microsoft-azure/workloads`](microsoft-azure/workloads) - These are example Terraform workload templates that model specific workload deployments to Microsoft Azure.
- **Generic Terraform**
  - [`terraform-tips`](terraform-tips) - This is where helpful tips and best practice examples of Terraform code that are not cloud provider specific are located.

## Related Helpful Articles

The following are a few helpful related articles to working with Terraform code. These range from "introduction" content to a little more in depth:

- [Get Started with Terraform on Azure](https://build5nines.com/get-started-with-terraform-on-microsoft-azure/) by Chris Pietschmann
- [Terraform: Overview of Azure Providers and Tools](https://build5nines.com/terraform-overview-of-azure-providers-and-tools/) by Chris Pietschmann
- [Terraform Modules: Create Reusable Infrastructure as Code](https://build5nines.com/terraform-modules-create-reusable-infrastructure-as-code/) by Chris Pietschmann
- [Terraform Feature Flags and Environment Toggle Design Patterns](https://build5nines.com/terraform-feature-flags-environment-toggle-design-patterns/) by Chris Pietschmann
- [Terraform: Create Azure IoT Hub and Device Provisioning Service (DPS)](https://build5nines.com/terraform-create-azure-iot-hub-and-dps/) by Chris Pietschmann
- [Terraform: Create an Azure Kubernetes Cluster](https://build5nines.com/terraform-create-an-aks-cluster/) by Jim Counts
