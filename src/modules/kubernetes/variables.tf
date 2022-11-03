variable "namespaces" {
  type = list(string)
  description = "List with namespaces to be created"
  default = [ "dev", "prd" ]
}

variable "host" {
  type = string
  description = "Host URL for administration"
}

variable "client_certificate" {
  type = string
  description = "Client certificate for administration"
}

variable "client_key" {
  type = string
  description = "Client key for administration"
}

variable "cluster_ca_certificate" {
  type = string
  description = "Cluster CA Certificate for administration"
}

variable "registry_name" {
  type = string
  description = "Container Registry name to be connected to the namespace(s)"
}

variable "registry_server" {
  type = string
  description = "Container Registry URL to be connected to the namespace(s)"
}

variable "registry_username" {
  type = string
  description = "Container Registry username used to be connected to the namespace(s)"
}

variable "registry_password" {
  type = string
  description = "Container Registry password used to be connected to the namespace(s)"
}
