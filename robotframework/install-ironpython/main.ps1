param(
    [Parameter()]
    [string]$InstallerName,
    [Parameter()]
    [string]$Version
 )
# download ironpython from URL
$installerPath = Join-Path -Path $env:TEMP -ChildPath $InstallerName
Write-Host "Downloading IronPython ${installerPath}..."
(new-object net.webclient).DownloadFile("https://github.com/IronLanguages/ironpython2/releases/download/ipy-${Version}/IronPython-${Version}.msi", $installerPath)

# install ironpython
Write-Host 'Installing IronPython ...'
Start-Process -FilePath 'msiexec.exe'  -ArgumentList  `
    "/i $installerPath /qn" `
    -NoNewWindow -Wait -PassThru