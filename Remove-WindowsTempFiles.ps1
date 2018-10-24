Function Remove-WindowsTempFiles {
    <#
        .SYNOPSIS
            This command will remove the Windows Temporary files from a computer.
        
        .DESCRIPTION
            This command will remove the Windows Temporary Files from a computer. The windows temporary files that it removes are located here c:\windows\temp\*.*
            For multiple machines use Example 3

        .PARAMETER ComputerName
            The name of the computer you want to remove the Windows Temporary Files from.

        .EXAMPLE
            Remove-WindowsTempFiles -ComputerName MyComputerName

        .EXMAPLE
            Remove-WindowsTempFiles MyComputerName

        .EXMAPLE
            Get-Content c:\temp\computernames.txt | Remove-WindowsTempFiles
    #>

    [CmdletBinding()]
    Param([Parameter(Mandatory=$true,
            ValueFromPipeline=$true)]
            [string[]]$ComputerName
            )
    Process{
        foreach ($computer in $ComputerName){
            Remove-Item -Path ("\\"+$computer+"c$\windows\temp\*")`
                        -Recurse `
                        -Force `
                        -ErrorAction SilentlyContinue
        }
    }
}    