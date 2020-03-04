# ----------- SQL API ---------------#

# Create an Azure Cosmos DB Account - Azure CLI
az cosmosdb create --name $NAME --kind GlobalDocumentDB --resource-group learn-b01b7956-0fd1-403d-987a-5b037b930e29

# Create an Azure Cosmos DB Database - Azure CLI
az cosmosdb sql database create --account-name $NAME --name "Products" --resource-group learn-b01b7956-0fd1-403d-987a-5b037b930e29

# Create an Azure Cosmos DB Container in a Database - Azure CLI
az cosmosdb sql container create --account-name $NAME --database-name "Products" --name "Clothing" --partition-key-path "/productId" --throughput 1000 --resource-group learn-b01b7956-0fd1-403d-987a-5b037b930e29

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