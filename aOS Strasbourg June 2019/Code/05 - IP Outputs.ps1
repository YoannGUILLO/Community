# Demo 03
# Set variables
$RGName = "aOSRG5"
$RGLocation = "West Europe"
New-AzResourceGroup -Name $RGName -Location $RGLocation
# Set the deployment name
$DeploymentName = ((Get-AzContext).Account.Id).Split("@")[0] + "_" + (Get-Date -Format s).Replace(":","-")
$Result = New-AzResourceGroupDeployment -Name $DeploymentName -ResourceGroupName $RGName -TemplateFile "aOS Strasbourg 2019/Code/05 - IP Outputs.json" -createdby (Get-AzContext).Account.Id