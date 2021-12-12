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