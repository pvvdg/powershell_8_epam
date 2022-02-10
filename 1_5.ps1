# 5.	Удалить шару из предыдущего пункта

Get-Content machines.txt | ForEach-Object { $string += $_ + ',' }
$string = $string.Substring(0, $string.Length - 1) 
Set-Item WSMan:\localhost\Client\TrustedHosts -Value $string

$parameters = @{
    ComputerName = (Get-Content Machines.txt)
    Credential   = 'k502'
    ScriptBlock  = { 
        Remove-SmbShare -Name "SharedFolder"  -Force
    } 
}
Invoke-Command @parameters