param($eventGridEvent, $TriggerMetadata)

# Make sure to pass hashtables to Out-String so they're logged correctly
#$eventGridEvent.data.httpRequest | Out-String | Write-Host
$eventGridEvent.data.claims.name | Out-String | Write-Host 
$eventGridEvent.subject | Out-String | Write-Host

$Subject = $eventGridEvent.subject
$Name = $eventGridEvent.data.claims.name


# Get an access token for the MSI
#Write-Output "Endpoint: [$($env:MSI_ENDPOINT)]"
$TokenAuthURI = $env:MSI_ENDPOINT + "?resource=https://management.azure.com/&api-version=2017-09-01"
$TokenResponse = Invoke-RestMethod -Method Get -Headers @{"Secret"="$env:MSI_SECRET"} -Uri $TokenAuthURI
#$tokenResponse.Content
$ArmToken = $tokenResponse.access_token

$ArmToken

$Uri = "https://management.azure.com"+$Subject+"?api-version=2018-05-01"
$Params = @{
    ContentType = 'application/json'
    Headers = @{
    'authorization'="Bearer $ARMToken"
    }
    Method = 'Patch'
    Body = @{
            "tags" = 
            @{
                "CreatedBy" = $Name
            }
        }| convertto-json
    URI = $uri
}

$Response = Invoke-RestMethod @Params
$Response | convertto-json