resource "azurerm_resource_group" "container_rg" {
  name     = var.container_rg_name
  location = var.container_rg_location
}

resource "azurerm_container_group" "container_group1" {
  count               = var.container_group1_count
  name                = var.container_group1_name
  location            = azurerm_resource_group.container_rg.location
  resource_group_name = azurerm_resource_group.container_rg.name
  ip_address_type     = var.ip_address_type
  dns_name_label      = var.dns_name_label
  os_type             = var.os_type

  container {
    name   = var.container_name
    image  = var.container_image
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 8080
      protocol = "TCP"
    }
  }

  tags = {
    environment = "testing"
  }
}
