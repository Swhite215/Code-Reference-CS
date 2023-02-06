# Define Important Variables
$rgName = "logicapps"
$stgAcctName = "laaz203lasa"
$location = "westus"
$queueName = "toarchive"
$containerName = "images"

# Create Resource Group
az group create -n $rgName -l $location

# Create Storage Account
az storage account create `
 -g $rgName `
 -n $stgAcctName `
 -l $location `
 --sku Standard_LRS

 # Get Keys
$key = $(az storage account keys list `
 --account-name $stgAcctName `
 -g $rgName `
 --query "[0].value" `
 --output tsv)
$key

# Create Queue
az storage queue create `
 --name $queueName `
 --account-name $stgAcctName `
 --account-key $key

 # Create Container
az storage container create `
 --name $containerName `
 --account-name $stgAcctName `
 --account-key $key

 # Upload Blob to Container
az storage blob upload `
 --container-name $containerName `
 --name bleu.jpg `
 --file bleu.jpg `
 --account-name $stgAcctName `
 --account-key $key

 # Check Queue
az storage message peek `
 --queue-name $queueName `
 --account-name $stgAcctName `
 --account-key $key `
 --num-messages 10

 # Delete Resource Group and Resource
az group delete --name $rgName --yes