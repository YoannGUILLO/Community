# Demo 03
# Set variables
$RGName = "aOSRG3"
$RGLocation = "West Europe"
New-AzResourceGroup -Name $RGName -Location $RGLocation
# Set the deployment name
$DeploymentName = ((Get-AzContext).Account.Id).Split("@")[0] + "_" + (Get-Date -Format s).Replace(":","-")
New-AzResourceGroupDeployment -Name $DeploymentName -ResourceGroupName $RGName -TemplateFile "/Users/geneziis/Documents/Git/Public/Community/aOS Monaco September 2019/Code/03 - IP Copy.json" -createdby (Get-AzContext).Account.Id