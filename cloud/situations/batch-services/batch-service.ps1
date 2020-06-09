# Define Important Variables
$rgName = "batch" # Resource Group
$stgAcctName = "laaz203batchsa" # Storage Account
$location = "westus" # Location
$batchAcctName = "laaz203batchacct" # Batch Account Name
$poolName = "myPool" # Pool Name

# Create the Resource Group
az group create `
 -l $location `
 -n $rgName

# Create the Storage Account
az storage account create `
 -g $rgName `
 -n $stgAcctName `
 -l $location `
 --sku Standard_LRS

# Create the Batch Account
az batch account create `
 -n $batchAcctName `
 --storage-account $stgAcctName `
 -g $rgName `
 -l $location

# Log Into the Batch Account
az batch account login `
 -n $batchAcctName `
 -g $rgName `
 --shared-key-auth

# Create a Pool of Virtual Machines
az batch pool create `
 --id $poolName `
 --vm-size Standard_A1_v2 `
 --target-dedicated-nodes 2 `
 --image `
   canonical:ubuntuserver:16.04-LTS `
 --node-agent-sku-id `
   "batch.node.ubuntu 16.04"

# Verify the Pool was Created
az batch pool show `
 --pool-id $poolName `
 --query "allocationState"

# Create A Job in the Pool
az batch job create `
 --id myjob `
 --pool-id $poolName

 # Create Tasks in the Job
for ($i=0; $i -lt 4; $i++) {
    az batch task create `
     --task-id mytask$i `
     --job-id myjob `
     --command-line "/bin/bash -c 'printenv | grep AZ_BATCH; sleep 90s'" 
}

# Get Status of a Task
az batch task show `
 --job-id myjob `
 --task-id mytask1

 # Get Files inside Task
az batch task file list `
 --job-id myjob `
 --task-id mytask1 `
 --output table

 # Download Files Associated with a Task
az batch task file download `
 --job-id myjob `
 --task-id mytask0 `
 --file-path stdout.txt `
 --destination ./stdout0.txt

 # Delete Batch Pool and Resource Group
az batch pool delete -n $poolName
az group delete -n $rgName