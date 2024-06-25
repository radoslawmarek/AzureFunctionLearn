locals {
  log-analytics-name = "log-${var.app_name}-${var.app_version}"
  application-insights-name = "ai-${var.app_name}-${var.app_version}"
}

resource "azurerm_log_analytics_workspace" "log-analytics" {
  name                = local.log-analytics-name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  daily_quota_gb      = 1
}

resource "azurerm_application_insights" "application-insights" {
  name                = local.application-insights-name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  workspace_id        = azurerm_log_analytics_workspace.log-analytics.id
  application_type    = "web"
}

output "instrumentation_key" {
  value = azurerm_application_insights.application-insights.instrumentation_key
  sensitive = true
}

output "app_id" {
  value = azurerm_application_insights.application-insights.app_id
}