# prepare linux distro tar
$Ubuntu = "Ubuntu-22.04"
wsl --install -d $Ubuntu

Start-Sleep 60

$tempDirectory = 'C:\Temp'
New-Item -Path $tempDirectory -ItemType Directory -Force
$installPath = Join-Path $tempDirectory 'setup.sh'
(new-object net.webclient).DownloadFile('https://raw.githubusercontent.com/luxu-ms/customization-tools/main/wsl/init-distro.sh', $installPath)
wsl -e ./setup.sh

wsl --export $Ubuntu "${tempDirectory}\${Ubuntu}.tar"
wsl --unregister $Ubuntu