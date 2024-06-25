using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;

namespace CodeFirst.AzureFunction.Api.Model;

public class InvitationResponseOutput
{
    private const string EventHubConnection = "eventhub_invitation_response_connection_string";
    
    [HttpResult]
    public required IActionResult Result { get; set; }
    
    [EventHubOutput("%EventHubInvitationResponseName%", Connection = EventHubConnection)]
    public required string MessageText { get; set; }
}