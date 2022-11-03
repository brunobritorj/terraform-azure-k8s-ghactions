terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }

}

provider "azurerm" {
  features {}
}

# Create a Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.azResourceGroupName
  location = var.azLocation
}

# Deploy an ACR (Az Container Registry) registry
resource "azurerm_container_registry" "main" {
  depends_on = [ azurerm_resource_group.main ]
  name                = var.azAcrName
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"
  admin_enabled       = true
}

# Deploy an AKS (Az Kubernetes Service) cluster
resource "azurerm_kubernetes_cluster" "main" {
  depends_on = [ azurerm_container_registry.main ]
  name                = var.azAksName
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = var.azAksName
  node_resource_group = "RG-${var.azAksName}"
  default_node_pool {
    name            = "default"
    node_count      = var.azAksNodeCount
    vm_size         = var.azAksVmSize
    os_disk_size_gb = 30
  }
  identity {
    type = "SystemAssigned"
  }
}
