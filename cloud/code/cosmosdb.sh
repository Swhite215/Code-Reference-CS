# Create an Azure Cosmos DB Account - Azure CLI
az cosmosdb create --name $NAME --kind GlobalDocumentDB --resource-group learn-b01b7956-0fd1-403d-987a-5b037b930e29

# Create an Azure Cosmos DB Database - Azure CLI
az cosmosdb sql database create --account-name $NAME --name "Products" --resource-group learn-b01b7956-0fd1-403d-987a-5b037b930e29

# Create an Azure Cosmos DB Container in a Database - Azure CLI
az cosmosdb sql container create --account-name $NAME --database-name "Products" --name "Clothing" --partition-key-path "/productId" --throughput 1000 --resource-group learn-b01b7956-0fd1-403d-987a-5b037b930e29
