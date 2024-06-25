locals {
  app-name-for-storage-account = replace("${var.app_name}", "-", "")
  storage-account-name         = "saf${local.app-name-for-storage-account}${var.app_version}"
}

resource "azurerm_storage_account" "sa" {
  name                     = local.storage-account-name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
