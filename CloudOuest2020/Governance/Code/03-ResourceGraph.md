# Useful links
[Azure Resource Graph documentation
](https://docs.microsoft.com/en-us/azure/governance/resource-graph/)

https://github.com/MicrosoftDocs/azure-docs.fr-fr/blob/master/articles/governance/policy/tutorials/create-custom-policy-definition.md

https://github.com/whaakman/azure-resource-graph-samples

https://sharegate.com/blog/webinar-recording-getting-started-with-azure-resource-graph

https://www.cloudnative.at/2018/11/19/azure-resource-graph-iv-where-and-string-operators/

https://medium.com/@nicolas.yuen/getting-started-with-azure-resource-graph-96f42cd0aa29

https://www.wesleyhaakman.org/becoming-an-azure-resource-graph-ninja/

https://secureinfra.blog/2019/07/22/querying-azure-resource-graph/

https://github.com/sharegate/azure-quickstart-resource-graph/tree/master/queries

https://medium.com/@nicolas.yuen/getting-started-with-azure-resource-graph-96f42cd0aa29

https://jacktracey.co.uk/azure-spring-clean-2020-azure-resource-graph/?utm_content=bufferb3a0a&utm_medium=social&utm_source=twitter.com&utm_campaign=buffer

https://github.com/Azure-Samples/Governance/pull/4/files

# Tips
## Find the property alias

Resources
| where type=~'microsoft.storage/storageaccounts'
| limit 1
| project aliases

# Subscriptions
**List all subscriptions available why the account and sort by name**
ResourceContainers
| where type=="microsoft.resources/subscriptions"
| order by name asc

# Storage Accounts
**Storage accounts by location**
Resources
| where type =~ 'microsoft.storage/storageaccounts' 
| summarize count() by location| project Location=['location'], Total=count_

**Storage accounts without HttpsOnly count by subscription**
Resources
| extend HttpsOnly = aliases['Microsoft.Storage/storageAccounts/supportsHttpsTrafficOnly'] 
| where type =~ 'microsoft.storage/storageaccounts' and HttpsOnly =~ 'false' 
| summarize count() by subscriptionId 
| project SubscriptionId=['subscriptionId'], Total=count_


**Extract the essentials informations about the storage accounts (security & basic configuration)**
Resources
| extend HttpsOnly = aliases['Microsoft.Storage/storageAccounts/supportsHttpsTrafficOnly'],
FileEncryption = aliases['Microsoft.Storage/storageAccounts/enableFileEncryption'],
BlobEncryption = aliases['Microsoft.Storage/storageAccounts/enableBlobEncryption'],
Tier = aliases['Microsoft.Storage/storageAccounts/sku.tier'],
Sku = aliases['Microsoft.Storage/storageAccounts/sku.name'],
AccessTier = aliases['Microsoft.Storage/storageAccounts/accessTier'],
KeySource = aliases['Microsoft.Storage/storageAccounts/encryption.keySource']
| where type =~ 'microsoft.storage/storageaccounts'
| project Name=['name'], Kind=['kind'], HttpsOnly, BlobEncryption, FileEncryption, Tier, Sku, AccessTier, KeySource, Location=['location'], SubscriptionId=['subscriptionId']

# Network Security Group
## Show unassociated network security groups
**This query returns Network Security Groups (NSGs) that aren't associated to a network interface or subnet.**
Resources
| where type =~ "microsoft.network/networksecuritygroups" and isnull(properties.networkInterfaces) and isnull(properties.subnets)
| project name, resourceGroup
| sort by name asc

## Show NICs not associated to a NSG
**This query returns the NICs without a NSG associated**
Resources
| where type =~ "Microsoft.Network/networkInterfaces" and isnull(properties.networkSecurityGroup)

# Tags
## List resources with a specific tag value
Resources
| where tags.ApplicationSponsor=~'myuser@mydomain.com'
| project name

## List all resource groups where a specific tag is missing
**This query will return all resource groups where a specific tag is not present.**
ResourceContainers
| where type=~'Microsoft.Resources/Subscriptions/resourceGroups' and isempty(tags['Billing'])
| join kind = inner (ResourceContainers | where	type=~'Microsoft.Resources/Subscriptions' 
| project subscriptionName=name, subscriptionId) on subscriptionId
| project subscriptionId, subscriptionName, name, tags


Resources
| where isempty(tags['environment'])
| join kind = inner (ResourceContainers | where	type=~'Microsoft.Resources/Subscriptions' 
| project subscriptionName=name, subscriptionId) on subscriptionId
| project subscriptionId, subscriptionName, resourceGroup, name, tags


# PublicIp
Resources
| where type contains 'publicIPAddresses' and isnotempty(properties.ipAddress)
| join kind = inner (ResourceContainers | where	type=~'Microsoft.Resources/Subscriptions' | project	subscriptionName=name, subscriptionId) on subscriptionId
| project subscriptionId, subscriptionName, name, resourceGroup