# Demo 03
# Set variables
$RGName = "aOSRG4"
$RGLocation = "West Europe"
New-AzResourceGroup -Name $RGName -Location $RGLocation
# Set the deployment name
$DeploymentName = ((Get-AzContext).Account.Id).Split("@")[0] + "_" + (Get-Date -Format s).Replace(":","-")
New-AzResourceGroupDeployment -Name $DeploymentName -ResourceGroupName $RGName -TemplateFile "aOS Strasbourg 2019/Code/04 - IP Function.json" -createdby (Get-AzContext).Account.Id