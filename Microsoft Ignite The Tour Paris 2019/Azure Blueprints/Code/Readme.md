# How to extract your Blueprints

1. Use the Cmdlet ***Export-AzBlueprintWithArtifact***
[Official documentation](https://docs.microsoft.com/en-us/powershell/module/az.blueprint/export-azblueprintwithartifact?view=azps-3.0.0)

2. You'll find all the parameters to use in your ARM templates inside the file "Blueprint.json"

# How to use an ARM template to assign your Blueprints

1. Create an ARM template using ***"type": "Microsoft.Blueprint/blueprintAssignments"***

2. Declare the parrameters used insinde your Blueprints

3. Use the Cmdlet ***New-AzDeployment*** to deploy your ARM tetmplate to the subscription level