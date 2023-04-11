terraform {
 required_version = ">= v0.13.0"
 required_providers {
 azurerm = {
  version = ">= 2.99.0"
  source = "hashicorp/azurerm"
 }
 }
}
provider "azurerm" {
 features {}
}

resource "azurerm_resource_group" "myrg" {
 name = var.rgname
 location = var.rlocation
}

resource "azurerm_storage_account" "mystorage" {
 name = var.sa
 resource_group_name = var.rgname
 location = var.rlocation
 account_tier = "Standard"
 account_replication_type = "GRS"
 tags = {
 environment = "test"
 }
}

resource "azurerm_storage_container" "cwremote_sc" {
 name = "statefiles"
 storage_account_name = azurerm_storage_account.mystorage.name
 container_access_type = "private"
}

data "azurerm_storage_account_sas" "cw_storage-sas" {
 connection_string = azurerm_storage_account.mystorage.primary_connection_string
 https_only = true
 start = "2023-04-10"
 expiry = "2023-05-23"

services {
  blob = true
  queue = false
  table = false
  file = false
}

resource_types {
  service = true
  container = true
  object = true 
}

permissions {
  read = true
  write = true
  delete = true
  list = true
  add = true
  create = true
  update = true
  process = true
  filter = true
  tag = true 
}
}

data "azurerm_storage_account_blob_container_sas" "cw_container-sas" {
 connection_string = azurerm_storage_account.mystorage.primary_connection_string
 container_name = azurerm_storage_container.cwremote_sc.name
 https_only = true

 start = "2023-04-10"
 expiry = "2023-05-23"

 permissions {
   read = true  
   add = true
   create = true
   write = true
   delete = true
   list = true
 }

    cache_control = "max-age=5"
    content_disposition = "inline"
    content_encoding = "deflate"
    content_language = "en-US"
    content_type = "application/json"
}

output resource_group_details {
 value = azurerm_resource_group.myrg
 sensitive = true
}

output storage_account_details {
 value = azurerm_storage_account.mystorage
 sensitive = true
}

output "sas_container_query_string" {
  value = data.azurerm_storage_account_blob_container_sas.cw_container-sas.sas
  sensitive = true
}

output "sas_storage_query_string" {
  value = data.azurerm_storage_account_sas.cw_storage-sas.sas
  sensitive = true
}

