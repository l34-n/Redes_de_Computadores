﻿Write-Output "
----------------------------------------------------------------------------------------------
   ██████╗ ███████╗███████╗ ██████╗ ██████╗ ███╗   ██╗███████╗██╗  ██╗ █████╗  ██████╗                     
   ██╔══██╗██╔════╝██╔════╝██╔════╝██╔═══██╗████╗  ██║██╔════╝╚██╗██╔╝██╔══██╗██╔═══██╗                    
   ██║  ██║█████╗  ███████╗██║     ██║   ██║██╔██╗ ██║█████╗   ╚███╔╝ ███████║██║   ██║                    
   ██║  ██║██╔══╝  ╚════██║██║     ██║   ██║██║╚██╗██║██╔══╝   ██╔██╗ ██╔══██║██║   ██║                    
   ██████╔╝███████╗███████║╚██████╗╚██████╔╝██║ ╚████║███████╗██╔╝ ██╗██║  ██║╚██████╔╝                    
   ╚═════╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝                     
                                                                                                        
            ██╗   ██╗███████╗██╗   ██╗ █████╗ ██████╗ ██╗ ██████╗ ███████╗                              
            ██║   ██║██╔════╝██║   ██║██╔══██╗██╔══██╗██║██╔═══██╗██╔════╝                              
            ██║   ██║███████╗██║   ██║███████║██████╔╝██║██║   ██║███████╗                              
            ██║   ██║╚════██║██║   ██║██╔══██║██╔══██╗██║██║   ██║╚════██║                              
            ╚██████╔╝███████║╚██████╔╝██║  ██║██║  ██║██║╚██████╔╝███████║                              
             ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝ ╚═════╝ ╚══════╝                                                                                                                                     
----------------------------------------------------------------------------------------------
  Shell para deslogar usuários remotos, que constam como desconectados nos servidores.
"
$hostname = Read-Host "Insira o nome do Servidor"
if (Test-Connection -ComputerName $hostname -Quiet -Count 1){
    $result = query session /server:$hostname
    $rows = $result -split "`n"
    foreach ($row in $rows) {  
        if ($row -NotMatch "services|console" -and $row -match "Disc") {
            $sessionusername = $row.Substring(19,20).Trim()
            $sessionid = $row.Substring(39,9).Trim()
            Write-Output "Desconectando usuário: $sessionusername"#, $session[2], $session[3]"
            logoff $sessionid /server:$hostname
        }
    }
}