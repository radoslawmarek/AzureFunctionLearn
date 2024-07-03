using System.Text.Json;
using CodeFirst.AzureFunction.Api.Model;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace CodeFirst.AzureFunction.Api;

public class ExternalApi(ILogger<ExternalApi> logger)
{

    [Function("SendResponse")]
    public InvitationResponseOutput SendInvitationResponse([HttpTrigger(AuthorizationLevel.Function, "get", "post")] HttpRequest req)
    {
        logger.LogInformation("C# HTTP trigger function processed a request.");

        InvitationResponse invitationResponse = new()
        {
            Id = Guid.NewGuid(),
            Description = $"Invitation response for id: {Guid.NewGuid()} on {DateTime.UtcNow}"
        };
        var messageText = JsonSerializer.Serialize(invitationResponse);
        InvitationResponseOutput output = new()
        {
            Result = new OkObjectResult(messageText),
            MessageText = messageText
        };

        return output;
    }

    [Function("ProcessResponse")]
    public void ProcessResponse([EventHubTrigger("%EventHubInvitationResponseName%", Connection = Consts.EventHubConnection)] 
        string[] inputMessages, FunctionContext context)
    {
        foreach (var message in inputMessages) 
        {
            var invitationResponse = JsonSerializer.Deserialize<InvitationResponse>(message);
            if (invitationResponse is null)
            {
                logger.LogError("Failed to deserialize message: {Message}", message);
                continue;
            }
                
            logger.LogInformation("Invitation response with id = {Id} was processed: {Description}", invitationResponse.Id, invitationResponse.Description);
        }
    }
}