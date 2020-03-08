# Create a VM - PowerShell
New-AzVm -ResourceGroupName <resource-group-name> -Name <name> -Credential <credentials-object> -Location <location> -Image <image-name>

# Get a VM - PowerShell
$vm = Get-AzVM  -Name <name> -ResourceGroupName <resource-group>

# Access Properties of VM - PowerShell
$vm.HardwareProfile && $vm.NetworkProfile && $vm.OsProfile && $vm.LinuxConfiguratio && $vm.Location && $vm.Type && $vm.Name && $vm.VMId && $vm.StorageProfile

# Stop a VM - PowerShell
Stop-AzVM -Name $vm.Name -ResourceGroup $vm.ResourceGroupName

# Delete a VM - PowerShell
Remove-AzVM -Name $vm.Name -ResourceGroup $vm.ResourceGroupName

# Remove VM Components - PowerShell
$vm | Remove-AzNetworkInterface –Force
Get-AzDisk -ResourceGroupName $vm.ResourceGroupName -DiskName $vm.StorageProfile.OSDisk.Name | Remove-AzDisk -Force
Get-AzVirtualNetwork -ResourceGroup $vm.ResourceGroupName | Remove-AzVirtualNetwork -Force
Get-AzNetworkSecurityGroup -ResourceGroup $vm.ResourceGroupName | Remove-AzNetworkSecurityGroup -Force
Get-AzPublicIpAddress -ResourceGroup $vm.ResourceGroupName | Remove-AzPublicIpAddress -Force