 terraform {
    backend "azurerm" {
        resource_group_name  = "less_rsg"
        storage_account_name = "less"
        container_name       = "tfstate"
        key                  = "ntier.tfstate"
    }
} 