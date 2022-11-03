terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.14.0"
    }
  }
}

provider "kubernetes" {
  host                    = var.host
  client_certificate      = var.client_certificate
  client_key              = var.client_key
  cluster_ca_certificate  = var.cluster_ca_certificate
}

# Create a K8s namespace(s)
resource "kubernetes_namespace" "main" {
  count = length(var.namespaces)
  metadata {
    name = var.namespaces[count.index]
  }
}

# Create a K8s secret on previous namespace(s)
resource "kubernetes_secret" "main" {
  depends_on = [ kubernetes_namespace.main ]
  count = length(var.namespaces)
  metadata {
    name = var.registry_name
    namespace = var.namespaces[count.index]
  }
  type = "kubernetes.io/dockerconfigjson"
  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${var.registry_server}" = {
          "username" = var.registry_username
          "password" = var.registry_password
          "auth"     = base64encode("${var.registry_username}:${var.registry_password}")
        }
      }
    })
  }
}

# Retrieve the "default" service account on previous namespace(s)
data "kubernetes_service_account" "default" {
  depends_on = [ kubernetes_namespace.main ]
  count = length(var.namespaces)  
  metadata {
    name = "default"
    namespace = var.namespaces[count.index]
  }
}

# Retrieve the secret associated to the previous default service account on namespace(s)
data "kubernetes_secret" "default" {
  depends_on = [ data.kubernetes_service_account.default ]
  count = length(var.namespaces)  
  metadata {
    name = data.kubernetes_service_account.default[count.index].default_secret_name
    namespace = var.namespaces[count.index]
  }
}
