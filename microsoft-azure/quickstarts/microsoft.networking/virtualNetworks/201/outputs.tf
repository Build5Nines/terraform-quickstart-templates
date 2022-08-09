

output "vnet_id" {
  value = azurerm_virtual_network.b59s_vnet.id
}

output "subnets_id" {
  value = [azurerm_subnet.apps_subnet.id, azurerm_subnet.data_subnet.id]
}


