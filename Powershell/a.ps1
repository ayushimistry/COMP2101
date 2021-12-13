Param ([Parameter(Mandatory=$true)][string]$System,
       [Parameter(Mandatory=$true)][string]$Disks,
       [Parameter(Mandatory=$true)][string]$Network)

if ($System -eq "System"){    get-cpuinfo    OsReport    MemoryReport    VideocardReport}else{    "Enter valid parameter"}