Param ([Parameter][string]$System,
       [Parameter][string]$Disks,
       [Parameter][string]$Network)


Write-Output "-------------------------------------------------- "
if ($System -eq 'true' -Or $System -ne 'true'){get-cpuinfoOsReportMemoryReportVideocardReport}Write-Output "-------------------------------------------------- "if($Disks -eq 'true' -Or $Disks -ne 'true'){DiskReport}Write-Output "-------------------------------------------------- "if($Network -eq 'true'-Or $Network -ne 'true'){NetworkReport}break