variable "azLocation" {
  type = string
  description = "Location where the Azure resources"
}

variable "azResourceGroupName" {
  type = string
  description = "Name for the Az Resource Group"
}

variable "azAcrName" {
  type = string
  description = "Name for the Az Container Registry"
}

variable "azAksName" {
  type = string
  description = "Name for the Az Kubernetes Services"
}

variable "azAksNodeCount" {
  type = number
  description = "Value for AKS node count"
  default = 1
}

variable "azAksVmSize" {
  type = string
  description = "SKU for AKS VM node(s)"
  default = "Standard_B2s"
}
