# PowerShell System Diagnostics Tool

Ein praktisches PowerShell-Skript zur schnellen Erfassung von System-, Hardware- und Netzwerkdaten unter Windows.

## Funktionen

* **System- & Hardware-Info:** Liest Betriebssystem, Prozessor (CPU) und RAM-Grösse (in GB) aus.
* **Speicherplatz:** Prüft die Belegung der Systempartition (`C:`).
* **Netzwerk & Konnektivität:** Erfasst alle aktiven IPv4-Adressen (auch bei mehreren Netzwerkadaptern) sowie das Standardgateway. Führt automatisch einen Ping-Test zum Google-DNS (`8.8.8.8`) durch.
* **Sicherer Export:** Speichert die gesammelten Daten als formatierte Textdatei (`SystemReport.txt`) auf dem Desktop. Integrierte `Try/Catch`-Fehlerbehandlung verhindert Skript-Abstürze bei fehlenden Schreibrechten.

## Voraussetzungen

* Windows 10 oder Windows 11
* Windows PowerShell 5.1 oder neuer
