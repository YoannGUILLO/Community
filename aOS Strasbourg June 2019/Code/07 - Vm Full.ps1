# Demo 03
# Set variables
$RGName = "aOSRG7"
$RGLocation = "West Europe"
New-AzResourceGroup -Name $RGName -Location $RGLocation
# Set the deployment name
$DeploymentName = ((Get-AzContext).Account.Id).Split("@")[0] + "_" + (Get-Date -Format s).Replace(":","-")
New-AzResourceGroupDeployment -Name $DeploymentName -ResourceGroupName $RGName -TemplateFile "aOS Strasbourg 2019/Code/07 - Vm Full.json" -TemplateParameterFile "aOS Strasbourg 2019/Code/07 - Vm Full.parameters.json"