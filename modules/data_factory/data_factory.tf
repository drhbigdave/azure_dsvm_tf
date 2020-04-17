resource "azurerm_resource_group" "vnet_infra" {
  name     = var.df_rg_name
  location = var.df_rg_location #TODO make this project-resource-attr common
}

resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnet1_name
  address_space       = var.vnet1_address_space
  location            = azurerm_resource_group.vnet_infra.location
  resource_group_name = azurerm_resource_group.vnet_infra.name
}

resource "azurerm_subnet" "vnet1_subnet1" {
  name                 = var.vnet1_subnet_name
  resource_group_name  = azurerm_resource_group.vnet_infra.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefix       = var.vnet1_subnet1_address_prefix1
}

/*
  # saving here for a presumed future need, not modded for my use yet
  provisioner "local-exec" {
    command = "az keyvault network-rule add --name ${data.terraform_remote_state.project.outputs.keyvault_name} --subnet ${azurerm_subnet.manage_subnet[count.index].id}"
  }
  */

resource "azurerm_network_security_group" "vnet1_nsg" {
  name                = var.vnet1_nsg_name
  location            = azurerm_resource_group.vnet_infra.location
  resource_group_name = azurerm_resource_group.vnet_infra.name

  tags = {
    environment = "standard_vm_vnet"
  }
}

resource "azurerm_network_security_rule" "vnet1_nsg1_outrule1" {
  name                        = "outbound"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.vnet_infra.name
  network_security_group_name = azurerm_network_security_group.vnet1_nsg.name
}

data "azurerm_key_vault" "infra_kv" {
  name                = var.infra_key_vault_name
  resource_group_name = var.permanent_infra_rg_name
}

data "azurerm_key_vault_secret" "davids_home_ip" {
  name         = var.davids_home_ip_secret_name
  key_vault_id = var.kv_id
}

data "azurerm_key_vault_secret" "shanikas_home_ip" {
  name         = var.shanikas_home_ip_secret_name
  key_vault_id = var.kv_id
}

resource "azurerm_network_security_rule" "vnet1_nsg1_inrule1" {
  name                        = "inbound_from_davids"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = data.azurerm_key_vault_secret.davids_home_ip.value
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.vnet_infra.name
  network_security_group_name = azurerm_network_security_group.vnet1_nsg.name
}

resource "azurerm_network_security_rule" "vnet1_nsg1_inrule2" {
  name                        = "inbound_from_shanikas"
  priority                    = 201
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = data.azurerm_key_vault_secret.shanikas_home_ip.value
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.vnet_infra.name
  network_security_group_name = azurerm_network_security_group.vnet1_nsg.name
}
