# Create a Storage Account - Azure CLI
az storage account create --name <unique-name> -g <resource-group> --kind StorageV2 --sku Standard_LRS

# Get Storage Account Connection String - Azure CLI
az storage account show-connection-string --name <unique-name> --resource-group <resource-group>

# List Keys for Storage Account - Azure CLI
az storage account keys list --account-name <account-name>

# List Messages for Storage Account Queue - Azure CLI
az storage message peek --queue-name <queue-name> --connection-string DefaultEndpointsProtocol=https;EndpointSuffix=core.windows.net;AccountName=<account-name>;AccountKey=<account-key>