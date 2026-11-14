# Terraform AKS + ArgoCD Practice

This repository deploys an Azure Kubernetes Service (AKS) cluster using Terraform with remote state stored in Azure Storage, and is ready for GitHub Actions CI/CD.

## Remote Backend

State is stored in:
- Resource Group: `rg-tfstate`
- Storage Account: `sttfstated6dc1341`
- Container: `tfstate`
- Key: `aks/prod.terraform.tfstate`

## Prerequisites

1. Azure subscription
2. GitHub repository secrets:
   - `AZURE_CLIENT_ID`
   - `AZURE_TENANT_ID`
   - `AZURE_SUBSCRIPTION_ID`
3. Federated credential (OIDC) configured on the Azure App Registration / Managed Identity for this GitHub repo (recommended).
4. The identity needs:
   - `Contributor` (or more scoped) on the target resource group / subscription for AKS
   - `Storage Blob Data Contributor` on the state storage account

## Local usage

```bash
az login
terraform init
terraform plan
terraform apply
```

## GitHub Actions

- Plan runs on pull requests
- Apply runs on push to `main`

## Next steps

- Add ArgoCD installation (Helm or manifests)
- Add node pools, networking, monitoring, etc.
- Tighten RBAC and networking
