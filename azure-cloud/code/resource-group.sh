# Create a Resource Group - Azure CLI
az group create --name <name> --location <location>

# Get a Resource Group - Azure CLI
yourResource=$(az resource show --resource-group <resource group name> --name <resource name> --query id --output tsv)

# Move Resource Groups - Azure CLI
az resource move --destination-group <name> --ids $yourResource

# Show Group Info - Azure CLI
az group show --name <name>