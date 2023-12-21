param(
    [Parameter()]
    [string]$InstallerName,
    [Parameter()]
    [string]$Version
)

$tempDir = 'C:\temp'
New-Item $tempDir -ItemType Directory -Force

# Download windowsdesktop-runtime-6.0.25-win-x64 from URL
$dotnetx64InstallerPath = Join-Path -Path $tempDir -ChildPath "windowsdesktop-runtime-6.0.25-win-x64.exe"
Write-Host "Downloading windowsdesktop-runtime-6.0.25-win-x64 ${dotnetx64InstallerPath}..."
(new-object net.webclient).DownloadFile("https://download.visualstudio.microsoft.com/download/pr/52d6ef78-d4ec-4713-9e01-eb8e77276381/e58f307cda1df61e930209b13ecb47a4/windowsdesktop-runtime-6.0.25-win-x64.exe", $dotnetx64InstallerPath)

# Install windowsdesktop-runtime-6.0.25-win-x64
Write-Host 'Installing windowsdesktop-runtime-6.0.25-win-x64 ...'
Start-Process -FilePath $dotnetx64InstallerPath  -ArgumentList  `
        "/install", `
        "/quiet",
        "/norestart", `
        -NoNewWindow -Wait -PassThru

# Download windowsdesktop-runtime-6.0.25-win-x86 from URL
$dotnetx86InstallerPath = Join-Path -Path $tempDir -ChildPath "windowsdesktop-runtime-6.0.25-win-x86.exe"
Write-Host "Downloading windowsdesktop-runtime-6.0.25-win-x86 ${dotnetx86InstallerPath}..."
(new-object net.webclient).DownloadFile("https://download.visualstudio.microsoft.com/download/pr/33eced41-f212-46df-bb2f-12d4b891e667/f55a4581dd72a971f21e9562816c7430/windowsdesktop-runtime-6.0.25-win-x86.exe", $dotnetx86InstallerPath)

# Install windowsdesktop-runtime-6.0.25-win-x86
Write-Host 'Installing windowsdesktop-runtime-6.0.25-win-x86 ...'
Start-Process -FilePath $dotnetx86InstallerPath  -ArgumentList  `
        "/install", `
        "/quiet",
        "/norestart", `
        -NoNewWindow -Wait -PassThru

# download Storage Explorer by URL
$installerPath = Join-Path -Path $tempDir -ChildPath $InstallerName
Write-Host "Downloading Storage Explorer ${installerPath}..."
(new-object net.webclient).DownloadFile("https://github.com/microsoft/AzureStorageExplorer/releases/download/v${Version}/StorageExplorer-windows-x64.exe", $installerPath)
                                       
# install Storage Explorer
Write-Host 'Installing Storage Explorer ...'
Start-Process -FilePath $installerPath  -ArgumentList  `
        "/ALLUSERS", `
        "/SILENT",
        "/NORESTART", `
        -NoNewWindow -Wait -PassThru