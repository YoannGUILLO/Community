# Automatically detect CosmosDB rotation keys

This example automatically deploy the following resources : 

1. LogicApp
2. Action Group
3. Alert

## Alert
Will be used to detect a rotation key in the activity logs

## Action Group
Executed by an alert and will automatically notify a user (specified as variable in the ARM template) sending : 
1. SMS
2. Email
3. Push Notifications
4. Execute the LogicApp

## LogicApp
Run the actions below :
1. Get the Name of the CosmosDB for which a key has been regenerated
2. Get back the CosmosDB's Keys using REST API
3. Parse the result
4. Update the secrets in the Key Vault for each keys of the CosmosDB

# Deployment script

Modify the PowerShell script to adapt it to your context !

 ```powershell
$RGName = "MyResourceGroup"
$TemplateFile = "https://github.com/YoannGUILLO/Community/blob/master/Microsoft Ignite The Tour Paris 2019/Azure Logic Apps/Code/CosmosDBRotationKeys/azuredeploy.json"
$TemplateParameterFile = "https://github.com/YoannGUILLO/Community/blob/master/Microsoft Ignite The Tour Paris 2019/Azure Logic Apps/Code/CosmosDBRotationKeys/azuredeploy.parameters.json"
$KeyVaultName = "MyKeyVault"
$KeyVaultResourceGroup = "MyKeyVaultResourceGroup"
 ```

The script will automatically reuse the ObjectId of the Managed Service Identity of the Logic App (passed in the Output of the deployment) then use it to create an assign policy inside the Key Vault you specified.

Finally the script will assign the role ***"DocumentDB Account Contributor"*** on all the CosmosDB of your subscription to the Logic App (***using the MSI***), allowing it to retrieve the Keys.