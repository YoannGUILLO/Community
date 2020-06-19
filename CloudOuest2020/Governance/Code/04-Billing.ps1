Select-azcontext Prod

Get-AzBillingInvoice -Latest

Get-AzConsumptionUsageDetail -StartDate 2020-05-01 -EndDate 2020-05-31 -Top 10
Get-AzConsumptionUsageDetail -StartDate 2020-05-01 -EndDate 2020-05-31


Get-UsageAggregates -ReportedStartTime 2020-05-01 -ReportedEndTime 2020-05-31


#https://docs.microsoft.com/en-us/rest/api/consumption/forecasts/list


# Calcul via du forecast via API
$SubscriptionId = (get-azcontext).Subscription.Id
$token =  gto
$headers = @{"authorization"="bearer $($token.accesstoken)"} 
Set-AzContext -SubscriptionId $SubscriptionId
$uri =  "https://management.azure.com/subscriptions/$SubscriptionId/providers/Microsoft.Consumption/forecasts?api-version=2019-01-01"
$results = Invoke-RestMethod $uri -Headers $headers -ContentType "application/json" -Method Get