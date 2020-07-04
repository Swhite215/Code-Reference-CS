# Define Important Variables
$stgacctname = "laaz203blobsas"
$container = "images"
$rgname = "blobsas"
$location = "westus"

# Create Resource Group
az group create -n $rgname -l $location

# Create Storage Account
az storage account create `
 -g $rgName `
 -n $stgacctname `
 -l $location `
 --sku Standard_LRS

# Get Storage Account Key
$stgacctkey = $(az storage account keys list `
 -g $rgname `
 --account-name $stgacctname `
  --query "[0].value" `
  --output tsv)
 $stgacctkey

# Create Container in Storage Account
az storage container create `
 --account-name $stgacctname `
 --account-key $stgacctkey `
 --name $container

# Upload Blob to Container
az storage blob upload `
 --account-name $stgacctname `
 --account-key $stgacctkey `
 --file bleu.jpg `
 --container-name $container  `
 --name bleu.jpg

# Get URL for Specific Blob - Should Show Nothing
az storage blob url `
 --account-name $stgacctname `
 --account-key $stgacctkey `
 --container-name $container `
 --name bleu.jpg

$now = [DateTime]::UtcNow
$now

# Start and End Times of SAS Token
$start = $now.ToString('yyyy-MM-ddTHH:mmZ')
$end = $now.AddMinutes(5).ToString('yyyy-MM-ddTHH:mmZ')
$start
$end

# Generate Shared Access Signature for Specific Blob
$sas = az storage blob generate-sas `
 --account-name $stgacctname `
 --account-key $stgacctkey `
 --container-name $container `
 --name bleu.jpg `
 --permissions r `
 --start $start `
 --expiry $end
$sas

# Get URL for Specific Blob - Should Work If Using SAS
az storage blob url `
 --account-name $stgacctname `
 --account-key $stgacctkey `
 --container-name $container `
 --name bleu.jpg `
 --sas $sas `
 -o tsv