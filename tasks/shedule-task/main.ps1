param(
    [Parameter()]
    [string]$TaskName,
    [Parameter()]
    [string]$Command,
    [Parameter()]
    [string]$DelayDuration
 )

function SetupScheduledTasks {
    param(
        [string]$TaskName,
        [string]$Command
    )

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
    if($DelayDuration -ne ""){
        $Trigger.Delay = $DelayDuration
    }

    $Action = $Task.Actions.Create(0)
    $Action.Path = "C:\Program Files\PowerShell\7\pwsh.exe"
    $Action.Arguments = "-MTA -Command $($Command)"

    $TaskFolder = $ShedService.GetFolder("\")
    $TaskFolder.RegisterTaskDefinition("$($RunAsUserTask)", $Task , 6, "Users", $null, 4)
}

SetupScheduledTasks $TaskName $Command