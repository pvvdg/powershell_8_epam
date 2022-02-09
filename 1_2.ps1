# 2.	Получить mac-адреса всех сетевых устройств вашего компьютера и на удалённых хостах.

Get-Content machines.txt | ForEach-Object { $string += $_ + ',' }
$string = $string.Substring(0, $string.Length - 1) 
Set-Item WSMan:\localhost\Client\TrustedHosts -Value $string

Get-NetAdapter | ForEach-Object {
    Write-Host ($_.Name , $_.MacAddress) -Separator ' - '
}

$parameters = @{
    ComputerName = (Get-Content Machines.txt)
    Credential   = Get-Credential
    ScriptBlock  = { Get-NetAdapter | ForEach-Object {
            Write-Host ($_.Name , $_.MacAddress) -Separator ' - '
        }
    } 
}
Invoke-Command @parameters
