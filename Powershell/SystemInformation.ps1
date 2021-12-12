function HardwareReport{
Write-Output "------------------------------------------------------"
Write-Output "System hardware description"
Write-Output "------------------------------------------------------"
get-ciminstance win32_computersystem
}
HardwareReport

Write-Output " "

function OsReport{
Write-Output "------------------------------------------------------"
Write-Output "Operation System description"
Write-Output "------------------------------------------------------"
get-ciminstance win32_operatingsystem |format-list Name, Version
}
OsReport

function ProcessorReport{
Write-Output "------------------------------------------------------"
Write-Output "Processor description"
Write-Output "------------------------------------------------------"
get-ciminstance win32_processor|
format-list  Name, NumberOfCores, CurrentClockSpeed, MaxClockSpeed,
    @{  n = "L1CacheSize"; 
        e = { switch ($_.L1CacheSize) {
                $null { $output = "Info Not Found" }
                Default { $output = $_.L1CacheSize }
            };
            $output }
    },
    @{  n = "L2CacheSize"; 
        e = { switch ($_.L2CacheSize) {
                $null { $output = "Info Not Found" }
                Default { $output = $_.L2CacheSize }
            };
            $output }
    },
    @{  n = "L3CacheSize"; 
        e = { switch ($_.L3CacheSize) {
                $null { $output = "Info Not Found" }
                0 { $output = 0 }
                Default { $output = $_.L3CacheSize }
            };
            $output }
    }
}
ProcessorReport


function MemoryReport{
Write-Output "------------------------------------------------------"
Write-Output "PhysicalMemory description"
Write-Output "------------------------------------------------------"
get-ciminstance win32_physicalmemory | Format-Table Manufacturer, 
                                                 Description,
                                                 Capacity,
                                                 BankLabel,
                                                 DeviceLocator
Write-Output "------------------------------------------------------"
Write-Output "Total RAM is:"
get-ciminstance win32_physicalmemory | Format-list Capacity
}
MemoryReport

function DiskReport{
Write-Output "------------------------------------------------------"
Write-Output "System Physical Disk Drive description"
Write-Output "------------------------------------------------------"
$diskdrives = Get-CIMInstance CIM_diskdrive

  foreach ($disk in $diskdrives) {
      $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition
      foreach ($partition in $partitions) {
            $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk
            foreach ($logicaldisk in $logicaldisks) {
                     new-object -typename psobject -property @{Manufacturer=$disk.Manufacturer
                                                               Location=$partition.deviceid
                                                               Drive=$logicaldisk.deviceid
                                                               Model=$disk.model
                                                               "Size(GB)"=$logicaldisk.Size / 1gb -as [int]
                                                               Freespace = $logicaldisk.FreeSpace
                                                            } | Format-Table Drive, Manufacturer,Model,Location,"Size(GB)",Freespace 
           }
      }
  }

}
DiskReport

function NetworkReport{
Write-Output "------------------------------------------------------"
Write-Output "System Network adapter configuration"
Write-Output "------------------------------------------------------"
$adapter = get-ciminstance win32_networkadapterconfiguration
$adapter | where-object IPEnabled -eq 'true' | format-table Description,Index,IPAddress,IPSubnet,DNSDomain,DNSServerSearchOrder
}
NetworkReport

function VideocardReport{
Write-Output "------------------------------------------------------"
Write-Output "System Video Card Description"
Write-Output "------------------------------------------------------"
get-ciminstance win32_videocontroller | Format-List Caption, Description, VideoModeDescription
}
VideocardReport
