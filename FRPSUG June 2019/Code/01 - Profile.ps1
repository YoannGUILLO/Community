# List commande from module Az.Accounts
Get-Command -Module Az.Accounts

# Check auto save settings
Get-AzContextAutosaveSetting

# Enable auto save
Enable-AzContextAutosave

# Connect to Azure
Connect-AzAccount

# List subscriptions
Get-AzSubscription

# List context
Get-AzContext -ListAvailable | fl

# Rename context
Rename-AzContext -SourceName "MVP (4f3ccd452-1111-2222-3333-bdddddd19ebe) - yoann.guillo@mydomain.com" -TargetName "DEV"

# Check rename
Get-AzContext -ListAvailable

# Select another subscription
Set-AzContext -Subscription "GENEZIIS"

# Select a context
Select-AzContext DEV

# Check current context
Get-AzContext