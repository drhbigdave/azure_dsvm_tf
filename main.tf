#networking and rg in sh
/*
module "dsvm" {
  source = "./personal_infra/dsvm/dsvm"
}
module "vnet_infra" {
  source = "./personal_infra/vnet_infra"
}
*/
module "permanent_infra" {
  source = "./environments/personal/dsvm_with_networking"
}
