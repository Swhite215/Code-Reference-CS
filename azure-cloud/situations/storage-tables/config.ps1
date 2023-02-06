# Define Important Variables
$rg = "tables"
$location = "westus"
$acct = "laaz203tables"

# Create the Resource Group
az group create -n $rg -l $location

# Create the Storage Account
az storage account create `
 -g $rg `
 -n $acct `
 -l $location `
 --sku Standard_LRS

 # Get Connection String for Storage Account
az storage account show-connection-string `
 -n $acct `
 --query "connectionString"

 # Delete Resource Group
az group delete -n $rg