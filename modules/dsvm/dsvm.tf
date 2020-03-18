resource "azurerm_network_interface" "dsvm_int" {
  name                = var.network_interface_name
  location            = azurerm_resource_group.vnet_infra.location
  resource_group_name = azurerm_resource_group.vnet_infra.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vnet1_subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

data "azurerm_key_vault_secret" "dsvm_admin_password" {
  name         = var.dsvm_admin_password_secret_name
  key_vault_id = var.kv_id
  #vault_uri    = var.kv_uri
}

resource "azurerm_windows_virtual_machine" "dsvm_vm1" {
  name                = var.dsvm_vm1_name
  location            = azurerm_resource_group.vnet_infra.location
  resource_group_name = azurerm_resource_group.vnet_infra.name
  size                = var.vm_size
  admin_username      = var.adminuser_name
  admin_password      = data.azurerm_key_vault_secret.dsvm_admin_password.value
  network_interface_ids = [
    azurerm_network_interface.dsvm_int.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.vm_publisher
    offer     = var.vm_offer
    sku       = var.vm_sku
    version   = var.vm_version
  }
}
