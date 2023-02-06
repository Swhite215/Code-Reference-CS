# Define Important Variables
$acct = "laaz203functionssa"
$rg = "functions"
$queue = "incoming-orders"

# Create the Resource Group
az group create -n $rg -l westus

# Create a Storage Acount
az storage account create `
 -n $acct `
 -g $rg `
 -l westus `
 --sku Standard_LRS `
 --kind StorageV2 `
 --access-tier Hot

 # Get Storage Account Key
$key = $(az storage account keys list `
 --account-name $acct `
 -g $rg `
 --query "[0].value" `
 --output tsv)

 # Create Queue Inside Storage Account
az storage queue create `
 -n $queue `
 --account-name $acct `
 --account-key $key

 # Get Storage Account Connection String
az storage account show-connection-string `
 -n $acct `
 --query "connectionString"

# Get JSON Object
$order1json = Get-Content -Path order1.json

# Send Object to Queue
az storage message put `
 --account-name $acct `
 --account-key $key `
 --queue-name $queue `
 --content $order1json

 # Delete the Resource Group
az group delete -n $rg -y
