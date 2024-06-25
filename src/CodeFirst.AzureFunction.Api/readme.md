To run function app locally you need:
- working Azurite
- configuration in local.settings.json (remember to copy this file on build)
- working copy of Event Hub to send and receive messages with correct connection string

Example configuration:
```json
{
  "IsEncrypted": false,
  "Values": {
    "AzureWebJobsStorage": "UseDevelopmentStorage=true",
    "FUNCTIONS_WORKER_RUNTIME": "dotnet-isolated",
    "eventhub_invitation_response_connection_string": "Endpoint=sb://localhost/;SharedAccessKeyName=invtation-response-auth-rule;SharedAccessKey=iZK9vaD+bM=;EntityPath=eh-invitation-response-learn-azure-functions-01",
    "EventHubInvitationResponseName": "eh-invitation-response-learn-azure-functions-01"
  }
}
```