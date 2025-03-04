# OUTPUT PARAMETERS

output "vpc_id" {
  value = aws_vpc.instance.id
}

output "subnet_transport_id" {
  value = aws_subnet.transport.id
}

output "subnet_service_id" {
  value = aws_subnet.service.id
}

output "security_group_transport_id" {
  value = aws_security_group.transport.id
}

output "security_group_service_id" {
  value = aws_security_group.service.id
}
