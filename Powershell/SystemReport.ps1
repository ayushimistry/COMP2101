﻿Param ([Parameter(Mandatory=$true)][string]$System,
       [Parameter(Mandatory=$true)][string]$Disks,
       [Parameter(Mandatory=$true)][string]$Network)


Write-Output "-------------------------------------------------- "
if ($System -eq "System"){