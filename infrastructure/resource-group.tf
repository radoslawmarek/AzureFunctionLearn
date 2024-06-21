locals {
  resource_group_name = "rg-${var.app_name}-${var.app_version}"
}

resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.location
}