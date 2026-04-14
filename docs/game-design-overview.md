# Game Design Overview: TDG40k

> `TDG40k` is currently a working title.

## Projektüberblick
**TDG40k** ist ein Tower-Defense-Projekt mit Fokus auf:
- klare Lesbarkeit im Kampf
- starke Upgrade-Entscheidungen
- düstere Sci-Fi-Belagerungsatmosphäre
- hohen Wiederspielwert durch verschiedene Builds und Wellenverläufe

Das Spiel ist inspiriert von der Zugänglichkeit und Progressionsstärke moderner Tower-Defense-Spiele, soll aber eine **eigene Identität** entwickeln.

---

## High Concept
Der Spieler verteidigt eine befestigte Stellung gegen eskalierende Wellen aus feindlichen Angreifern. Durch das Platzieren und Aufrüsten von Verteidigungseinheiten, den Einsatz von Kommandantenfähigkeiten und das Reagieren auf spezialisierte Gegnertypen entsteht ein Mix aus Planung, Build-Optimierung und taktischer Improvisation.

Die Fantasie ist die eines **letzten Widerstands in einem düsteren futuristischen Kriegsschauplatz**.

---

## Spielerfantasie
Der Spieler soll sich fühlen wie:
- Kommandant einer belagerten Festung
- taktischer Organisator einer Verteidigungslinie
- Entscheider unter permanent wachsendem Druck
- Architekt eines eskalierenden Waffen- und Upgrade-Netzwerks

---

## Designziele

### 1. Klar lesbares Tower-Defense-Gameplay
- Einheitenrollen müssen auf einen Blick verständlich sein.
- Der Spieler soll schnell erkennen können, warum er gewinnt oder verliert.
- Effekte dürfen spektakulär sein, aber nicht unübersichtlich.

### 2. Starke Mid-Run-Entscheidungen
- Bauen, Upgraden und Timing sollen relevant sein.
- Tower sollen unterschiedliche Rollen haben, nicht nur Zahlenvarianten sein.
- Der Spieler soll verschiedene Build-Ansätze ausprobieren können.

### 3. Starke thematische Identität
- Das Setting soll nach Krieg, Belagerung und industrieller Härte wirken.
- Die Atmosphäre soll über Silhouetten, Audio, UI und Effekte getragen werden.
- Die Spielmechanik soll die Fraktionsfantasie unterstützen.

### 4. Gute Prototypisierbarkeit
- Systeme sollen früh testbar sein.
- Inhalte sollen datengetrieben erweiterbar sein.
- Scope soll kontrolliert wachsen.

---

## Kern-Gameplay-Loop
1. Eine neue Welle beginnt.
2. Gegner betreten die Karte und folgen ihrem Angriffspfad.
3. Der Spieler platziert neue Verteidigungseinheiten oder verbessert bestehende.
4. Türme und Fähigkeiten eliminieren Gegner, bevor diese das Ziel erreichen.
5. Der Spieler erhält Ressourcen und bereitet sich auf die nächste Welle vor.
6. Der Druck steigt durch neue Gegnertypen, höhere Widerstandswerte und Bossbegegnungen.

---

## Kernsysteme

### Tower / Defense Units
Geplant sind Verteidigungseinheiten mit klaren Rollen.

Mögliche Rollen:
- **Basis-Schaden**: zuverlässig, günstig, universell
- **Anti-Armor**: stark gegen schwere Ziele
- **Anti-Swarm**: Flächenschaden oder schnelle Schussfolge
- **Long Range / Elite Hunter**: stark gegen einzelne hochwertige Ziele
- **Support**: Buffs, Debuffs, Ressourcen oder Utility

Wichtige Eigenschaften:
- Kosten
- Reichweite
- Angriffstempo
- Schadensart
- Zielpriorisierung
- Upgrade-Pfade

### Gegner
Gegner sollen verschiedene Probleme darstellen, die unterschiedliche Antworten erfordern.

Geplante Rollen:
- Schwarmgegner
- Tank-Gegner
- Shield-Gegner
- Flieger
- Stealth-Gegner
- Support-Gegner
- Bossgegner

### Commander / Hero Layer
Ein Commander ergänzt die stationäre Verteidigung als **aktive Einheit auf dem Feld**.

Mögliche Funktionen:
- Zielmarkierung / Fokusfeuer
- lokale Buffs für Tower
- defensive Notfallfähigkeiten
- taktische Eingriffe bei Bosswellen

Siehe auch:
- `docs/commander-konzept.md`

### Ressourcen
Vorgesehene Ressourcenstruktur:
- **Credits** als Kernressource für Bauen und Upgraden
- optional **Command Points** oder Energie für aktive Fähigkeiten

### Upgrade-System
Upgrades sind einer der zentralen Reize des Spiels.

Ziele:
- Tower sollen sich spürbar verändern
- Builds sollen unterschiedliche Stärken erzeugen
- Entscheidungen sollen nachvollziehbar und nicht rein mathematisch wirken

Langfristige Richtung:
- mehrpfadige Upgrades pro Tower
- spezialisierte Build-Pfade
- Synergien zwischen Towern und Support-Systemen

---

## Setting und Tonalität

### Ton
- düster
- militaristisch
- episch
- bedrückend, aber heroisch

### Visuelle Sprache
- schwere Silhouetten
- Industrie, Stahl, Rauch, Energieeffekte
- große Waffen und massive Verteidigungsanlagen
- gute Kontraste für spielerische Lesbarkeit

### Weltgefühl
- Grenzsektor oder Frontgebiet
- dauerhafte Belagerungssituation
- technologische und militärische Überforderung
- heroische Verteidigung gegen eskalierende Bedrohungen

---

## Differenzierungsmerkmale
Damit sich **TDG40k** eigenständig anfühlt, sind folgende Ansätze besonders interessant:

### 1. Frontlinien- oder Kontrollzonen-System
Bestimmte Einheiten beeinflussen Raumkontrolle statt nur Schaden zu verursachen.

### 2. Suppression / Morale
Beschuss reduziert Kampfkraft oder Bewegung gegnerischer Einheiten.

### 3. Commander-Abilities als taktische Ebene
Zusätzliche Entscheidungen neben dem klassischen Tower-Bau.

### 4. Belagerungsfantasie statt reiner Arcade-Abstraktion
Verteidigung wirkt wie militärische Infrastruktur, nicht nur wie abstrakte Tower-Knoten.

---

## Zielplattform und Technik
Aktueller Stand:
- **Godot** ist als Engine für den ersten Prototyp gewählt
- Fokus auf datengetriebene, MVP-orientierte Struktur
- freie Platzierung und Feld-Commander sind Kernannahmen des ersten technischen Scopes

Siehe auch:
- `docs/tech-stack-options.md`
- `game/`

---

## MVP-Richtung
Der erste spielbare Scope ist bewusst klein gehalten.

Siehe dazu:
- `docs/mvp-scope.md`
- `docs/projekt-brainstorm.md`
- `docs/inspirations-research.md`

---

## Nicht-Ziele für die frühe Phase
- mehrere vollständige Fraktionen
- Multiplayer oder Koop
- große Kampagnenstruktur
- umfangreiche Meta-Progression
- sehr tiefe Lore-Produktion vor dem Gameplay-Nachweis

---

## Offene Designfragen
- Welche Perspektive ist final: top-down oder stärker isometrisch?
- Wie komplex sollen Upgrade-Pfade im ersten Prototyp sein?
- Welche Gegnerrolle ist für die erste Fraktion am wichtigsten?
- Soll das Spiel eher ernst oder leicht stilisiert wirken?

---

## Verwandte Dokumente
- `docs/mvp-scope.md`
- `docs/tower-klassen-konzept.md`
- `docs/enemy-faction-konzept.md`
- `docs/art-direction-notes.md`
- `docs/tech-stack-options.md`
- `docs/ip-do-dont.md`
