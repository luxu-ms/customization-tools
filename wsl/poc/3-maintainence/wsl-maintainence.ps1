Write-host "=============Shutdown all WSL instances============="
wsl --shutdown

Write-host "=============Upgrade wsl============="
wsl --update

Write-host "=============Update apt software============="
wsl  -- /bin/bash -c "sudo apt update -y && sudo apt upgrade -y && echo 'test wsl' > ~/test.txt"

Write-host "=============Maintainence End============="
exit 0
