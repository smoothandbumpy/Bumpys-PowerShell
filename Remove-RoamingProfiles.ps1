Function Remove-RoamingProfiles {
    <#
        .SYNOPSIS
            This command will remove Raoming Profiles that are not currently logged into a specefied computer.
        
        .DESCRIPTION
            This command will remove Roaming Profiles that are not currently logged into a specefied computer. This tool can take a few minutes to run please be patient.
            For multiple machines use Example 3

        .PARAMETER ComputerName
            The name of the computer you want to remove Roaming Profiles from.

        .EXAMPLE
            Remove-RoamingProfiles -ComputerName MyComputerName

        .EXMAPLE
            Remove-RoamingProfiles MyComputerName

        .EXMAPLE
            Get-Content c:\temp\computernames.txt | Remove-RoamingProfiles
    #>

    [CmdletBinding()]
    Param([Parameter(Mandatory=$true,
            ValueFromPipeline=$true)]
            [string[]]$ComputerName,
            [string[]]$Protocol = "wsman"
            )
    Process{
        foreach ($computer in $ComputerName){
            ""
            if($Protocol -eq 'Dcom'){
                $option = New-CimSessionOption -Protocol Dcom
            } else {
                $option = New-CimSessionOption -Protocol Wsman
            }

            $session = New-CimSession -ComputerName $computer -SessionOption $option

            $users = Get-CimInstance  -ClassName win32_UserProfile`
                                      -Filter "Roaming Configured = 'True' And Loaded = 'False'" `
                                      -CimSession $session

            $session | Remove-CimSession
            $users | Remove-CimInstance
        }
    }
}