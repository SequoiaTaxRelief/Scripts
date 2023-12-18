# Requires -RunAsAdministrator

# Bypass the execution policy for this session
Set-ExecutionPolicy Bypass -Scope Process -Force

# Download the Wazuh agent
$wazuhAgentUrl = "https://packages.wazuh.com/4.x/windows/wazuh-agent-4.6.0-1.msi"
$wazuhAgentFile = "${env:TEMP}\wazuh-agent-4.6.0-1.msi"
Invoke-WebRequest -Uri $wazuhAgentUrl -OutFile $wazuhAgentFile

# Install the Wazuh agent
$installArgs = "/i `"$wazuhAgentFile`" /q WAZUH_MANAGER='192.168.0.191' WAZUH_AGENT_GROUP='default' WAZUH_REGISTRATION_SERVER='192.168.0.191'"
Start-Process "msiexec.exe" -ArgumentList $installArgs -Wait

# Check if Wazuh agent is installed
$wazuhServiceName = "WazuhSvc"
if (Get-Service -Name $wazuhServiceName -ErrorAction SilentlyContinue) {
    # Start the Wazuh service
    Start-Service -Name $wazuhServiceName

    # Optional: Check the status of the service
    if ((Get-Service -Name $wazuhServiceName).Status -eq 'Running') {
        Write-Host "Wazuh agent installed and service started successfully."
    } else {
        Write-Host "Wazuh agent is installed, but the service did not start."
    }
} else {
    Write-Host "Installation of Wazuh agent failed."
}





















# original 1 line script
#-ExecutionPolicy Bypass Invoke-WebRequest -Uri https://packages.wazuh.com/4.x/windows/wazuh-agent-4.6.0-1.msi -OutFile ${env.tmp}\wazuh-agent; msiexec.exe /i ${env.tmp}\wazuh-agent /q WAZUH_MANAGER='192.168.0.191' WAZUH_AGENT_GROUP='default' WAZUH_REGISTRATION_SERVER='192.168.0.191'