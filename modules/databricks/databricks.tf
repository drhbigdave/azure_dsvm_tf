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
  }
}