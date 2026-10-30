# PowerShell System Diagnostics Tool

Ein praktisches PowerShell-Skript zur schnellen Erfassung von System-, Hardware- und Netzwerkdaten unter Windows.

## Funktionen

* **System- & Hardware-Info:** Betriebssystem, Prozessor (CPU), RAM-Grösse (in GB).
* **Speicherplatz:** Prüft die Belegung der Systempartition (`C:`).
* **Netzwerk:** Liest die aktive IPv4-Adresse und das Standardgateway aus.
* **Export:** Speichert die gesammelten Daten automatisch als formatierte Textdatei (`SystemReport.txt`) auf dem Desktop.

---

## Geplante Erweiterungen & Bekannte Limitierungen (Work in Progress)

- [x] Grundlegende Hardware- und Systemabfrage via CIM
- [x] Export der Ergebnisse in eine Textdatei
- [ ] **Limitierung:** Bei mehreren Netzwerkadaptern wird aktuell nur die erste gefundene IP-Adresse übernommen.
- [ ] **TODO:** Try/Catch-Fehlerbehandlung einbauen, falls Schreibrechte auf dem Desktop fehlen.
- [ ] **TODO:** Ping-Test zu einem externen DNS-Server (z. B. `8.8.8.8`) direkt im Skript ergänzen.

## Voraussetzungen

* Windows 10 oder Windows 11
* Windows PowerShell 5.1 oder PowerShell 7
