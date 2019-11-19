#region Variables
$RGName = "AZMITT000RG000"
$TemplateUri = "https://github.com/YoannGUILLO/Community/blob/master/Microsoft Ignite The Tour Paris 2019/Azure Logic Apps/Code/CosmosDBRotationKeys/azuredeploy.json"
$TemplateParameterUri = "https://github.com/YoannGUILLO/Community/blob/master/Microsoft Ignite The Tour Paris 2019/Azure Logic Apps/Code/CosmosDBRotationKeys/azuredeploy.parameters.json"
$KeyVaultName = "AZMITT000KV001"
$KeyVaultResourceGroup = "AZMITT000RG000"
$CreatedBy = (Get-AzContext).Account.Id
$CreatedDate = (Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ")
$DeploymentName = $CreatedBy.Split("@")[0] + "_" + $CreatedDate
#endregion Variables

#region Deployment
# Run deployment
$DeploymentResult = New-AzResourceGroupDeployment -Name $DeploymentName -ResourceGroupName $RGName -TemplateUri $TemplateUri -TemplateParameterUri $TemplateParameterUri -CreatedBy $CreatedBy -CreatedDate $CreatedDate -KeyVaultName $KeyVaultName
# Get the objectId of the system assigned identity (Logic App)
$ObjectId = $DeploymentResult.Outputs.systemassignedId.Value
#endregion Deployment

#region Assigments
# Wait to be sure that MSI is operationnal
Start-Sleep -Seconds 30

# Create an access policy (set,get,list) for Logic App on the Key Vault
Set-AzKeyVaultAccessPolicy -VaultName $KeyVaultName -ResourceGroupName $KeyVaultResourceGroup -ObjectId $ObjectId -PermissionsToSecrets set,get,list

# Assign the role "DocumentDB Account Contributor" for Logic App on all the CosmosDB in the subscription
$CosmosDBs = Get-AzResource -ResourceType "Microsoft.DocumentDb/databaseAccounts"
Foreach ($CosmosDB in $CosmosDBs)
{
    New-AzRoleAssignment -ObjectId $ObjectId -RoleDefinitionName "DocumentDB Account Contributor" -Scope $($CosmosDB.ResourceId)
}
#endregion Assigments