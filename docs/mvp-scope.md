# MVP Scope: TDG40k

## Zweck
Dieses Dokument definiert den **Minimal Viable Product (MVP)** bzw. den ersten **Vertical Slice** für **TDG40k**. Ziel ist ein kleiner, spielbarer Prototyp, der den Kern des Spiels beweist, ohne zu früh zu viel Scope aufzubauen.

---

## MVP-Ziel
Der erste spielbare Build soll zeigen, dass **TDG40k** als Tower-Defense-Spiel funktioniert in Bezug auf:
- Kern-Gameplay-Loop
- Spielgefühl beim Platzieren und Aufrüsten von Verteidigungseinheiten
- Lesbarkeit im Kampf
- klare Rollen von Türmen und Gegnern
- Spannungsaufbau über Wellen bis zu einem Boss
- atmosphärische Sci-Fi-Belagerungsfantasie

Der MVP ist **kein vollständiges Spiel**, sondern ein fokussierter Nachweis für die tragenden Systeme.

---

## MVP-Inhalte

### 1. Eine spielbare Karte
- 1 Karte mit klar lesbarem Pfad oder wenigen gut verständlichen Pfaden
- 1 defensives Kernthema, z. B. Festung, Außenposten oder Industrieanlage
- begrenzte, bewusst platzierte Bauflächen
- gute Übersichtlichkeit als oberste Priorität

### 2. Eine Gegnerfraktion
Für den MVP wird nur **eine** Gegnerfraktion umgesetzt.

Empfohlene Richtung:
- aggressiver Alien-/Mutanten-Schwarm
- viele kleine Einheiten plus einige Elitegegner
- optisch und mechanisch klar lesbare Rollen

### 3. Vier bis fünf Tower-/Defense-Unit-Typen
Empfohlener MVP-Satz:
- **Basis-Gun-Tower / Infanterieposten**
- **Heavy Weapons Tower**
- **Flame / Short Range Tower**
- **Artillery / Mortar Tower**
- optional: **Support Tower** oder **Sniper Tower** als fünfter Typ

Jeder Tower-Typ braucht im MVP:
- klare Rolle
- Basiswerte
- einfache Zielerfassung
- mindestens einige Upgrades
- unterscheidbares visuelles und akustisches Feedback

### 4. Ein Commander / Held
- 1 Kommandantenfigur **auf dem Feld**
- 2 aktive Fähigkeiten reichen für den MVP
- Fokus auf spielerische Unterstützung statt Systemüberladung
- der Commander ergänzt Tower-Play, ersetzt es aber nicht

Beispielhafte Rollen:
- Zielmarkierung / Fokusfeuer
- lokale Tower-Verstärkung
- kurze Schutz- oder Stabilisierungseffekte

Siehe auch:
- `docs/commander-konzept.md`

### 5. Wellenstruktur
- 10 bis 20 Wellen insgesamt
- frühe Wellen zum Lernen
- mittlere Wellen mit Rollenmix
- späte Wellen mit Druck und Build-Test
- 1 Bosswelle oder Finalwelle am Ende

### 6. Ein Boss
Der Boss soll zeigen, dass das Spiel auch über Standardwellen hinaus Spannung aufbauen kann.

Boss-Anforderungen:
- deutlich erkennbare Silhouette
- hohe Lebenspunkte oder Spezialmechanik
- fordert andere Priorisierung als Standardgegner
- darf im MVP mechanisch einfach bleiben, aber klar als Höhepunkt funktionieren

### 7. Basales Upgrade-System
- mehrere Towers sollen Upgrades erhalten können
- keine volle Endgame-Komplexität nötig
- Ziel ist, Build-Entscheidungen spürbar zu machen

Empfehlung für MVP:
- pro Tower 2 bis 4 Upgrades insgesamt
- noch kein volles dreipfadiges Endsystem nötig
- Upgrades sollen trotzdem Rollen verändern oder verstärken

### 8. Kernressourcen
Empfohlene MVP-Ressourcen:
- **Credits** für Bau und Upgrades

Für den ersten Prototyp empfohlen:
- Commander-Fähigkeiten zunächst **cooldown-basiert** statt über eine zusätzliche Spezialressource

Nicht nötig im MVP:
- komplexe Mehrwährungsökonomie
- tiefe Meta-Progression-Ressourcen

---

## Was im MVP unbedingt funktionieren muss

### Core Loop
- Gegner spawnen verlässlich
- Gegner folgen dem Pfad korrekt
- Türme greifen sinnvoll an
- Schaden und Eliminierung funktionieren stabil
- Spieler kann bauen, upgraden und auf Wellen reagieren

### Combat Readability
- Reichweiten und Rollen sind nachvollziehbar
- Treffer, Explosionen und Spezialeffekte sind verständlich
- Gegnerprioritäten sind visuell gut lesbar
- Boss und Eliteeinheiten heben sich klar ab

### Progression im Run
- Spieler wird von Welle zu Welle stärker
- Gegnerdruck steigt spürbar an
- Entscheidungen über Bau und Upgrades fühlen sich relevant an

### Atmosphäre
- Grundgefühl von Sci-Fi-Belagerung kommt rüber
- visuelle Identität ist grob erkennbar, auch mit Platzhaltergrafik
- Audio- und FX-Feedback unterstützen das Spielgefühl

---

## Was bewusst **nicht** im MVP enthalten sein muss
- mehrere spielbare Fraktionen
- Kampagnenkarte / Sektorkarte
- umfangreiche Meta-Progression
- Koop oder Multiplayer
- Dutzende Karten
- komplexe Bossphasen
- vollständige Lore-Ausarbeitung
- perfektes Balancing
- finaler Art-Style auf Hochglanzniveau
- große Mengen an kosmetischem Content

---

## Stretch Goals für den ersten Vertical Slice
Diese Punkte sind nur sinnvoll, wenn der Kern bereits stabil ist:
- fünfter klar ausgearbeiteter Tower mit spezieller Rolle
- Fluggegner
- Stealth-Gegner
- Support-/Buff-Gegner
- eine zweite Bossmechanik
- aktives Commander-Leveling während des Runs
- einfaches Relikt- oder Modifier-System

---

## Design-Prinzipien für den MVP
- **Readability first**: lieber weniger Chaos, dafür klare Entscheidungen
- **Original identity first**: keine direkten 1:1-Anleihen aus geschützten IPs
- **Mechanics over content quantity**: lieber wenige gute Tower als viele halbfertige
- **Playable over perfect**: der Build soll spielbar und testbar sein, nicht vollständig
- **Iteration-friendly**: Inhalte so aufbauen, dass Balancing leicht anpassbar bleibt

---

## Empfohlene Priorisierung

### Phase 1: Fundament
- Karte
- Pfadlogik
- Gegnerbewegung
- Bauen und Verkaufen
- 2 Basis-Tower
- einfache Wellen

### Phase 2: Kernspiel
- restliche MVP-Tower
- Upgrade-System
- Gegnerrollen erweitern
- Commander-Fähigkeiten
- Grundfeedback für Combat und UI

### Phase 3: Vertical Slice
- finale 10 bis 20 Wellenstruktur
- Boss
- Feintuning der Rollen
- Audio/FX-Minimum
- Spieltestbarkeit verbessern

---

## Festgelegte Entscheidungen für den aktuellen MVP
- **Engine:** Godot
- **Platzierungssystem:** freie Platzierung
- **Commander:** aktive Einheit auf dem Feld
- **Wellenstruktur:** detaillierter MVP-Plan in `docs/mvp-wave-plan.md`

Weiterhin offen, aber nicht mehr blocker für den Start:
- Bleibt es bei einem einzelnen Pfad oder gibt es Verzweigungen?
- Wie tief soll das Upgrade-System im ersten Prototyp wirklich gehen?

---

## Definition of Done für den MVP
Der MVP gilt als erreicht, wenn:
- 1 Karte von Anfang bis Ende spielbar ist
- 10 bis 20 Wellen inklusive Boss abgeschlossen werden können
- 4 bis 5 Tower-Rollen klar unterscheidbar funktionieren
- 1 Commander mit mindestens 2 Fähigkeiten existiert
- Bau-, Upgrade- und Gegner-Loop stabil spielbar ist
- das Spiel die beabsichtigte Festungs-/Belagerungsfantasie klar vermittelt
- weitere Iteration auf Basis von Playtests möglich ist
