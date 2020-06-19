# First deployment
New-AzDeployment -Name "RgDeploy" -Location "West Europe" -TemplateFile "/Users/yoann/Documents/Git/GitHub/Community/CloudOuest2020/InfraAsCode/Code/01-Demo.json"

# Set the deployment name to keep history
$DeploymentName = ((Get-AzContext).Account.Id).Split("@")[0] + "_" + (Get-Date -Format s).Replace(":","-")
New-AzDeployment -Name $DeploymentName -Location "West Europe" -TemplateFile "/Users/yoann/Documents/Git/GitHub/Community/CloudOuest2020/InfraAsCode/Code/01-Demo.json"