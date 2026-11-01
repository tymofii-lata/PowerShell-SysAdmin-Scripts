<#
.SYNOPSIS
    Einfaches Systemdiagnose-Tool fuer Windows.
.AUTHOR
    Tymofii Lata
#>

$ReportPath = "$HOME\Desktop\SystemReport.txt"
Write-Host "System-Diagnose wird ausgefuehrt..." -ForegroundColor Cyan

# 1 Hardware & System
$OS = (Get-CimInstance Win32_OperatingSystem).Caption
$CPU = (Get-CimInstance Win32_Processor).Name
$RAM = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2)

# 2 Festplattenspeicher
$DiskC = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
$FreeSpace = [math]::Round($DiskC.FreeSpace / 1GB, 2)
$TotalSpace = [math]::Round($DiskC.Size / 1GB, 2)

# 3 Netzwerk
$IPs = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -ne "127.0.0.1" }).IPAddress -join ", "
$Gateway = (Get-NetRoute -DestinationPrefix "0.0.0.0/0" -ErrorAction SilentlyContinue).NextHop

if (Test-Connection -ComputerName "8.8.8.8" -Count 1 -Quiet -ErrorAction SilentlyContinue) {
    $PingStatus = "Erfolgreich (Internet aktiv)"
} else {
    $PingStatus = "Fehlgeschlagen (Kein Internet)"
}

# 4 Bericht zusammenstellen
$Report = @"
======================================================
              SYSTEM DIAGNOSTIK REPORT
======================================================
Datum / Zeit   : $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
Computername   : $env:COMPUTERNAME

[HARDWARE & OS]
Betriebssystem : $OS
Prozessor      : $CPU
Arbeitsspeicher: $RAM GB

[SPEICHER (C:)]
Verfuegbar     : $FreeSpace GB von $TotalSpace GB

[NETZWERK]
Aktuelle IP(s) : $IPs
Gateway        : $Gateway
DNS Ping-Test  : $PingStatus
======================================================
"@

# 5. Sicherer Export (Try/Catch Fehlerbehandlung)
try {
    $Report | Out-File -FilePath $ReportPath -Encoding utf8 -ErrorAction Stop
    Write-Host "Fertig! Bericht gespeichert unter: $ReportPath" -ForegroundColor Green
} catch {
    Write-Host "Fehler beim Speichern: Keine Schreibrechte auf dem Desktop!" -ForegroundColor Red
}
