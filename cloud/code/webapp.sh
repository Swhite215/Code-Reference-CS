# Deploy a Web Application - Azure CLI
az webapp up --name <name> --resource-group <resource-group> --plan <app-plan> --sku <app-sku> --location <location>

# Start a Web Application - Azure CLI
az webapp start --resource-group resourceGroup --name <name>

# Stop a Web Application - Azure CLI
az webapp stop --resource-group resourceGroup --name <name>

# Get Web Application Name - Azure CLI
az webapp list --query [0].name --output tsv

# Get Web Application Resource Group - Azure CLI
az webapp list --query [0].resourceGroup --output tsv

# Get App Service Plan Name - Azure CLI
az appservice plan list --query [0].name --output tsv

# Get App Service Plan SKU - Azure CLI
az appservice plan list --query [0].sku.name --output tsv

# Get App Service Plan Location - Azure CLI
az appservice plan list --query [0].location --output tsv

