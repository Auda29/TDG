# Godot Prototype

Dieses Verzeichnis enthält den aktuellen **spielbaren Godot-Prototype** für TDG40k.

## Aktueller Stand
Der Prototype deckt bereits den Kern eines Vertical Slice ab:
- freie Tower-Platzierung in einer Build-Zone
- zwei Tower-Typen
- Commander als aktive Einheit auf dem Feld
- Wellen mit skalierenden Gegnern
- Elite- und Boss-Spawns
- HUD mit Events, Threat-Line und Boss-Bar
- Basis-Lebenspunkte, Credits und Sell-Refunds
- visuelle Readability-Features wie Lane-Warnings und Combat-VFX

## Ziel der Struktur
Die Struktur ist weiterhin bewusst leichtgewichtig gehalten, damit schnell iteriert werden kann. Im Fokus stehen aktuell:
- Tower / Defense Units
- Gegner
- Wellenlogik
- Commander-Gameplay
- Platzierungssystem
- HUD / Feedback

## Wichtige Einstiegsdateien
- `project.godot`
- `scenes/bootstrap/main.tscn`
- `scenes/bootstrap/game_root.tscn`
- `scripts/gameplay/game_root.gd`

## Relevante Bereiche
- `scenes/gameplay/towers/` — Tower-Szenen
- `scenes/gameplay/enemies/` — Gegner- und Boss-Szenen
- `scripts/gameplay/` — Gameplay-Logik
- `scripts/ui/` — HUD und Statusanzeigen
- `data/towers/` — zentrale Tower-Daten

## Hinweise
- Die Architektur ist noch prototypisch und nicht final aufgeteilt.
- Gameplay-Daten werden schrittweise zentralisiert, damit künftige Tower-Upgrades und Balance leichter iterierbar werden.
- Godot-Editor-Artefakte unter `.godot/` sollten lokal generiert und nicht versioniert werden.
