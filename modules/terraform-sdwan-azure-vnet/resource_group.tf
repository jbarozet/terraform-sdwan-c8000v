# RESOURCE GROUP

resource "azurerm_resource_group" "instance" {
  name     = "${var.name}-rg"
  location = var.location
}
