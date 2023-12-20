# add environment variable path
param(
    [Parameter()]
    [string]$Path,
    [Parameter()]
    [string]$Scope
 )
function Add-Path($Path, $Scope) {
    if(($Scope -eq "Machine") -or ($Scope -eq "User")) {
        $Path = [Environment]::GetEnvironmentVariable('PATH', $Scope) + [IO.Path]::PathSeparator + $Path
        [Environment]::SetEnvironmentVariable( 'Path', $Path, $Scope)
    }
}

if($Path) {
    Add-Path $Path $Scope
}