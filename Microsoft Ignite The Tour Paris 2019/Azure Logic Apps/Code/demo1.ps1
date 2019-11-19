## List regenerate key actions from activity log
Get-AzLog -StartTime (Get-Date).AddHours(-48) | 
Where-Object {$_.Authorization.Action -like 'Microsoft.DocumentDb/databaseAccounts/regenerateKey/action'} | 
Select-Object @{N="Caller";E={$_.Caller}}, 
@{N="Resource";E={$_.Authorization.Scope}}, 
@{N="Action";E={Split-Path $_.Authorization.action -leaf}},
@{N="Name";E={$_.Claims.Content.name}}, 
EventTimestamp


## Try to retrieve actions / properties from the CosmosDB resource
Get-AzResource -ResourceGroupName AZMITT001RG002 -ResourceName azmitt001cdb001


## List the actions from the provider Microsoft.DocumentDb/databaseAccounts
Get-AzResourceProviderAction -OperationSearchString Microsoft.DocumentDb/databaseAccounts/*

## Try to retrieve the actions containing the keyword "keys"
Get-AzResourceProviderAction -OperationSearchString Microsoft.DocumentDb/databaseAccounts/* | Where-Object {$_.OperationName -like "*Keys*"}

## List keys for an Azure Cosmos Account
$resourceGroupName = "AZMITT001RG002"
$accountName = "azmitt001cdb001"

$keys = Invoke-AzResourceAction -Action listKeys `
    -ResourceType "Microsoft.DocumentDb/databaseAccounts" -ApiVersion "2015-04-08" `
    -ResourceGroupName $resourceGroupName -Name $accountName

    $keys | fl


## Set a secret in a Key Vault    
# Convert the secret to a secretvalue
$secretvalue = ConvertTo-SecureString $keys.primaryMasterKey -AsPlainText -Force
# Set the secret
$secret = Set-AzKeyVaultSecret -VaultName 'AZMITT000KV001' -Name 'AZMITT001RG002-PrimaryMasterKey' -SecretValue $secretvalue -ContentType "ACCESS_KEY"
$secret