<#
.SYNOPSIS
    Einfaches Systemdiagnose-Tool fuer Windows.
.DESCRIPTION
    Liest grundlegende Hardware-, Speicher- und Netzwerkinformationen aus
    und speichert die Ausgabe in einer Textdatei auf dem Desktop.
.AUTHOR
    Tymofii Lata
#>

# Pfad fur den Export auf dem Desktop definieren
$ReportPath = "$HOME\Desktop\SystemReport.txt"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "   Windows System-Diagnose laeuft...     " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# 1. Hardware & System abfragen
$OS = (Get-CimInstance Win32_OperatingSystem).Caption
$CPU = (Get-CimInstance Win32_Processor).Name
$RAM = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2)

# 2. Festplattenspeicher (Laufwerk C:)
$DiskC = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
$FreeSpaceGB = [math]::Round($DiskC.FreeSpace / 1GB, 2)
$TotalSpaceGB = [math]::Round($DiskC.Size / 1GB, 2)

# 3. Netzwerk (einfach gehalten: nimmt die erste gefundene IPv4)
$IP = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -ne "127.0.0.1" }).IPAddress[0]
$Gateway = (Get-NetRoute -DestinationPrefix "0.0.0.0/0" -ErrorAction SilentlyContinue).NextHop

# 4. Bericht zusammenstellen
$Report = @"
======================================================
              SYSTEM DIAGNOSTIK REPORT
======================================================
Datum / Zeit   : $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
Computername   : $env:COMPUTERNAME
Benutzer       : $env:USERNAME

[HARDWARE & OS]
Betriebssystem : $OS
Prozessor      : $CPU
Arbeitsspeicher: $RAM GB

[SPEICHER (C:)]
Freier Platz   : $FreeSpaceGB GB von $TotalSpaceGB GB verfuegbar

[NETZWERK]
Aktuelle IPv4  : $IP
Gateway        : $Gateway
======================================================
"@

# 5. Datei schreiben
$Report | Out-File -FilePath $ReportPath -Encoding utf8

Write-Host "`nFertig! Bericht gespeichert unter: $ReportPath" -ForegroundColor Green
