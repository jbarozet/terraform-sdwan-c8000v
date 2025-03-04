# SUBNETS

resource "azurerm_subnet" "transport" {
  name                 = "${var.name}-subnet-transport"
  resource_group_name  = azurerm_resource_group.instance.name
  virtual_network_name = azurerm_virtual_network.instance.name
  address_prefixes     = [var.subnet_transport_prefix]
}

resource "azurerm_subnet" "service" {
  name                 = "${var.name}-subnet-service"
  resource_group_name  = azurerm_resource_group.instance.name
  virtual_network_name = azurerm_virtual_network.instance.name
  address_prefixes     = [var.subnet_service_prefix]
}
