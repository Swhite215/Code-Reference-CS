# Create a Virtual Machine - Azure CLI
az vm create --resource-group <resource-group> --name <name> --image Canonical:UbuntuServer:16.04-LTS:latest --admin-username <admin-username> --generate-ssh-keys

# Open a VM Port - Azure CLI
az vm open-port --port 80 --resource-group <resource-group> --name <name>

# Get VM IP Address - Azure CLI
az vm show --name <name> --resource-group <resource-group> --show-details --query [publicIps] --output tsv