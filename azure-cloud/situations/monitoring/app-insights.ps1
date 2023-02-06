# Define Important Variables
$resourceGroup = "appinsights"
$appInsightsName = "laaz203aisample"

# Create Resource Group
az group create -n $resourceGroup -l eastus

# Properties File of Config
$propsFile = "props.json"
'{"Application_Type":"web"}' | Out-File $propsFile

# Create Application Insights Resource
az resource create `
    -g $resourceGroup -n $appInsightsName `
    --resource-type "Microsoft.Insights/components" `
    --properties "@$propsFile"
Remove-Item $propsFile

# Show Application Insights Instrumentation Key
az resource show -g $resourceGroup -n $appInsightsName `
    --resource-type "Microsoft.Insights/components" `
    --query "properties.InstrumentationKey" -o tsv

# Delete Resource Group
az group delete -n $resourceGroup