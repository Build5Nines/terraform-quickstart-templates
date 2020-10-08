locals {
  vnet_mgt_cidr = "172.16.0.0/16"
}

output "subnets" {
  value = [
    {
      name = "subnet1"
      cidr = cidrsubnet(local.vnet_mgt_cidr, 8, 0)
    },
    {
      name = "subnet2"
      cidr = cidrsubnet(local.vnet_mgt_cidr, 6, 1)
    },
  ]
}