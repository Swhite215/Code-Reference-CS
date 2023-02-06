# Display Service Bus Queue or Topics Connection String - Azure CLI
az servicebus namespace authorization-rule keys list --resource-group <resource-group> --name RootManageSharedAccessKey \
--query primaryConnectionString --output tsv --namespace-name <namespace-name>

# Display # of Messages in Service Bus Queue - Azure CLI
az servicebus queue show --resource-group <resource-group> --name salesmessage --query messageCount --namespace-name <namespace-name>

# Display # of Messages in Service Bus Queue - Azure CLI
az servicebus queue show --resource-group <resource-group> --topic-name <topic-name> --name <subscription-name> --query messageCount --namespace-name <namespace-name>
