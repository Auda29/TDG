# Godot Project Notes

Dieses Verzeichnis enthält das initiale Godot-Projektgerüst für den ersten TDG-Prototype.

## Aktuelle Annahmen
- Engine: **Godot**
- Platzierungssystem: **freie Platzierung**
- Commander: **aktive Einheit auf dem Feld**

## Ziel der Struktur
Die Struktur ist bewusst auf den ersten Vertical Slice ausgerichtet und soll vor allem diese Systeme sauber trennen:
- Tower / Defense Units
- Gegner
- Wellen
- Commander
- freie Platzierung
- UI / HUD

## Wichtige Einstiegsdateien
- `project.godot`
- `scenes/bootstrap/main.tscn`
- `scenes/bootstrap/game_root.tscn`

## Hinweise
- Viele Unterordner enthalten aktuell nur `.gitkeep`-Dateien als Platzhalter.
- Die Struktur ist absichtlich leichtgewichtig und noch nicht als finale Architektur zu verstehen.
