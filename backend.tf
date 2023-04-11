terraform {

 backend "azurerm" {
 resource_group_name = "cwtest"
 storage_account_name = "cwstorage1"
 container_name = "statefiles"
 key = "cw-prod.terraform.tfstate"
 }

}

resource azurerm_resource_group rgtestname {
 name = "testrgforstate"
 location = "westus2"
}


output rgoutput {
 value = azurerm_resource_group.rgtestname
}

