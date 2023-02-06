# Create a SQL Server - Azure CLI
az sql server create --name <name> --resource-group <resource-group> --location <location> --admin-user $ADMIN_LOGIN --admin-password $PASSWORD

# Create a SQL DB - Azure CLI
az sql db create --resource-group <resource-group> --server <sql-server> --name <name>

# List DBs - Azure CLI
az sql db list
az sql db list | jq '[.[] | {name: .name}]'

# Get Specific DB - Azure CLI
az sql db show --name Logistics

# Get DB Connection Strings - Azure CLI
az sql db show-connection-string --client sqlcmd --name <name>

# Create a PostgreSQL Server - Azure CLI
az postgres server create --name <name> --resource-group <resource-group> --location <location> --sku-name B_Gen5_1 --storage-size 20480 --backup-retention 15 --version 10 --admin-user $userName --admin-password "P@ssw0rd"

# Add Firewall to PostgreSQL Server - Azure CLI
az postgres server firewall-rule create --resource-group <resource-group> --server <server-name> --name AllowAll --start-ip-address 0.0.0.0 --end-ip-address 255.255.255.255

# Remove Firewall on PostgreSQL Server - Azure CLI
az postgres server firewall-rule delete --name AllowAll --resource-group <resource-group> --server-name <server-name>
