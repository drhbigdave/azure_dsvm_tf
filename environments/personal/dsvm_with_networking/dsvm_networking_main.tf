module "dsvm" {
  source = "../../../modules/dsvm"
  #kv_uri                        = module.permanent_infra.key_vault_uri_out
  rg_vnet1_name                 = "vm_infra"
  rg_vnet1_location             = "East US"
  vnet1_name                    = "study_vm_infrastructure"
  vnet1_subnet_name             = "vm_subnet_dot2"
  vnet1_address_space           = ["10.0.0.0/16"]
  vnet1_subnet1_address_prefix1 = "10.0.2.0/24"
  infra_key_vault_name          = module.permanent_infra.key_vault_name_out #"drh-infra-keyvault1" #module.permanent_infra.azurerm_key_vault.kv1.name
  permanent_infra_rg_name       = module.permanent_infra.permanent_infra_rg_name_out
  kv_id                         = module.permanent_infra.key_vault_id_out
  vnet1_nsg_name                = "home_access"
  davids_home_ip_secret_name    = "davids-home-ip"
  shanikas_home_ip_secret_name  = "shanikas-home-ip"
  # keep networking above for easy re-use for other VMs, VM below
  network_interface_name          = "dsvm01-nic0"
  dsvm_admin_password_secret_name = "dsvm-admin-password"
  dsvm_count                      = 1
  dsvm_vm1_name                   = "dsvm01"
  vm_size                         = "Standard_B4ms"   #Standard_DS3_v2
  vm_os_disk_sa_type              = "StandardSSD_LRS" #Standard_LRS, StandardSSD_LRS and Premium_LRS
  adminuser_name                  = "dsvmadmin0"
  #vm_publisher                    = "microsoft-dsvm"
  #vm_offer                        = "dsvm-win-2019"
  #vm_sku                          = "server-2019-g2"
  #vm_version                      = "latest"
  vm_publisher = "MicrosoftWindowsServer"
  vm_offer     = "WindowsServer"
  vm_sku       = "2019-datacenter-gensecond"
  vm_version   = "latest"
}

module "permanent_infra" {
  source                          = "../../../modules/permanent_infra"
  permanent_infra_rg_name         = "permanent_infra"
  permanent_infra_rg_location     = "East US"
  infra_kv1_name                  = "drh-infra-keyvault1"
  remote_state_sa_name            = "drhremotestate"
  remote_state_sa_container1_name = "tf-remote-state"
  davids_home_ip_secret_name      = "davids-home-ip"
  shanikas_home_ip_secret_name    = "shanikas-home-ip"
}
