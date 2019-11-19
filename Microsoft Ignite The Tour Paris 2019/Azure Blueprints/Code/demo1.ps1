# List all your management groups
Get-AzManagementGroup

# Get your blueprint
$BP = Get-AzBlueprint -Name NewBP001 -Version 1.7 -ManagementGroupId ALL
# Export your blueprint
Export-AzBlueprintWithArtifact -Blueprint $BP -OutputPath ./1.7