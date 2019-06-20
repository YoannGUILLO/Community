$Uri = "https://management.azure.com/subscriptions/<mysubscriptionid>/resourcegroups?api-version=2019-05-01"
$Header = @{"authorization" = "bearer $($Token.AccessToken)"}
Measure-Command {Invoke-RestMethod -Method Get -Uri $Uri -Headers $Header}


Measure-Command {Get-AzResourceGroup}