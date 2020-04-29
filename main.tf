module "permanent_infra" {
  source = "./environments/personal_infra/permanent_infra"
  #drh_object_id_environments = var.drh_object_id_environments_root
}
module "databricks" {
  source = "./environments/personal_infra/databricks"
}
module "synapse" {
  source = "./environments/personal_infra/synapse"
}

/*
module "dsvm" {
  source = "./environments/personal_infra/dsvm_with_networking
module "vnet_infra" {
  source = "./personal_infra/vnet_infra"
}
what happened to the df module?

*/

