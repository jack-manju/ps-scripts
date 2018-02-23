# Create Zip files
$currentDateStamp = (Get-Date -UFormat %Y).ToString() + (Get-Date -UFormat %m).ToString() + (Get-Date -UFormat %d).ToString() 
$source = "E:\FusionIntegrations\Defacto"
$destination = "E:\Backup\FTP_Backup\Defacto_Backup" + "_" + $currentDateStamp + ".zip"
$TargetFolder = "E:\Backup\FTP_Backup"
#----- define extension ----#
$Extension = "*.zip"
$Now = Get-Date 
$LastWrite = $Now

If(Test-path $destination) {Remove-item $destination}
Add-Type -assembly "system.io.compression.filesystem"
[System.IO.Compression.ZipFile]::CreateFromDirectory($Source, $destination)


# ------ Copy Zip files to Aux Server ------#
Copy-Item "E:\Backup\FTP_Backup\*" -Destination "\\az1auxa01\AZ1AuxADfsR\FTPRoot\DefactoFeeds\Backup" | Out-Null
#Copy-Item "E:\Backup\FTP_Backup\*" -Destination "\\az1auxa02\AZ1AuxADfsR\FTPRoot\feeds.az1.orderdynamics.net\ODPROD\DefactoFeeds\Backup" | Out-Null
[string]$Body0 = $destination + " " + "moved to Defacto FTP Backup Location"


# ----- get files based on lastwrite filter and specified folder ---#
$Files = Get-Childitem $TargetFolder -Include $Extension -Recurse #| Where {$_.LastWriteTime -le "$LastWrite"}
#Write-Host $Files
if ($Files -eq $NULL)
{
             # Write-Host "No more files to delete!" -foregroundcolor "Green"
             $Body1 = " `r`n No more files to delete!" 
             #Write-Host $Body1
              
}
else {
foreach ($File in $Files)
    {
    if ($File -ne $NULL)
        {
            $Body1 = " `r`n Deleting File $File" #| Out-File C:\Users\gaurav.parmar\Documents\Demo\$Dt.txt
            #Write-Host $Body1
            Remove-Item $destination   #$File.FullName | out-null
        }
    }
  }
$space = Get-CimInstance -ComputerName AZ1TASKSA01 win32_logicaldisk | where caption -eq "E:" | foreach-object {write " $($_.caption) $('{0:N2}' -f ($_.Size/1gb)) GB total, $('{0:N2}' -f ($_.FreeSpace/1gb)) GB free "}  #| Out-File C:\Users\gaurav.parmar\Documents\Demo\DiskSpace_$Dt.txt

[string]$FinalBody = $Body0 + " `r`n " + $Body1 + " `r`n " + $space 

# Email setup
$emailsubject = "Archive - " + "DeFacto" + "_" + $currentDateStamp + ".zip"
$sendTo =     " "
$sendFrom =   " "
$smtpserver = " "
# Send output to email      
send-mailmessage -to $sendTo -from $sendFrom -Subject $emailsubject -smtpserver $smtpserver -Body $FinalBody