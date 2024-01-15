$TaskName = "Procmon"
$RunAsUserTask = "DevBoxCustomizations${TaskName}"
$ShedService = New-Object -comobject "Schedule.Service"
$ShedService.Connect()

# Schedule the script to be run in the user context on login
$Task = $ShedService.NewTask(0)
$Task.RegistrationInfo.Description = "Dev Box Customizations for ${TaskName}"
$Task.Settings.Enabled = $true
$Task.Settings.AllowDemandStart = $false
$Task.Principal.RunLevel = 1

$Trigger = $Task.Triggers.Create(9)
$Trigger.Enabled = $true

$Action = $Task.Actions.Create(0)
$Action.Path = "C:\ProgramData\chocolatey\bin\Procmon64.exe"
$Action.Arguments = "/AcceptEula"

$TaskFolder = $ShedService.GetFolder("\")
$TaskFolder.RegisterTaskDefinition("$($RunAsUserTask)", $Task , 6, "Users", $null, 4)
