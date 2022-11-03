terraform {
  backend "azurerm" {}
}

module "azure" {
  source                  = "./modules/azure"
  azLocation              = var.azLocation
  azResourceGroupName     = var.azResourceGroupName
  azAcrName               = var.azAcrName
  azAksName               = var.azAksName
  azAksNodeCount          = var.azAksNodeCount
  azAksVmSize             = var.azAksVmSize
}

module "kubernetes" {
  source                  = "./modules/kubernetes"
  namespaces              = var.stages
  host                    = module.azure.kube_config.host
  client_certificate      = module.azure.kube_config.client_certificate
  client_key              = module.azure.kube_config.client_key
  cluster_ca_certificate  = module.azure.kube_config.cluster_ca_certificate
  registry_name           = module.azure.acr_login_data.name
  registry_server         = module.azure.acr_login_data.login_server
  registry_username       = module.azure.acr_login_data.admin_username
  registry_password       = module.azure.acr_login_data.admin_password
}