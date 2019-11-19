# Get the current user
$CreatedBy = (Get-AzContext).Account.Id
# Create a timestamp
$CreatedDate = (Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ")
# Create a deployment name (to be unique)
$DeploymentName = $CreatedBy.Split("@")[0] + "_" + $CreatedDate
# Deploy the ARM template to a subscription level
New-AzDeployment -Name $DeploymentName -Location westeurope -TemplateUri "https://github.com/YoannGUILLO/Community/blob/master/Microsoft Ignite The Tour Paris 2019/Azure Blueprints/Code/InfraAsCode/azuredeploy.json" -createdBy $CreatedBy