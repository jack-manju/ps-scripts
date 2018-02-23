
$from =      'E:\Web.Origin\'

$CN_WEBA01 = '\\azpretweba01\AZPretWebDfsR\Websites\www..cn'
$UK_WEBA01 = '\\azpretweba01\AZPretWebDfsR\Websites\www..co.uk'
$US_WEBA01 = '\\azpretweba01\AZPretWebDfsR\Websites\www..com'
$HK_WEBA01 = '\\azpretweba01\AZPretWebDfsR\Websites\www..hk'
$FR_WEBA01 = '\\azpretweba01\AZPretWebDfsR\Websites\www..fr'


$CN_WEBA02 = 'E:\AZPretWebDfsR\Websites\www..cn'
$UK_WEBA02 = 'E:\AZPretWebDfsR\Websites\www..co.uk'
$US_WEBA02 = 'E:\AZPretWebDfsR\Websites\www..com'
$HK_WEBA02 = 'E:\AZPretWebDfsR\Websites\www..hk'
$FR_WEBA02 = 'E:\AZPretWebDfsR\Websites\www..fr'



Get-ChildItem -Path $from | % { 
  
  <# COPY LATEST CODE TO PRETWEBA01 #>

  Write-Host("WEBA01 Deployment in Progress") 
  
<#  Copy-Item $_.fullname "$CN_WEBA01"  -Recurse -Force -Verbose 
  Copy-Item $_.fullname "$UK_WEBA01"  -Recurse -Force -Verbose
  Copy-Item $_.fullname "$US_WEBA01"  -Recurse -Force -Verbose
  Copy-Item $_.fullname "$HK_WEBA01"  -Recurse -Force -Verbose  #>
  Copy-Item $_.fullname "$FR_WEBA01"  -Recurse -Force -Verbose

   Write-Host("WEBA02 Deployment in Progress")

<#  Copy-Item $_.fullname "$CN_WEBA02"  -Recurse -Force -Verbose 
  Copy-Item $_.fullname "$UK_WEBA02"  -Recurse -Force -Verbose
  Copy-Item $_.fullname "$US_WEBA02"  -Recurse -Force -Verbose
  Copy-Item $_.fullname "$HK_WEBA02"  -Recurse -Force -Verbose  #>
  Copy-Item $_.fullname "$FR_WEBA02"  -Recurse -Force -Verbose

}
