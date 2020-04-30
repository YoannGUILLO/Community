# Get the current user
$CreatedBy = (Get-AzContext).Account.Id
# Create a timestamp
$CreatedDate = (Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ")
# Create a deployment name (to be unique)
$DeploymentName = $CreatedBy.Split("@")[0] + "_" + $CreatedDate
# Deploy the ARM template to a subscription level
New-AzDeployment -Name $DeploymentName -Location westeurope -TemplateUri "https://raw.githubusercontent.com/YoannGUILLO/Community/master/Microsoft%20Ignite%20The%20Tour%20Paris%202019/Azure%20Blueprints/Code/InfraAsCode/azuredeploy.json" -createdBy $CreatedBy