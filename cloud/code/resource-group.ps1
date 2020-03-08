# Get Resource Groups - PowerShell
Get-AzResourceGroup | Format-Table

# Create a Resource Group - PowerShell
New-AzResourceGroup -Name mynewresourcegroup -Location "East US"

# Get Specific Resource Group - PowerShell
Get-AzResource -ResourceGroupName ExerciseResources