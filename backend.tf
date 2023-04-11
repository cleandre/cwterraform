terraform {

 backend "azurerm" {
 resource_group_name = "cwtest"
 storage_account_name = "cwstorage1"
 container_name = "statefiles"
 key = "cw-prod.terraform.tfstate"
 }

}

output rgoutput {
 value = azurerm_resource_group.rgtestname
}

