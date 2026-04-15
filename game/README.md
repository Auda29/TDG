# Godot Prototype

Dieses Verzeichnis enthält den aktuellen **spielbaren Godot-Prototype** für TDG40k.

## Aktueller Stand
Der Prototype deckt bereits den Kern eines Vertical Slice ab:
- freie Tower-Platzierung in einer Build-Zone
- fünf spielbare MVP-Tower-Klassen mit klareren Rollen:
  - Musterline Redoubt
  - Auric Sentinel Lancepost
  - Pyre Chapel Array
  - Cogforged Relay Spire
  - Reliquary Bombard
- Commander-Auswahl vor dem Run, danach im Run gesperrt
- Commander als aktive Einheit auf dem Feld mit Overwatch-Supportfähigkeit
- Kampagne- und Endlosmodus mit Schwierigkeitswahl und Unlock-Fortschritt
- persistente Profileinstellungen für Sprache, Modus, Audio, Vollbild und Freischaltungen
- bilinguale UI (Deutsch / Englisch)
- Wellen mit skalierenden Gegnern und sinnvoller gestaffelten Elite-/Boss-Spawns
- integrierte MVP-Gegnerrollen: Schwarm, schneller Breacher, Tank/Elite, Support, Boss
- HUD mit Events, Threat-Line, Boss-Bar, Endscreen und Ingame-Settings-Overlay
- Basis-Lebenspunkte, Credits und Sell-Refunds
- visuelle Readability-Features wie Lane-Warnings und Combat-VFX
- datengetriebene Content-Ressourcen für Tower, Gegner und Commander
- MVP-Content-Browser im Startmenü

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
- `scenes/gameplay/commander/` — Commander-Szenen
- `scripts/gameplay/` — Gameplay-Logik
- `scripts/ui/` — Startmenü, HUD, Overlays und Statusanzeigen
- `scripts/data/` — gemeinsame datengetriebene Content-Typen
- `data/towers/` — Live-Tower-Daten
- `data/mvp/` — abgeleitete MVP-Configs für Tower, Gegner und Commander

## Hinweise
- Die Architektur ist noch prototypisch und nicht final aufgeteilt.
- Gameplay-Daten wurden bereits stärker zentralisiert und sollen weiter datengetrieben ausgebaut werden.
- Mehrere jüngere UI-, Theme-, Content- und Szenenänderungen wurden statisch vorbereitet, aber nicht vollständig runtime-validiert.
- Godot-Editor-Artefakte unter `.godot/` sollten lokal generiert und nicht versioniert werden.
