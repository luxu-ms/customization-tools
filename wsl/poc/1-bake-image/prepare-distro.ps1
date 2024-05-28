# prepare linux distro tar
$Ubuntu = "Ubuntu-22.04"
wsl --install -d $Ubuntu

Start-Sleep 60

$tempDirectory = 'C:\Temp'
New-Item -Path $tempDirectory -ItemType Directory -Force
$installPath = Join-Path $tempDirectory 'init-distro.sh'
(new-object net.webclient).DownloadFile('https://raw.githubusercontent.com/luxu-ms/customization-tools/main/wsl/poc/1-bake-image/init-distro.sh', $installPath)
wsl -e $installPath

wsl --shutdown
Write-host "Shutdown WSL instance"
Start-Sleep 30

Write-host "Epporting WSL distro"
wsl --export $Ubuntu "${tempDirectory}\${Ubuntu}.tar"

Write-host "Unregister original WSL distro"
wsl --unregister $Ubuntu

Write-host "Wait for unregistering completion"
Start-Sleep 30

Get-AppxPackage Microsoft.Ink.Handwriting.Main.en-US.1.0 | Remove-AppxPackage -AllUsers
Get-AppxPackage Microsoft.Ink.Handwriting.Main.en-US.1.0.1 | Remove-AppxPackage -AllUsers
Get-AppxPackage CanonicalGroupLimited.Ubuntu22.04LTS | Remove-AppxPackage -AllUsers