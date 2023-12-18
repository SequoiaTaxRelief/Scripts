###########################
###     MDL 12/6/23     ###
### Script to demote DC ###
###########################

Import-Module ADDSDeployment
Install-ADDSDomainController `
-NoGlobalCatalog:$false `
-CreateDnsDelegation:$false `
-CriticalReplicationOnly:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainName "ad.sequoiataxrelief.com" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SiteName "Default-First-Site-Name" `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true

# before all that you have to install ADDS
Install-WindowsFeature AD-Domain-Services –IncludeManagementTools -Verbose
#verify install 
Get-WindowsFeature -Name *AD*

