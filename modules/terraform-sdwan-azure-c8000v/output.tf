# OUTPUT PARAMETERS

output "instance_details" {
  description = "Details of the C8000v instance"
  value = {
    public_ip    = azurerm_public_ip.transport_public_ip.ip_address
    transport_ip = azurerm_network_interface.network_transport.private_ip_address
    service_ip   = azurerm_network_interface.network_service.private_ip_address
  }
}
