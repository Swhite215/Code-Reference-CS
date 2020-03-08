# Create a Web Application - Azure CLI
az webapp create --name <web-app-name> --resource-group <resource-group> --plan <app-plan-name>

# Deploy a Web Application - Azure CLI
az webapp up --name <name> --resource-group <resource-group> --plan <app-plan> --sku <app-sku> --location <location>

# Deploy a Web Application from Github - Azure CLI
az webapp deployment source config --name <web-app-name> --resource-group <resource-group> --repo-url "https://github.com/Azure-Samples/php-docs-hello-world" --branch master --manual-integration

# List Web Applications - Azure CLI
az webapp list --output table

# Start a Web Application - Azure CLI
az webapp start --resource-group resourceGroup --name <name>

# Stop a Web Application - Azure CLI
az webapp stop --resource-group resourceGroup --name <name>

# Get Web Application Name - Azure CLI
az webapp list --query [0].name --output tsv

# Get Web Application Resource Group - Azure CLI
az webapp list --query [0].resourceGroup --output tsv

# Create an App Service Plan - Azure CLI
az appservice plan create --name <app-plan-name> --resource-group <resource-group> --location <location> --sku FREE

# Get App Service Plan Name - Azure CLI
az appservice plan list --query [0].name --output tsv

# List App Serviuce Plans - Azure CLI
az appservice plan list --output table

# Get App Service Plan SKU - Azure CLI
az appservice plan list --query [0].sku.name --output tsv

# Get App Service Plan Location - Azure CLI
az appservice plan list --query [0].location --output tsv

