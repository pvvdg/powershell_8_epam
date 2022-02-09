# 1.	Вывести все IP адреса вашего компьютера (всех сетевых интерфейсов)

$Adapters = Get-NetAdapter | Where-Object { $_.status -eq "Up" }
$AllIP = Foreach ($Adapter in $Adapters)
{ (Get-NetIPAddress | Where-Object { $_.InterfaceAlias -eq $Adapter.name }).IPv4Address }
$AllIP