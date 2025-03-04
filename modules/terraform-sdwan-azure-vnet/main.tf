# VNET DEFINITION

resource "azurerm_virtual_network" "instance" {
  name                = "${var.name}-vnet"
  address_space       = [var.address_space]
  location            = azurerm_resource_group.instance.location
  resource_group_name = azurerm_resource_group.instance.name

  tags = {
    Name = "${var.name}-vnet"
  }

}
