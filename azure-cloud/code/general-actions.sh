# Log Into Azure - Azure CLI
az login

# List Azure Subscriptions - Azure CLI
az account list --output table

# List Azure Resource Groups - Azure CLI
az group list --output table

# List Azure Resources in Resource Group - Azure CLI
az resource list --resource-group <resource-group>

# Find a Group/Subgroup - Azure CLI
az find subgroup/group || az find "az group" || az find "az group command"

# Get Information About a Group - Azure CLI
az group --help

# Get Information About a Subgroup - Azure CLI
az group subgroup --help