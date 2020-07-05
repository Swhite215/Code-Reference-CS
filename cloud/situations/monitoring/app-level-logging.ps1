# Prepare App And Publish
Push-Location ../aicore
$publishDir = "publish"
$package = "publish.zip"
if (Test-path $publishDir) {Remove-Item -Recurse -Force $publishDir}
if (Test-path $package) {Remove-item $package}
dotnet publish -c release -o $publishDir web.csproj 
Compress-Archive -Path $publishDir/* -DestinationPath $package -Force
Move-Item -Path $package -Destination ../bloglog -Force
Pop-Location

# Define Important Variables
$planName="laaz203bloblog"
$resourceGroup = "monitorwebapps"
$appName="laaz203bloblog"
$location="westus"
$stgacct = "laaz20bloglogstg"

# Create A Resource Group
az group create -n $resourceGroup -l $location

# Create A App Service Plan
az appservice plan create -n $planName -g $resourceGroup -l $location --sku B1

# Create a Web App
az webapp create -n $appName -g $resourceGroup --plan $planName

# Deploy Zip Folder to WebAp
az webapp deployment source config-zip -n $appName -g $resourceGroup --src $package

# Launch Site
$site = az webapp show -n $appName -g $resourceGroup --query "defaultHostName" -o tsv
Start-Process https://$site

# Create A Storage Account
az storage account create `
 -g $resourceGroup `
 -n $stgacct `
 -l $location `
 --sku Standard_LRS

 # Get Storage Account Key
$key = $(az storage account keys list `
 --account-name $stgacct `
 -g $resourceGroup `
 --query "[0].value" `
 --output tsv)
$key

# Create Container in Storage Account
az storage container create `
 --name logs `
 --account-name $stgacct `
 --account-key $key

 # List Containers
az storage container list `
 --account-name $stgacct `
 --account-key $key

 # List Containers Policy List
az storage container policy list `
 -c logs `
 --account-name $stgacct `
 --account-key $key

$today = Get-Date 
$tomorrow = $today.AddDays(1)
$today.ToString("yyyy-MM-dd")
$tomorrow.ToString("yyyy-MM-dd")

# Create Storage Container Policy
az storage container policy create `
 -c logs `
 --name "logpolicy" `
 --start $today.ToString("yyyy-MM-dd") `
 --expiry $tomorrow.ToString("yyyy-MM-dd") `
 --permissions lwrd `
 --account-name $stgacct `
 --account-key $key

 # Create Shared Access Signature
$sas = az storage container generate-sas `
 --name logs `
 --policy-name logpolicy `
 --account-name $stgacct `
 --account-key $key `
 -o tsv
$sas

# Get SAS URL
$containerSasUrl = "https://$stgacct.blob.core.windows.net/logs?$sas"
$containerSasUrl

# List Service Principal
az ad sp list --display-name LaAz203WebSiteManager

# Delete Service Principal
az ad sp delete --id "a7520b14-40f8-466f-90a5-372c789781bc"

# Create New Service Principal
$sp = az ad sp create-for-rbac --name LaAz203WebSiteManager | ConvertFrom-Json

# Show Subscription ID
$subid = az account show --query "id" -o tsv

# Show Tenant ID
$tenantid = az account show --query "tenantId" -o tsv

# Echo Important Variable
$clientId = $sp.appId
$clientSecret = $sp.password
"var clientId = `"$clientId`";" 
"var clientSecret = `"$clientSecret`";"
"var subscriptionId = `"$subid`";"
"var tenantId = `"$tenantid`";"
"var sasUrl = `"$containerSasUrl`";"

# Set Application Level Logging to Informational
az webapp log config -n $appName -g $resourceGroup --level information --application-logging true

# Show Logs Config
az webapp log show -n $appName -g $resourceGroup

# Delete WebApp
az webapp delete -g $resourceGroup -n $appName

# Delete Resource Group
az group delete -g $resourceGroup --yes