# Define Important Variables
$resourceGroupName = "cosmosdb"
$location = "westus"
$accountName= "laaz203cosmosdb"
$databaseName = "myDatabase"

# Create the Resource Group
az group create `
 -n $resourceGroupName `
 -l $location

# Create a SQL API Cosmos DB Account with Session Consistency and Multi-Master Enabled
az cosmosdb create `
 -g $resourceGroupName `
 --name $accountName `
 --kind GlobalDocumentDB `
 --locations "West US=0" "North Central US=1" `
 --default-consistency-level Strong `
 --enable-multiple-write-locations true `
 --enable-automatic-failover true

# Create a Database
az cosmosdb database create `
 -g $resourceGroupName `
 --name $accountName `
 --db-name $databaseName

# List Account Keys
az cosmosdb list-keys `
 --name $accountName `
 -g $resourceGroupName

# List Account Connection Strings
az cosmosdb list-connection-strings `
 --name $accountName `
 -g $resourceGroupName

 # Get Database Endpoint
az cosmosdb show `
 --name $accountName `
 -g $resourceGroupName `
 --query "documentEndpoint"

# Clean up
az group delete -y -g $resourceGroupName