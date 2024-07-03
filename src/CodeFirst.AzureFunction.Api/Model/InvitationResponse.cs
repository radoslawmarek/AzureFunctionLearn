namespace CodeFirst.AzureFunction.Api.Model;

public class InvitationResponse
{
    public Guid Id { get; set; }
    public required string Description { get; set; }
}