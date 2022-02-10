# 5.	Создать новую виртуальную машину

Get-Content machines.txt | ForEach-Object { $string += $_ + ',' }
$string = $string.Substring(0, $string.Length - 1) 
Set-Item WSMan:\localhost\Client\TrustedHosts -Value $string

$parameters = @{
    ComputerName = (Get-Content Machines.txt)
    Credential   = 'administrator'
    ScriptBlock  = { 
        $VMName = "VM5_PETRACHUK"
        $VM = @{
            Name               = $VMName
            MemoryStartupBytes = 1Gb
            Generation         = 2
            NewVHDPath         = "D:\Hyper-V\$VMName\$VMName.vhdx"
            NewVHDSizeBytes    = 5Gb
            BootDevice         = "VHD"
            Path               = "D:\Hyper-V\$VMName"
        }
        New-VM @VM
    }
} 
Invoke-Command @parameters