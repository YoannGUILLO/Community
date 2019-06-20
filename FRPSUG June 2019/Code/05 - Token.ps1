# Pas d'équivalent à az account get-access-token
## https://docs.microsoft.com/en-us/cli/azure/account?view=azure-cli-latest#az-account-get-access-token

# Retrieve the current Azure context
$CurrentAzureContext = Get-AzContext

# Create an Azure instance profile
$AzureRmProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile

# Create a User profile
$ProfileClient = New-Object Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient($AzureRmProfile)

# Generate a token relative to our current Azure context
Write-Host ("Getting access token for context " + $CurrentAzureContext.Subscription.Name)
$Token = $ProfileClient.AcquireAccessToken($CurrentAzureContext.Subscription.TenantId)

# Display the token and its properties
$Token

$Uri = "https://management.azure.com/subscriptions/<mysubscriptionid>/resourceGroups/FRPSUG001/providers/Microsoft.Network/publicIPAddresses/myPublicIP?api-version=2018-11-01"
$Header = @{"authorization" = "bearer $($Token.AccessToken)"}
$Result = Invoke-RestMethod -Method Get -Uri $Uri -Headers $Header
$Result.properties.ipAddress