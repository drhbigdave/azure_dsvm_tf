module "permanent_infra" {
  source                          = "../../../modules/permanent_infra"
  permanent_infra_rg_name         = "permanent_infra"
  permanent_infra_rg_location     = "East US"
  infra_kv1_name                  = "drh-infra-keyvault1"
  #drh_object_id = var.drh_object_id_environments
  remote_state_sa_name            = "drhremotestate"
  remote_state_sa_container1_name = "tf-remote-state"
  davids_home_ip_secret_name      = "davids-home-ip"
  shanikas_home_ip_secret_name    = "shanikas-home-ip"
}