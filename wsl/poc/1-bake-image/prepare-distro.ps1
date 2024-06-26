# prepare linux distro tar
$Ubuntu = "Ubuntu-22.04"
$defaultUser = "lyle"

########################### 1-Install Ubuntu ###############################
Write-host "Install WSL distro Ubuntu 22.04"
wsl --install -d $Ubuntu -n
ubuntu2204 install --root

########################### 2-Init User ###############################
Write-host "Setup the inittial envionrment for WSL distro"
$tempDirectory = 'C:\Temp'
New-Item -Path $tempDirectory -ItemType Directory -Force
$installPath = Join-Path $tempDirectory 'init-distro.sh'
(new-object net.webclient).DownloadFile('https://raw.githubusercontent.com/luxu-ms/customization-tools/main/wsl/poc/1-bake-image/init-distro.sh', $installPath)
Set-Location $tempDirectory
wsl -- /bin/bash -c "./init-distro.sh $defaultUser"

Write-host "Set default user"
wsl --shutdown
ubuntu2204 config --default-user $defaultUser

########################### 3-Install Common Software in Linux ###############################
$installPath = Join-Path $tempDirectory 'install-software.sh'
(new-object net.webclient).DownloadFile('https://raw.githubusercontent.com/luxu-ms/customization-tools/main/wsl/poc/1-bake-image/install-software.sh', $installPath)
Set-Location $tempDirectory
wsl -- /bin/bash -c "./install-software.sh $defaultUser"

Write-host "Shutdown WSL instance"
wsl --shutdown

########################### 4-Save as tar file ###############################
Write-host "Export WSL distro"
wsl --export $Ubuntu "${tempDirectory}\${Ubuntu}.tar"

########################### 5-Prepare for generalization ###############################
Write-host "Unregister original WSL distro"
wsl --unregister $Ubuntu

Write-host "Wait for unregistering completion"
Start-Sleep 30

Get-AppxPackage Microsoft.Ink.Handwriting.Main.en-US.1.0 | Remove-AppxPackage -AllUsers
Get-AppxPackage Microsoft.Ink.Handwriting.Main.en-US.1.0.1 | Remove-AppxPackage -AllUsers
Get-AppxPackage CanonicalGroupLimited.Ubuntu22.04LTS | Remove-AppxPackage -AllUsers