To run function app locally you need:
- working Azurite
- configuration in local.settings.json (remember to copy this file on build)
- working copy of Event Hub to send and receive messages with correct connection string

Example configuration for local development:
```json
{
  "IsEncrypted": false,
  "Values": {
    "AzureWebJobsStorage": "UseDevelopmentStorage=true",
    "FUNCTIONS_WORKER_RUNTIME": "dotnet-isolated",
    "EventHubInvitationResponseName": "eh-invitation-response-learn-azure-functions-01",
    "EventHubConnection__fullyQualifiedNamespace": "ehn-learn-azure-functions-01.servicebus.windows.net",
    "EventHubConnection__clientId": "User Object ID from EntraId",
    "EventHubConnection__tenantId": "Tenant ID from Azure"
  }
}
```

When you are developing using Visual Studio you have to log in to Azure using Tools -> Options -> Azure Service Authentication.
