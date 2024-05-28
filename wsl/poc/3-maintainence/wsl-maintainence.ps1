Write-host "=============Shutdown all WSL instances============="
wsl --shutdown

Write-host "=============Upgrade wsl============="
wsl --update

Write-host "=============Update apt software============="
wsl  -- /bin/bash -c "sudo apt update && sudo apt upgrade && echo 'test wsl' > ~/test.txt"

Write-host "=============Maintainence End============="
exit 0
