locals {
  app_name_for_kv = replace("${var.app_name}", "-", "")
  key_vault_name  = "saf${local.app_name_for_kv}${var.app_version}"
}

resource "azurerm_key_vault" "kv" {
  name                        = local.key_vault_name
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "Create", "Delete", "List", "Update", "Import", "Backup", "Restore", "Recover", "Encrypt", "Decrypt"
    ]

    secret_permissions = [
      "Get", "Set", "Delete", "List", "Backup", "Restore", "Recover", "Purge"
    ]

    storage_permissions = [
      "Get", "List", "Delete", "Set", "Update"
    ]
  }
}
