module "synapse" {
    source = "../../../modules/synapse"
    synapse_rg_name = "synapse"
    syapse_rg_location = "East US"
    synapse_sql_server_name = "databrickssql"
    synapse_sa_sql_database_name = "databrickssqldb"
    sql_svradmin_login_name_secret = "sql-svradmin-login-name"
    sql_svradmin_login_password_secret = "sql-svradmin-login-password"
    permanent_infra_key_vault_name = "drh-infra-keyvault1"
    permanent_infra_rg_name = "permanent_infra"
    databricks_resource_group_name = "databricks_rg1"
}