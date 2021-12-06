get-ciminstance win32_networkadapterconfiguration | 
    where-object IPEnabled -eq $true | 
    format-table Description,Index,IPAddress,IPSubnet,DNSDomain,DNSServerSearchOrder