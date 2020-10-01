Measure-Command { Search-AzGraph -Query "Resources | where type =~ 'Microsoft.Network/networkInterfaces' and isnull(properties.networkSecurityGroup)" | Out-Default}

Measure-Command { (Get-AzSubscription).foreach( { Select-AzSubscription -SubscriptionName $_.Name
            Get-AzNetworkInterface | Where-Object -Property NetworkSecurityGroup -eq $null | Out-Default
        }) }