# Conditions
$DeploymentName = ((Get-AzContext).Account.Id).Split("@")[0] + "_" + (Get-Date -Format s).Replace(":","-")

$RGName = "CloudOuest001"
$RGLocation = "West Europe"
$CreatedBy = (Get-AzContext).Account.Id
$IpType = "Static"

# Set variables
$DeployParameters = @{}
$DeployParameters.Add("rgName", $RGName)
$DeployParameters.Add("rgLocation", $RGLocation)
$DeployParameters.Add("ipType", $IpType)
$DeployParameters.Add("createdby", $CreatedBy)
$DeployParameters.Add("deploymentIdName", $DeploymentName)

New-AzDeployment -Name $DeploymentName -Location "West Europe" -TemplateFile "/Users/yoann/Documents/Git/GitHub/Community/CloudOuest2020/InfraAsCode/Code/02-Conditions.json" -TemplateParameterObject $DeployParameters