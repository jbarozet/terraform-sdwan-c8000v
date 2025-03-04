# OUTPUT PARAMETERS

output "vnet_id" {
  value = azurerm_virtual_network.instance.id
}

output "subnet_transport_id" {
  value = azurerm_subnet.transport.id
}

output "subnet_service_id" {
  value = azurerm_subnet.service.id
}

output "security_group_transport_id" {
  value = azurerm_network_security_group.transport.id
}

output "security_group_service_id" {
  value = azurerm_network_security_group.service.id
}

output "resource_group_location" {
  value = azurerm_resource_group.instance.location
}

output "resource_group_name" {
  value = azurerm_resource_group.instance.name
}
