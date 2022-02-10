# 6.	Создать динамический жесткий диск

Get-Content machines.txt | ForEach-Object { $string += $_ + ',' }
$string = $string.Substring(0, $string.Length - 1) 
Set-Item WSMan:\localhost\Client\TrustedHosts -Value $string

$parameters = @{
    ComputerName = (Get-Content Machines.txt)
    Credential   = 'administrator'
    ScriptBlock  = { 
        New-VHD -Path D:\vDisk.vhdx -SizeBytes 2GB
    }
} 
Invoke-Command @parameters