locals {
  vnet_mgt_cidr = "10.0.1.0/24"
}

output "subnets" {
  value = [
    {
      name = "subnet1"
      cidr = cidrsubnet(local.vnet_mgt_cidr, 4, 0)
    },
    {
      name = "subnet2"
      cidr = cidrsubnet(local.vnet_mgt_cidr, 4, 1)
    },
    {
      name = "subnet2"
      cidr = cidrsubnet(local.vnet_mgt_cidr, 4, 4)
    },
  ]
}