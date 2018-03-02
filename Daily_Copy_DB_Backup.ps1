param (

    $source = "",
    $dest = ""
)
$today = get-date -Format yyyyMMdd

robocopy  $source $dest /s /maxage:$today 
