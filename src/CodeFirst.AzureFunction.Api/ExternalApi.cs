using CodeFirst.AzureFunction.Api.Model;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace CodeFirst.AzureFunction.Api
{
    public class ExternalApi(ILogger<ExternalApi> logger)
    {

        [Function("SendResponse")]
        public async Task<InvitationResponseOutput> Run([HttpTrigger(AuthorizationLevel.Function, "get", "post")] HttpRequest req)
        {
            logger.LogInformation("C# HTTP trigger function processed a request.");
            
            var messageText = await Task.FromResult($"Invitation response sent successfully with id: {Guid.NewGuid()}");
            InvitationResponseOutput output = new InvitationResponseOutput
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
                logger.LogInformation("C# Event Hub trigger function processed a message: {message}", message);
            }
        }
    }
}
