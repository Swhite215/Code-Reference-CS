# Create a Azure Event Hubs Namespace - Azure CLI
az eventhubs namespace create

# Create a Azure Event Hubs Authorization Rule - Azure CLI
az eventhubs namespace authorization-rule create

# Delete a Azure Event Hubs Authorization Rule - Azure CLI
az eventhubs namespace authorization-rule delete

# Show Azure Event Hubs Authorization Rule Details - Azure CLI
az eventhubs namespace authorization-rule show

# Create a Azure Event Hubs Event Hub - Azure CLI
az eventhubs eventhub create --name <name> --namespace-name <namespace-name>

# SHow Azure Event Hubs Event Hub Details - Azure CLI
az eventhubs eventhub show --namespace-name <namespace-name> --name <name>