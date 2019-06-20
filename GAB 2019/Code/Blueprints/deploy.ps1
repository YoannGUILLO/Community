$params = @{addressSpaceForVnet="10.0.0.0/16"; addressSpaceForSubnet="10.0.0.0/24"; resourceNamePrefix="DEMO"}
$blueprintObject = Get-AzBlueprint
New-AzBlueprintAssignment -Name "myAssignment" -Blueprint $blueprintObject -SubscriptionId "4f33d452-a160-4530-8ad1-b5a6a3419ebe" -Location "West Europe" -Parameter $params