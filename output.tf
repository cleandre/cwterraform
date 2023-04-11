terraform {}

output "resource_group_details" {
  value     = azurerm_resource_group.myrg
  sensitive = true
}

output "storage_account_details" {
  value     = azurerm_storage_account.mystorage
  sensitive = true
}

output "sas_container_query_string" {
  value     = data.azurerm_storage_account_blob_container_sas.cw_container-sas.sas
  sensitive = true
}

output "sas_storage_query_string" {
  value     = data.azurerm_storage_account_sas.cw_storage-sas.sas
  sensitive = true
}
