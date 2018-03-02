$RemoteComputer = ''

Invoke-Command -Computername $RemoteComputer -ScriptBlock { Get-ChildItem "E:\Backup\Deployment Script" }
Invoke-Command -ComputerName $RemoteComputer -FilePath 'E:\Backup\Deployment Script\test.ps1'  -Verbose


