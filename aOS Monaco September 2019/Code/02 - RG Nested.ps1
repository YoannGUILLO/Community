# Demo 03
# Set the deployment name
$DeploymentName = ((Get-AzContext).Account.Id).Split("@")[0] + "_" + (Get-Date -Format s).Replace(":","-")
New-AzDeployment -Name $DeploymentName -Location "West Europe" -TemplateFile "/Users/geneziis/Documents/Git/Public/Community/aOS Monaco September 2019/Code/02 - RG Nested.json"