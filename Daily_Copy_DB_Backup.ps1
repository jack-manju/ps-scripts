$today = get-date -Format yyyyMMdd

$source = "\\172.21.28.39\TFS_Backup"
$dest = "\\172.21.24.17\India Order Dynamics\Pune-OD Infrastructure\TFS_Backup"

robocopy  $source $dest /s /maxage:$today
