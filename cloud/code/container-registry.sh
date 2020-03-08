# Create an Azure Container Registry - Azure CLI
az acr create --name <registry-name> --resource-group <resource-group> --sku standard --admin-enabled true

# Build an Image and Upload to the ACR - Azure CLI
az acr build --file Dockerfile --registry <registry-name> --image <image-name> .

# Create a Monitoring and Build Task in the ACR - Azure CLI
az acr task create --registry <container_registry_name> --name buildwebapp --image webimage \
--context https://github.com/MicrosoftDocs/mslearn-deploy-run-container-app-service.git --branch master \
--file Dockerfile --git-access-token <access_token>