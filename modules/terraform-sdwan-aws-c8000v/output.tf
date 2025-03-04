# OUTPUT PARAMETERS

output "instance_details" {
  description = "Details of the C8000v instance"
  value = {
    public_ip    = aws_eip.c8000v_eip.public_ip
    transport_ip = aws_network_interface.network_transport.private_ip
    service_ip   = aws_network_interface.network_service.private_ip
  }
}
