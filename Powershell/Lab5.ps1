Param ([Parameter(Mandatory=$true)][string]$System,
       [Parameter(Mandatory=$true)][string]$Disks,
       [Parameter(Mandatory=$true)][string]$Network)

Write-Output "-------------------------------------------------- "
if($System -eq "System"){get-cpuinfoOsReportMemoryReportVideocardReport}else{"Enter valid parameter"}Write-Output "-------------------------------------------------- "if($Disks -eq "Disks"){DiskReport}else{"Enter valid parameter"}Write-Output "-------------------------------------------------- "if($Network -eq "Network"){NetworkReport}else{"Please write correct parameter"}break