resource "azurerm_user_assigned_identity" "eh-uai" {
  name                = "uai-${var.app_name}-${var.app_version}-event-hub"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}
