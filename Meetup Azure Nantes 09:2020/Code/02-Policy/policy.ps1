#Force policy evaluation
Start-AzPolicyComplianceScan -ResourceGroupName Demo

https://docs.microsoft.com/en-us/azure/governance/policy/how-to/get-compliance-data

https://docs.microsoft.com/en-us/powershell/module/az.policyinsights/start-azpolicycompliancescan?view=azps-4.7.0



New-AzSubscriptionDeployment -Name (nde) -Location westeurope -TemplateFile "02-Policy/policydefinition.json"

New-AzSubscriptionDeployment -Name (nde) -Location westeurope -TemplateFile "02-Policy/policyassignment.json" -TemplateParameterFile "02-Policy/policyassignment.param.json"