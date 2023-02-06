# Define Important Variables
$rgname = "eventgrid"
$location = "westus"
$stgacctname = "laaz203egsa"

# Create Resource Group
az group create -n $rgname -l $location

# Create Storage Account
az storage account create `
 -n $stgacctname `
 -g $rgname `
 -l $location `
 --sku Standard_LRS `
 --kind StorageV2 

 # Get Storage Account Keys
 $stgacctkey = $(az storage account keys list `
 -g $rgName `
 --account-name $stgacctname `
  --query "[0].value" `
  --output tsv)
 $stgacctkey
 
# run local web app and this in another terminal window
ngrok http -host-header=localhost 5000

# Define More Variables
$funcappdns = "209f0a2d.ngrok.io"
$viewerendpoint = "https://$funcappdns/api/updates"

# Get Storage Account ID
$storageid = $(az storage account show `
 -n $stgacctname `
 -g $rgname `
 --query id `
 --output tsv)
$storageid

# Create Event Grid Subscription
az eventgrid event-subscription create `
 --source-resource-id $storageid `
 --name storagesubscription `
 --endpoint-type WebHook `
 --endpoint $viewerendpoint `
 --included-event-types "Microsoft.Storage.BlobCreated" `
 --subject-begins-with "/blobServices/default/containers/testcontainer/"

# Create Blob Container
az storage container create `
 --account-name $stgacctname `
 --account-key $stgacctkey `
 --name testcontainer

# Uplaod Document to Container
touch testfile.txt
az storage blob upload `
 --account-name $stgacctname `
 --account-key $stgacctkey `
 --file testfile.txt `
 --container-name testcontainer  `
 --name testfile.txt
  
# Delete Document from Container
az storage blob delete `
 --account-name $stgacctname `
 --account-key $stgacctkey `
 --container-name testcontainer  `
 --name testfile.txt
  
# Delete Event Subcription
az eventgrid event-subscription delete `
 --resource-id $storageid `
 --name storagesubscription 

 # Delete Resource Group
az group delete -n $rgname --yes