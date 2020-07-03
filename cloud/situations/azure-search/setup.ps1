# Define Important Variables
rg = "search"
$location = "westus"
$serviceName = "laaz203search"

# Create Resource Group
az group create -n $rg -l $location

# Create Search Service
az search service create `
 --name $serviceName `
 -g $rg `
 --sku free

 # Get Admin Service Key
az search admin-key show `
 --service-name $serviceName `
 -g $rg `
 --query "primaryKey"
 
# Get Query Key
az search query-key list `
 --service-name $serviceName `
 -g $rg `
 --query "[0].key"

 # Delete Resource Group
az group delete -n $rg --yes