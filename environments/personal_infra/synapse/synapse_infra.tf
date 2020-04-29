module "synapse" {
    source = "../../../modules/synapse"
    synapse_rg_name = "synapse"
    syapse_rg_location = "East US"
    synapse_sql_server_name = "databrickssql"
    synapse_sa_sql_database_name = "databrickssqldb"
    kv_id                         = module.permanent_infra.key_vault_id_out
}