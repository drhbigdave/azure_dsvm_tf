resource "azurerm_resource_group" "databricks_rg" {
  name     = var.databricks_rg_name
  location = var.databricks_location
}

resource "azurerm_databricks_workspace" "databricks_workspace1" {
  name                = var.databricks_workspace1_name
  resource_group_name = azurerm_resource_group.databricks_rg.name
  location            = azurerm_resource_group.databricks_rg.location
  sku                 = var.databricks_workspace1_sku

  tags = {
    Environment = "personal"
    pluralsight_class = "Implementing a Databricks Environment in MS Aure"
    instructor = "Michael Bender"
    incurs_cost = "no"
  }
}

# adding this resource here rather than creating another as the lifecycle should 
# be the same
resource "azurerm_storage_account" "databricks_sa1" {
  name                     = var.databricks_sa1_name
  resource_group_name = azurerm_resource_group.databricks_rg.name
  location            = azurerm_resource_group.databricks_rg.location
  account_tier             = "Standard"
  account_replication_type = "ZRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "databricks_sa1_filesystem1" {
  name               = var.databricks_sa1_filesystem1_name
  storage_account_id = azurerm_storage_account.databricks_sa1.id

  properties = {
    hello = "aGVsbG8="
  }
}