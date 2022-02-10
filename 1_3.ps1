# 3.	На всех виртуальных компьютерах настроить (удалённо) получение адресов с DHСP

Get-Content machines.txt | ForEach-Object { $string += $_ + ',' }
$string = $string.Substring(0, $string.Length - 1) 
Set-Item WSMan:\localhost\Client\TrustedHosts -Value $string

$parameters = @{
    ComputerName = (Get-Content Machines.txt)
    Credential   = 'petrachukvv'
    ScriptBlock  = { 
        $GetDHCP = (Get-NetIPInterface -InterfaceAlias Ethernet0).DHCP
        if ($GetDHCP -match "Disabled") {
            Set-NetIPInterface -InterfaceAlias Ethernet0 -Dhcp Enabled
        }
        Write-Host 'Script worked.'
    } 
}
Invoke-Command @parameters