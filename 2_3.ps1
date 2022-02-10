# 3.	Получить только состояния имеющихся виртуальных машин. При помощи switch вывести имя ВМ и её статус различными цветами.

Get-Content machines.txt | ForEach-Object { $string += $_ + ',' }
$string = $string.Substring(0, $string.Length - 1) 
Set-Item WSMan:\localhost\Client\TrustedHosts -Value $string

$parameters = @{
    ComputerName = (Get-Content Machines.txt)
    Credential   = 'administrator'
    ScriptBlock  = { 
        $VMs = Get-VM
        switch ($VMs) {
            { Write-Host $_.Name, $_.State -ForegroundColor $([System.Enum]::GetNames([System.ConsoleColor]) | Get-Random) } { continue }
        }
    }
} 
Invoke-Command @parameters