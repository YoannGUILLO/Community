# Import module
Import-Module "/Users/yoann/Documents/Git/GitHub/Community/CloudOuest2020/Code/04-ArmTtk/arm-ttk/arm-ttk.psd1"

# List cmdlets
Get-Command -Module arm-ttk

Test-AzTemplate -TemplatePath "/Users/yoann/Documents/Git/GitHub/Community/CloudOuest2020/Code/04-ArmTtk/04-ArmTtk.json"