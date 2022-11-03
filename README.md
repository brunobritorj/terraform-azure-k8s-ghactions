# Terraform infra on Azure

This repo builds the required infra to host an application based on containers.

```
├── src
|   ├── main.tf
|   ├── variables.tf
|   └── modules
|       ├── azure                   # Azure module
|       |   ├── main.tf
|       |   └── variables.tf
|       |   └── outputs.tf
|       └── kubernetes              # Kubernetes module
|           ├── main.tf
|           └── variables.tf
├── .github
|       └──workflows               # GitHub Actions (CI/CD)
|           └── terraform-apply.yml
└── backend-config.env              # Template for var to connect on Azure backend
```

## Variables

CI/CD file consumes these variables from secrets:

|Variable|Role|Description|
|--|--|--|
|ARM_TENANT_ID|Azure authentication|Tenant Id|
|ARM_SUBSCRIPTION_ID|Azure authentication|Subscription Id|
|ARM_CLIENT_ID|Azure authentication|Client Id|
|ARM_CLIENT_SECRET|Azure authentication|Client Secret|
|TFBACKENDRESOURCEGROUP|Terraform backend|Resource Group|
|TFBACKENDSTORAGEACCOUNT|Terraform backend|Storage Account|
|TFBACKENDSTORAGECONTAINER|Terraform backend|Blob Container|
|TFBACKENDKEY|Terraform backend|File name|
|TF_VAR_AZLOCATION|Infra resources|Region|
|TF_VAR_AZRESOURCEGROUPNAME|Infra resources|Resource Group|
|TF_VAR_AZACRNAME|Infra resources|Container Registry name|
|TF_VAR_AZAKSNAME|Infra resources|Kuberbenetes cluster name|
|TF_VAR_AZAKSNODECOUNT|Infra resources|Kubernetes node count|
|TF_VAR_AZAKSVMSIZE|Infra resources|Kubernetes pool VM size|

## Local development and test

1. On main folder, copy and edit the ```backend-config.env``` file and fill the variables.

2. From ```./src``` folder, run the bellow code replacing the ```xxxxx-backend-config.env``` file name:

  ```
  terraform init `
    -backend-config="..\xxxxx-backend-config.env"

  terraform apply `
    -var="azLocation=xxxxx" `
    -var="azResourceGroupName=xxxxx" `
    -var="azAcrName=xxxxx" `
    -var="azAksName=xxxxx"
  ```
