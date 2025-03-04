# CATALYST 8000v

resource "aws_instance" "c8000v" {
  ami               = var.image_id
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  user_data = templatefile("${path.module}/cloud_init.tftpl",
    {
      organization_name = var.organization_name
      vbond             = var.vbond
      vbond_port        = var.vbond_port
      hostname          = var.hostname
      uuid              = var.uuid
      otp               = var.otp
      site_id           = var.site_id
      system_ip         = var.system_ip
      transport_ip      = var.transport_ip
      service_ip        = var.service_ip
      admin_username    = var.username
      admin_password    = var.password
    }
  )

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.network_transport.id
  }

  network_interface {
    device_index         = 1
    network_interface_id = aws_network_interface.network_service.id
  }

  tags = {
    Name = "${var.hostname}"
  }

}

# SAVE BOOTSTRAP CONFIG TO A FILE

resource "local_file" "custom_data_file" {

  content = templatefile("${path.module}/cloud_init.tftpl",
    {
      organization_name = var.organization_name
      vbond             = var.vbond
      vbond_port        = var.vbond_port
      hostname          = var.hostname
      uuid              = var.uuid
      otp               = var.otp
      site_id           = var.site_id
      system_ip         = var.system_ip
      transport_ip      = var.transport_ip
      service_ip        = var.service_ip
      admin_username    = var.username
      admin_password    = var.password
    }
  )
  filename = "${path.module}/boostrap-${var.hostname}.txt"

}

# INTERFACES

resource "aws_network_interface" "network_transport" {
  subnet_id         = var.subnet_transport_id
  security_groups   = [var.security_group_transport_id]
  private_ips       = [var.transport_ip]
  source_dest_check = false
  description       = "transport"

  tags = {
    Name = "${var.hostname}-interface-transport"
  }
}

resource "aws_network_interface" "network_service" {
  subnet_id         = var.subnet_service_id
  security_groups   = [var.security_group_service_id]
  private_ips       = [var.service_ip]
  source_dest_check = false
  description       = "service"

  tags = {
    Name = "${var.hostname}-interface-service"
  }
}


# PUBLIC IP

resource "aws_eip" "c8000v_eip" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.network_transport.id
  associate_with_private_ip = tolist(aws_network_interface.network_transport.private_ips)[0]
  depends_on                = [aws_instance.c8000v]
  tags = {
    Name = "${var.hostname}-eip"
  }
}
