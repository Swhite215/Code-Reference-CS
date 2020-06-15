# Define Important Variables
$rg = "webapps"
$planname = "githubdeployasp"
$appname = "laaz203githubdeploy"
$repourl = "https://github.com/Azure-Samples/php-docs-hello-world"

# Create A Resource Group
az group create `
 -n $rg -l westus

 # Create an App Service
az appservice plan create `
 -n $planname `
 -g $rg `
 --sku FREE 

 # Create a WebApp
az webapp create `
 -n $appname `
 -g $rg `
 --plan $planname 

 # Configure Github Deployment - Manual Execution
az webapp deployment source config `
 -n $appname `
 -g $rg `
 --repo-url $repourl `
 --branch master `
 --manual-integration

 # Show the Deployment Source for the WebApp
az webapp deployment source show `
 -n $appname `
 -g $rg

 # Show the WebApp
az webapp show `
 -n $appname `
 -g $rg
 
# Get Host Name of Web App
az webapp show `
 -n $appname `
 -g $rg `
 --query "defaultHostName" -o tsv

# Redeploy - Pushing New Git Version
az webapp deployment source sync -n $appname -g $rg

# Delete Resource Group
az group delete -n $rg --yes