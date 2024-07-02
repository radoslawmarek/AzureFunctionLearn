using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;

namespace CodeFirst.AzureFunction.Api.Model;

public class InvitationResponseOutput
{
    [HttpResult]
    public required IActionResult Result { get; set; }
    
    [EventHubOutput("%EventHubInvitationResponseName%", Connection = Consts.EventHubConnection)]
    public required string MessageText { get; set; }
}