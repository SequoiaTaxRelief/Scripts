# msiexec.exe /x wazuh-agent-4.5.2-1.msi /qn

# Identify Wazuh folders
$wazuhFolders = Get-ChildItem -Path "C:\Program Files (x86)\ossec-agent\" -Recurse -Directory

# Delete Wazuh folders
foreach ($folder in $wazuhFolders) {
    Remove-Item -Path $folder.FullName -Force -Recurse
}

# Optional: Verify deletion
Get-ChildItem -Path "C:\Program Files (x86)\ossec-agent*" -Recurse | Where-Object { $_ -eq "" }

Write-Host "Wazuh folders deleted successfully!"
