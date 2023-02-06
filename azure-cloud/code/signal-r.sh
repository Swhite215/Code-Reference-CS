# Create a Signal R Account - Azure CLI
az signalr create --name <name> --resource-group <resource-group> --sku Free_DS2 --unit-count 1

# Update Signal R Service Mode to Serverless - Azure CLI
az resource update --resource-type Microsoft.SignalRService/SignalR --name <name> --resource-group <resource-group> --set properties.features[flag=ServiceMode].value=Serverless