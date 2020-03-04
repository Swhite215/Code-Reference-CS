# ----------- SQL API ---------------#

# Create an Azure Cosmos DB Account - Azure CLI
az cosmosdb create --name $NAME --kind GlobalDocumentDB --resource-group learn-b01b7956-0fd1-403d-987a-5b037b930e29

# Create an Azure Cosmos DB Database - Azure CLI
az cosmosdb sql database create --account-name $NAME --name "Products" --resource-group learn-b01b7956-0fd1-403d-987a-5b037b930e29
az cosmosdb database create --resource-group learn-641cf90e-a812-409c-805b-e1d6c9e2d2fb --name $NAME --db-name mslearn

# Create an Azure Cosmos DB Container in a Database - Azure CLI
az cosmosdb sql container create --account-name $NAME --database-name "Products" --name "Clothing" --partition-key-path "/productId" --throughput 1000 --resource-group learn-b01b7956-0fd1-403d-987a-5b037b930e29

# Create an Azure Cosmos DB Collection in a Database - Azure CLI
az cosmosdb collection create --resource-group learn-641cf90e-a812-409c-805b-e1d6c9e2d2fb --name $NAME --db-name mslearn --collection Small --partition-key-path /id --throughput 400

# Update an Azure Cosmos DB Collection Index - Azure CLI
az cosmosdb collection update -g learn-641cf90e-a812-409c-805b-e1d6c9e2d2fb -n $COSMOS_NAME -d mslearn -c Orders --indexing-policy @IndexConfig/index-none.json

# Get Azure Cosmos DB Account Endpoint
az cosmosdb list --resource-group learn-641cf90e-a812-409c-805b-e1d6c9e2d2fb --output tsv --query [0].documentEndpoint

# Get Azure Cosmos DB Account Key
az cosmosdb list-keys --resource-group learn-641cf90e-a812-409c-805b-e1d6c9e2d2fb  --name $COSMOS_NAME --output tsv --query primaryMasterKey

# Get Azure Cosmos DB Name
az cosmosdb list --output tsv --query [0].name

# ----------- Graph API ---------------#

# Add Nodes to Graph - Graph API
"g.addV('Product').property('id', 'p1').property('name', 'Phone Charger').property('price', 12.99)"
"g.addV('Category').property('id', 'c1').property('name', 'Mobile Phones')"

# Add Relationships to Graph - Graph API
"g.V('p1').addE('belongsto').to(g.V('c1'))"

# Return All Vertices - Graph API - REQUIRES c-g-a.js line 26
"g.V()"

# Return Count of All Vertices - Graph API - REQUIRES c-g-a.js line 26
"g.V().count()"

# Return All Edges - Graph API - REQUIRES c-g-a.js line 26
"g.E()"

# Return Count of All Edges - Graph API - REQUIRES c-g-a.js line 26
"g.E().count()"

# Query with Filters
"g.V().hasLabel('Category')" e.g. "g.V().hasLabel('Product').has('id','p1')"

# Query with Filters and Projections of Values
"g.V().hasLabel('Product').values('name','price')"

# Query with Filters, Sorting, and Projections of Values
"g.V().hasLabel('Product').order().by('price', decr).values('name','price')"

# Query with Filters and Update
"g.V('p1').property('price', 15.99)"