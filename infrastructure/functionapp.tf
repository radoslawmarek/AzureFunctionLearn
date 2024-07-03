locals {
  function-app-service-plan-name = "spfa-${var.app_name}-${var.app_version}"
  function-app-name              = "fa-${var.app_name}-${var.app_version}"
  allowed_origins                = ["https://portal.azure.com"]
}

resource "azurerm_service_plan" "function-app-service-plan" {
  name                = local.function-app-service-plan-name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "function-app" {
  name                = local.function-app-name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  storage_account_name       = azurerm_storage_account.sa.name
  storage_account_access_key = azurerm_storage_account.sa.primary_access_key
  service_plan_id            = azurerm_service_plan.function-app-service-plan.id

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.eh-uai.id]
  }

  site_config {
    application_stack {
      use_dotnet_isolated_runtime = true
      dotnet_version              = "8.0"
    }
    application_insights_key               = azurerm_application_insights.application-insights.instrumentation_key
    application_insights_connection_string = azurerm_application_insights.application-insights.connection_string
    cors {
      allowed_origins     = local.allowed_origins
      support_credentials = true
    }
  }

  app_settings = {
    WEBSITE_WEBDEPLOY_USE_SCM = true
    EventHubConnection__credential : "managedidentity",
    EventHubConnection__fullyQualifiedNamespace : "${azurerm_eventhub_namespace.ehn.name}.servicebus.windows.net",
    EventHubConnection__clientId : azurerm_user_assigned_identity.eh-uai.client_id,
    EventHubInvitationResponseName = azurerm_eventhub.eh-invitation-responses.name
  }
}
