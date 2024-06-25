locals {
  eventhub-namespace-name           = "ehn-${var.app_name}-${var.app_version}"
  invitations-eventhub-name         = "eh-invitations-${var.app_name}-${var.app_version}"
  invitation-response-eventhub-name = "eh-invitation-response-${var.app_name}-${var.app_version}"

}

resource "azurerm_eventhub_namespace" "ehn" {
  name                = local.eventhub-namespace-name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  capacity            = 1

  tags = {
    environment = "Production"
  }
}

resource "azurerm_eventhub" "eh-invitations" {
  name                = local.invitations-eventhub-name
  namespace_name      = azurerm_eventhub_namespace.ehn.name
  resource_group_name = azurerm_resource_group.rg.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub" "eh-invitation-responses" {
  name                = local.invitation-response-eventhub-name
  namespace_name      = azurerm_eventhub_namespace.ehn.name
  resource_group_name = azurerm_resource_group.rg.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub_authorization_rule" "invitation-response-auth-rule" {
  name                = "invtation-response-auth-rule"
  namespace_name      = azurerm_eventhub_namespace.ehn.name
  eventhub_name       = azurerm_eventhub.eh-invitation-responses.name
  resource_group_name = azurerm_resource_group.rg.name
  listen              = true
  send                = true
  manage              = false
}

