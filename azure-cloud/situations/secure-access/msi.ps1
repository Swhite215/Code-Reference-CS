# Define Important Variable
$location = "westus"
$rgname = "rbacmsistg"
$stgacct = "laaz203rbacmsistg"

# Create Resource Group
az group create --n $rgname -l $location

# Create Storage Account
az storage account create `
 -g $rgname `
 -n $stgacct `
 -l $location `
 --sku Standard_LRS

# Create Service Principal
$sp = az ad sp create-for-rbac `
 -n LaAz203StgSp | ConvertFrom-Json

# List Roles for Principal
az role assignment list --assignee $sp.appId

# Delete Subscription Level Contributor Role
az role assignment delete `
 --assignee $sp.appId --role Contributor

# List Roles for Principal
az role assignment list --assignee $sp.appId

# Get Tenant ID
$tenantid = az account show `
 --query tenantId -o tsv

# Login as Service Principal - Should Fail
az login --service-principal `
  --username $sp.appId `
  --password $sp.password `
  --tenant $tenantid 

# Add Reader Role to Principal - Subscription Level Reader Role
az role assignment create `
 --assignee $sp.appId --role Reader

# Login as Service Principal
az login --service-principal `
 --username $sp.appId `
 --password $sp.password `
 --tenant $tenantid

# List Containers - Should Fail
az storage container list `
 --account-name $stgacct

# Run Code

# Get Needed IOs
$stgacctid = az storage account show `
 -n $stgacct --query id -o tsv
$spobjid = az ad sp show `
 --id $sp.appId --query objectId -o tsv
$stgacctid
$spobjid

# Login as Main
az login

# Add Storage Account Contributor Roole to Service Principals
az role assignment create `
 --role "Storage Account Contributor" `
 --assignee-object-id $spobjid `
 --scope $stgacctid

# Login As Service Principal
az login --service-principal `
 --username $sp.appId `
 --password $sp.password `
 --tenant $tenantid

# Create Container as Service Principal
az storage container create `
 --name contribcli `
 --account-name $stgacct

# List Containers in Storage Account
az storage container list `
 --account-name $stgacct

# Run Code

# Login as Main
az login

# Delete Service Principal
az ad sp delete --id $sp.appId

# Delete Resource Group
az group delete -y -n $rgname