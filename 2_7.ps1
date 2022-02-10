# 7.	Удалить созданную виртуальную машину

Get-Content machines.txt | ForEach-Object { $string += $_ + ',' }
$string = $string.Substring(0, $string.Length - 1) 
Set-Item WSMan:\localhost\Client\TrustedHosts -Value $string

$parameters = @{
    ComputerName = (Get-Content Machines.txt)
    Credential   = 'administrator'
    ScriptBlock  = { 
        Remove-VM -Name "VM5_PETRACHUK" -Force
    }
} 
Invoke-Command @parameters