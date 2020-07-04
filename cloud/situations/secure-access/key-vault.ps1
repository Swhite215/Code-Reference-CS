# Define Important Variables
$location = "westus"
$rgname = "kvsecrets"
$kvname = "laaz203kvsecrets"
$spname = "LaAz203WebAppSecrets"

# Create Resource Group
az group create --n $rgname -l $location

# Create Key Vault
az keyvault create `
 -n $kvname `
 -g $rgname `
 --sku standard 

# Create/Store A Secret in Key Vault
az keyvault secret set `
 --vault-name $kvname `
 --name "connectionString" `
 --value "this is the connection string"

# Show/Retrieve Key Vault Secret
az keyvault secret show `
 --vault-name $kvname `
 --name connectionString

# Run App

# Create a Service Principal
$sp = az ad sp create-for-rbac --name $spname | ConvertFrom-Json
$sp

# Get Tenant ID of Current Azure Active Directory Tenant
$tenantid = az account show --query tenantId -o tsv

# Log in as Service Principal
az login --service-principal `
  --username $sp.appId `
  --password $sp.password `
  --tenant $tenantid

# Show/Retrieve Key Vault Secret 
az keyvault secret show `
 --vault-name $kvname `
 --name connectionString

# Run App - Shouldn't Work

# Log Into Main Account
az login #back to main account

# Set Service Principal As Entity That Can Get From Key Vault
az keyvault set-policy `
 --name $kvname `
 --spn $sp.Name `
 --secret-permissions get

# Login As Service Principal
az login --service-principal --username $sp.appId --password $sp.password --tenant $tenantid

# Show/Retrieve Key Vault Secret
az keyvault secret show `
 --vault-name $kvname `
 --name connectionString

# Run App - Should Work

# Delete Service Principal
az ad sp delete --id $sp.appId

# Delete Key Vault
az keyvault delete --name $kvname

# Delete Resource Group
az group delete -n $rgname --yes