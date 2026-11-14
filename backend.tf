terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "sttfstated6dc1341"
    container_name       = "tfstate"
    key                  = "aks/prod.terraform.tfstate"
  }
}
