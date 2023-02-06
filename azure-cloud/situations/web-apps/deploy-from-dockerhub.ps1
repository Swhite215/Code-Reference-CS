# Define Important Variables
$rg = "webapps"
$planname = "dockerhubdeployasp"
$appname = "laaz203dockerhubdeploy"
$container = "microsoft/dotnet-samples:aspnetapp"

# Create the Resource Group
az group create -n $rg -l westus

# Create an App Service
az appservice plan create `
 -n $planname `
 -g $rg `
 --sku B1 `
 --is-linux
 
# Create a WebApp That Uses Docker Container
az webapp create `
 -n $appname `
 -g $rg `
 --plan $planname `
 --deployment-container-image-name $container 

# Map App Service Port to Container Port
az webapp config appsettings set `
 -g $rg `
 -n $appname `
 --settings WEBSITES_PORT=80

# Get WebApp Information
az webapp show -n $appname -g $rg

# Get WebAPP Host Name
az webapp show -n $appname -g $rg --query "defaultHostName" -o tsv

# Delete Resource Group
az group delete -n $rg --yes