# Define Imporatnt Variables
$rg = "blobs"
$location = "westus"
$acct = "laaz203blobs"

# Create the Resource Group
az group create -n $rg -l $location

# Create a Storage Account
az storage account create `
 -g $rg `
 -n $acct `
 -l $location `
 --sku Standard_LRS

 # Show Storage Account Connection String
az storage account show-connection-string `
 -n $acct `
 --query "connectionString"