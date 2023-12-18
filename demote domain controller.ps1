###########################
###     MDL 12/6/23     ###
### Script to demote DC ###
###########################

# Import the ADDSDeloyment module 
Import-Module ADDSDeployment

# demote the server 
Uninstall-ADDSDomainController -DemoteOperationMasterRole:$true -Force:$true
# -RemoveDnsDelegation:{$true|$false} 

#Run this after reboot to remove the active directory sites and services if necessary
Uninstall-WindowsFeature AD-Domain-Services -IncludeManagementTools


# all available options for demotion and removals 

<#
ADDSDeployment and ServerManager Cmdlets	Arguments (Bold arguments are required. Italicized arguments can be specified by using Windows PowerShell or the AD DS Configuration Wizard.)
Uninstall-ADDSDomainController	-SkipPreChecks
-LocalAdministratorPassword
-Confirm
-Credential
-DemoteOperationMasterRole
-DNSDelegationRemovalCredential
-Force
-ForceRemoval
-IgnoreLastDCInDomainMismatch
-IgnoreLastDNSServerForZone
-LastDomainControllerInDomain
-Norebootoncompletion
-RemoveApplicationPartitions
-RemoveDNSDelegation
-RetainDCMetadata
Uninstall-WindowsFeature/Remove-WindowsFeature	-Name
-IncludeManagementTools
-Restart
-Remove
-Force
-ComputerName
-Credential
-LogPath
-Vhd
#>