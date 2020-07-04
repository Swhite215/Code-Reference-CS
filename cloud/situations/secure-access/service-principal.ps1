# Define Important Variables
$spname = "LaAz203SampleWebAppPrincipal"

# Create Principal
$sp = az ad sp create-for-rbac --name $spname | ConvertFrom-Json
$sp

#Delete Service Principal
#az ad sp delete --id $sp.appId

# Get Principal Information
az ad sp show --id $sp.appId

# Get Principal by Name
az ad sp list --display-name $spname

# Look up Principal Roles
az role assignment list --assignee $sp.appId

# List Azure Roles
az role definition list --output json `
  --query '[].{"roleName":roleName, "description":description}'

# List Custom Roles
az role definition list --custom-role-only false --output json --query '[].{"roleName":roleName, "description":description, "roleType":roleType}'

# Get Definition for Specific Role
z role definition list --name "Contributor"

# Get Actions and NotActions for Specific Role
az role definition list --name "Contributor" `
  --output json --query '[].{"actions":permissions[0].actions, "notActions":permissions[0].notActions}'

# Define Important Variables
$webappname = "laaz203samplewebapp"
$webapprgname = "laaz203samplewebapprg"
$webappplanname = "laaz203samplewebappplan"
$location = "westus"

# Create Resource Group
az group create -n $webapprgname -l $location

# Create App Service
az appservice plan create `
 -n $webappplanname `
 -g $webapprgname `
 --sku FREE

# Create Web App
az webapp create `
 -g $webapprgname `
 --plan $webappplanname `
 -n $webappname 

# Get Resource ID We Want to Assign Role To
$sampleweb = az webapp show `
 --name $webappname `
 -g $webapprgname  | ConvertFrom-Json
$sampleweb.id

# Create Role Assignment - Assign Principal to Scope
az role assignment create `
 --role "Website Contributor" `
 --assignee $sp.appId `
 --scope $sampleweb.id

 # Delete Role Assignment
az role assignment delete --assignee $sp.appId --role "Contributor"

# Enable MSI on Service - Give Identity to Service
$sysid = az webapp identity assign `
 -g $webapprgname `
 -n $webappname
$sysid

# Show Identity Associated with Service
az webapp identity show `
 -n $webappname -g $webapprgname

 # Delete WebApp
az webapp delete -n $webappname -g $webapprgname

# Delete Service Principal
az ad sp delete --id $sp.appId

