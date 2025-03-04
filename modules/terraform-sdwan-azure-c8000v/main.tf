# CATALYST 8000v

resource "azurerm_linux_virtual_machine" "c8000v" {
  name                            = var.hostname
  location                        = var.resource_group_location
  resource_group_name             = var.resource_group_name
  size                            = var.vm_size
  admin_username                  = var.username
  admin_password                  = var.password
  disable_password_authentication = false
  custom_data = base64encode(templatefile("${path.module}/cloud_init.tftpl",
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
  )

  network_interface_ids = [
    azurerm_network_interface.network_transport.id,
    azurerm_network_interface.network_service.id,
  ]

  plan {
    name      = var.image_sku   // This should match the SKU in source image reference
    product   = var.image_offer // This should match the offer in source image reference
    publisher = "cisco"
  }

  os_disk {
    name                 = "${var.hostname}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
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
  })
  filename = "${path.module}/bootstrap-${var.hostname}.txt"
}

# PUBLIC IP

resource "azurerm_public_ip" "transport_public_ip" {
  name                = "${var.hostname}-public-ip"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    Name = "${var.hostname}-public-ip"
  }
}

# INTERFACES

resource "azurerm_network_interface" "network_transport" {
  name                = "${var.hostname}-nic-transport"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.hostname}-transport"
    subnet_id                     = var.subnet_transport_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.transport_ip
    public_ip_address_id          = azurerm_public_ip.transport_public_ip.id
  }

  tags = {
    Name = "${var.hostname}-interface-transport"
  }
}

resource "azurerm_network_interface" "network_service" {
  name                = "${var.hostname}-nic-service"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.hostname}-service"
    subnet_id                     = var.subnet_service_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.service_ip
  }

  tags = {
    Name = "${var.hostname}-interface-service"
  }
}

# NETWORK INTERFACE SECURITY GROUP ASSOCIATIONS

resource "azurerm_network_interface_security_group_association" "transport_nsg_association" {
  network_interface_id      = azurerm_network_interface.network_transport.id
  network_security_group_id = var.security_group_transport_id
}

resource "azurerm_network_interface_security_group_association" "service_nsg_association" {
  network_interface_id      = azurerm_network_interface.network_service.id
  network_security_group_id = var.security_group_service_id
}
