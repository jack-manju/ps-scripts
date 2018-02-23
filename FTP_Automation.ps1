param (
    $localPath = "\\172.21.24.17\Defacto FTP Backup\DeFacto\",
    $remotePath = "/Backup/"
)
try
{
    # Load WinSCP .NET assembly
    ##Add-Type -Path "WinSCPnet.dll"
    Add-Type -Path "C:\Program Files (x86)\WinSCP\WinSCPnet.dll"
    # Setup session options
  $sessionOptions = New-Object WinSCP.SessionOptions -Property @{
    #Protocol = [WinSCP.Protocol]::Ftp
    #HostName = "feeds.az1.orderdynamics.net"
    #HostName =  "52.166.207.87"
    #PortNumber = 21
    #FtpSecure = [WinSCP.FtpSecure]::Explicit

    Protocol = [WinSCP.Protocol]::Ftp
    HostName = " "
    PortNumber = 21
    UserName = " "
    Password = " "
    FtpSecure = [WinSCP.FtpSecure]::Explicit
    TlsHostCertificateFingerprint = "f1:ab:86:cf:20:18:83:8c:b8:7c:d9:f6:73:b3:df:2b:16:12:b2:01"
  }
    $session = New-Object WinSCP.Session
    try
    {
        # Connect
        $session.Open($sessionOptions)
        # Get list of files in the directory
        $directoryInfo = $session.ListDirectory($remotePath)
        # Select the most recent file
        $latest =
            $directoryInfo.Files |
            Where-Object { -Not $_.IsDirectory } |
            Sort-Object LastWriteTime -Descending |
            Select-Object -First 1
        # Any file at all?
        if ($latest -eq $Null)
        {
            Write-Host "No file found"
            exit 1
        }
        # Download the selected file
        $session.GetFiles($session.EscapeFileMask($remotePath + $latest.Name), $localPath).Check()
    }
    finally
    {
        # Disconnect, clean up
        # $session.Dispose()
    }
    ########################
    #Delete the file
    ########################
    try
    {
        # Download the selected file
        $session.RemoveFiles($session.EscapeFileMask($remotePath + $latest.Name)).Check()  #Uncomment if the scomtestfile.txt file should be deleted again.
    }
    finally
    {
        # Disconnect, clean up
        $session.Dispose()
    }

    exit 0
}
catch [Exception]
{
     
    exit 1
}