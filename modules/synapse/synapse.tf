resource "azurerm_resource_group" "synapse_rg" {
  name     = var.synapse_rg_name
  location = var.syapse_rg_location
}

data "azurerm_key_vault_secret" "sql_svradmin_login_name" {
  name         = var.sql_svradmin_login_name_secret
  key_vault_id = var.keyvault
}

data "azurerm_key_vault_secret" "sql_svradmin_login_password" {
  name         = var.sql_svradmin_login_password_secret
  key_vault_id = var.kv_id
}

resource "azurerm_sql_server" "synapse_sql_server" {
  name                         = var.synapse_sql_server_name
  resource_group_name          = azurerm_resource_group.synapse_rg.name
  location                     = azurerm_resource_group.synpse_rg.location
  version                      = "12.0"
  administrator_login          = data.azurerm_keyvault_secret.sql_svradmin_login_name.value
  administrator_login_password = data.azurerm_keyvault_secret.sql_svradmin_login_password.value

  tags = {
    environment = "pluralsight"
  }
}
/*
resource "azurerm_storage_account" "synapse_sa" {
  name                     = var.synapse_sa_name
  resource_group_name      = azurerm_resource_group.synapse_rg.name
  location                 = azurerm_resource_group.synapse_rg.location
  account_tier             = "Standard"
  account_replication_type = var.synapse_sa_replication_type
}
*/
resource "azurerm_sql_database" "synapse_sa_sql_database" {
  name                = var.synapse_sa_sql_database_name
  resource_group_name = azurerm_resource_group.synapse_rg.name
  location            = azurerm_resource_group.synapse_rg.location
  server_name         = azurerm_sql_server.synapse_sql_server.name
  create_mode = "Default"
  edition = "DataWarehouse"
/*
  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.synapse_sa.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.synapse_sa.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }
*/


  tags = {
    environment = "pluralsight"
  }
}