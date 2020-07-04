# Define Important Variables
$rgName="sql"
$location="westus"
$serverName="laaz203sqlserver"
$adminLogin="ServerAdmin"
$adminPassword="Change!Me!Please"
$dbName="masking"

# Create Resource Group
az group create -n $rgName -l $location

# Create SQL Server
az sql server create -g $rgName -l $location -n $serverName `
  --admin-user $adminLogin --admin-password $adminPassword

# Create SQL Database
az sql db create `
  -g $rgName `
  -s $serverName `
  -n $dbName `
  --service-objective S0 

<#
CREATE TABLE dbo.Users (
  UserId int NOT NULL,
  AccountCode varchar(50) NOT NULL,
  Pin varchar(10) NOT NULL,
  Name varchar(50) NOT NULL
)
  
INSERT INTO Users VALUES(1, '123-4567-89', 'ABCD', 'Mike')
SELECT * FROM Users;
#>

# Create Masking Rule in Database, Table Users, Column AccountCode, Text Masking to Show Just Last Two Digits
New-AzureRmSqlDatabaseDataMaskingRule `
  -ResourceGroupName $rgName `
  -ServerName $serverName `
  -DatabaseName $dbName `
  -SchemaName "dbo" `
  -TableName "Users" `
  -ColumnName "AccountCode" `
  -MaskingFunction Text `
  -SuffixSize 2 `
  -ReplacementString "xxxxxxxx"

  <#
  USE masking;
  GO
  CREATE USER user1 WITHOUT LOGIN;
  GRANT SELECT ON OBJECT::dbo.Users TO user1;  
  GO
  
  USE masking;
  EXECUTE AS USER = 'user1';
  SELECT * FROM Users;
  REVERT;
#>  

# Remove Masking Rule from Database, Table Users, Column AccountCode
Remove-AzureRmSqlDatabaseDataMaskingRule `
  -ResourceGroupName $rgName `
  -ServerName $serverName `
  -DatabaseName $dbName `
  -SchemaName "dbo" `
  -TableName "Users" `
  -ColumnName "AccountCode" 

# Create Masking Rule in Database, Table Users, Column AccountCode, Text Masking to Show Just First Two Digits
New-AzureRmSqlDatabaseDataMaskingRule `
  -ResourceGroupName $rgName `
  -ServerName $serverName `
  -DatabaseName $dbName `
  -SchemaName "dbo" `
  -TableName "Users" `
  -ColumnName "AccountCode" `
  -MaskingFunction Text `
  -PrefixSize 2 `
  -ReplacementString "xxxxxxxx"