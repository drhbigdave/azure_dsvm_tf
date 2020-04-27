module "databricks" {
    source = "../../../modules/databricks/"
    databricks_rg_name = "databricks_rg1"
    databricks_location = "East US"
    databricks_workspace1_name = "databricks_ps_workspace1" # 3 - 30 chars, Alphanumerics, underscores, and hyphens
    databricks_workspace1_sku = "premium"
}