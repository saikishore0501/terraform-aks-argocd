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

## GitHub Actions Workflows

Three separate workflows:

### 1. Terraform Plan (`terraform-plan.yml`)
- **Triggers**:
  - Pull requests to `main`
  - Pushes to `main`
  - Manual (`workflow_dispatch`)
- Runs `terraform init`, `validate`, and `plan`
- Posts the plan as a comment on PRs
- Uploads the plan artifact

### 2. Terraform Apply (`terraform-apply.yml`)
- **Triggers**: Manual only (`workflow_dispatch`)
- Requires confirmation input: type `apply`
- Runs a fresh plan and then `terraform apply -auto-approve`

### 3. Terraform Destroy (`terraform-destroy.yml`)
- **Triggers**: Manual only (`workflow_dispatch`)
- Requires confirmation input: type `destroy`
- Runs `terraform destroy -auto-approve`

**Warning**: Destroy is irreversible. Double-check before confirming.

## Next steps

- Add ArgoCD installation (Helm or manifests)
- Add node pools, networking, monitoring, etc.
- Tighten RBAC and networking
