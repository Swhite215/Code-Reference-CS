# Create a Key Vault - PowerShell
New-AzKeyVault -Name <name> -ResourceGroupName <resource-group>

# Get Key Vault - PowerShell
Get-AzureRmKeyVault

# Get Secret - PowerShell
(Get-AzKeyVaultSecret -vaultName <vault-name> -name <secret-name>).SecretValueText