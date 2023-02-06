# Define Important Variables
$rg = "aksdemos" # Resource Group
$cluster = "akscluster" # Cluster

# Create the Resource Group
az group create -n $rg `
 -l westus

 # Create the Cluster
az aks create -g $rg `
 -n $cluster `
 --node-count 1 `
 --generate-ssh-keys `
 --enable-addons monitoring

 # Get Cluster Credentials for kubectl
az aks get-credentials `
 -g $rg `
 -n $cluster

# Get Nodes Inside Cluster
kubectl get nodes

# Deploy Containers Based on YAML
kubectl apply -f azure-vote.yaml

# Get Service and Tail Details
kubectl get service azure-vote-front `
 --watch