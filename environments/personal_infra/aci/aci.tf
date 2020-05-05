module "aci" {
  source                = "../../../modules/aci/"
  container_rg_name     = "aci-rg"
  container_rg_location = "East US"
  container_group1_name = "ac1-cg1"

  ip_address_type = "Public"
  dns_name_label  = "drhaci"
  os_type         = "Linux"

  container_group1_count = 0
  container_name         = "drh-busybox-date"
  container_image        = "drhbigdave/test_image:latest"
}
