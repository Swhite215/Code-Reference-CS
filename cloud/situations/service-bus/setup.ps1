 # Create A Resource Group
az group create -n servicebus -l westus

# Create A Namespace in Resource Group
az servicebus namespace create --n laaz203sb -g servicebus

# Get Connection String for Application
az servicebus namespace authorization-rule keys list `
 -g servicebus `w
 --namespace-name laaz203sb `
 --name RootManageSharedAccessKey `
 --query primaryConnectionString

# Create Service Bus Queue 
az servicebus queue create `
 --namespace-name laaz203sšww `
 -g servicebus `
 -n testqueue 

# Remove Service Bus Queue
New-AzureRmServiceBusQueue `
 -ResourceGroupName servicebus `
 -NamespaceName laaz203sb `
 -name testqueue `
 -EnablePartitioning $false