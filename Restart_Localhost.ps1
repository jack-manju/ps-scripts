param (
$websrv = '',
$sersrv = ''
)

Restart-Computer -ComputerName $websrv  -FORCE  

Restart-Computer -ComputerName $sersrv  -FORCE 
