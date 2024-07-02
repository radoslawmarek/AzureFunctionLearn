locals {
  app_registration_display_name = "appreg-${var.app_name}-${var.app_version}"
  azure_app_display_name = "app-${var.app_name}-${var.app_version}"
}

resource "azurerm_user_assigned_identity" "eh-uai" {
  name                = "uai-${var.app_name}-${var.app_version}-event-hub"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

# only for local development of function app

resource "azuread_application" "application" {
  display_name = local.azure_app_display_name
}

resource "azuread_service_principal" "app-spn" {
  client_id = azuread_application.application.client_id
}

resource "azuread_application_password" "app-spn-secret" {
  application_id = azuread_application.application.id
}

resource "azurerm_key_vault_secret" "kv_app_secret" {
  name         = "app-secret"
  value        = azuread_application_password.app-spn-secret.value
  key_vault_id = azurerm_key_vault.kv.id
}

