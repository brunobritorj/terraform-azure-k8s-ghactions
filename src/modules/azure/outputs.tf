# Return ACR login data
output "acr_login_data" {
  depends_on = [ azurerm_container_registry.main ]
  description = "Login details to authentiticate on container registry"
  value = tomap({
    "name"            = azurerm_container_registry.main.name
    "login_server"    = azurerm_container_registry.main.login_server
    "admin_username"  = azurerm_container_registry.main.admin_username
    "admin_password"  = azurerm_container_registry.main.admin_password
  })
}

# Return kubeconfig values
output "kube_config" {
  depends_on = [ azurerm_kubernetes_cluster.main ]
  description = "Kube config values to connect to the kubernetes cluster"
  value = tomap({
    "host"                    = azurerm_kubernetes_cluster.main.kube_config.0.host
    "client_certificate"      = base64decode(azurerm_kubernetes_cluster.main.kube_config.0.client_certificate)
    "client_key"              = base64decode(azurerm_kubernetes_cluster.main.kube_config.0.client_key)
    "cluster_ca_certificate"  = base64decode(azurerm_kubernetes_cluster.main.kube_config.0.cluster_ca_certificate)
  })
}
