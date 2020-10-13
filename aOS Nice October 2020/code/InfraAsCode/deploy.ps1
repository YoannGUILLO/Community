New-AzResourceGroup -name "AOSNICE-YML" -Location "westeurope"

New-AzResourceGroupDeployment -Name (nde) -ResourceGroupName "AOSNICE-YML" -TemplateFile "InfraAsCode/deploy.json"