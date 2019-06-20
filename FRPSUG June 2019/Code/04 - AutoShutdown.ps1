$ResourceGroupName = "FRPSUG001"
$VirtualMachineName = "SimpleVM"
$ShutdownTime = 2200
$TimeZone = 'Romance Standard Time'

$Location = (Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VirtualMachineName).Location
$SubscriptionId = (Get-AzContext).Subscription.SubscriptionId
$VMResourceId = (Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VirtualMachineName).Id
$ScheduledShutdownResourceId = "/subscriptions/$SubscriptionId/resourceGroups/$ResourceGroupName/providers/microsoft.devtestlab/schedules/shutdown-computevm-$VirtualMachineName"

$Properties = @{}
$Properties.Add('status', 'Enabled')
$Properties.Add('taskType', 'ComputeVmShutdownTask')
$Properties.Add('dailyRecurrence', @{'time'= $ShutdownTime})
$Properties.Add('timeZoneId', $TimeZone)
$Properties.Add('notificationSettings', @{status='Disabled'; timeInMinutes=15})
$Properties.Add('targetResourceId', $VMResourceId)

New-AzResource -Location $Location -ResourceId $ScheduledShutdownResourceId -Properties $Properties -Force