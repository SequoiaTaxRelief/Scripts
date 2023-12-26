# Import the PsExec module
Import-Module -Name PsExec

# Define the path to the PsExec executable
$PsExecPath = "C:\Path\To\PsExec.exe"

# Define the path to the MSI file
$MsiPath = "C:\Path\To\wazuh-agent-4.6.0-1.msi"

# Define the command to execute on the remote machine
$Command = "msiexec /x wazuh-agent-4.6.0-1.msi /qn"

# Define the prefix for the computer names
$ComputerNamePrefix = "str"

# Define the output file for error logging
$ErrorLogFile = "C:\Path\To\errorlog.txt"

# Query for computers starting with the specified prefix
$Computers = Get-ADComputer -Filter {Name -like "$ComputerNamePrefix*"} | Select-Object -ExpandProperty Name

# Loop through the computers and execute the command
foreach ($Computer in $Computers) {
    try {
        # Copy the MSI file to the remote machine
        & $PsExecPath "\\$Computer" -c -f -s -h -n 5 -w "C:\Temp" cmd /c "copy $MsiPath C:\Temp\"

        # Execute the command on the remote machine
        & $PsExecPath "\\$Computer" -s -h -n 5 -w "C:\Temp" cmd /c "$Command"
    }
    catch {
        # Log any errors to the error log file
        Add-Content -Path $ErrorLogFile -Value "Error executing command on $Computer: $_"
    }
}