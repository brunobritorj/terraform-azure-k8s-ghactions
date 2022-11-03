variable "azLocation" {
  type = string
  description = "Location where the Azure resources"
}

variable "azResourceGroupName" {
  type = string
  description = "Name for the Azure Resource Group"
}

variable "azAcrName" {
  type = string
  description = "Name for the ACR registry"
}

variable "azAksName" {
  type = string
  description = "Name for the AKS cluster"
}

variable "azAksNodeCount" {
  type = number
  description = "Value for node count"
  default = 1
}

variable "azAksVmSize" {
  type = string
  description = "SKU for VM node(s)"
  default = "Standard_B2s"
}

variable "stages" {
  type = list(string)
  description = "List with names of environments/stages to be created"
  default = [ "dev", "prd" ]
}
