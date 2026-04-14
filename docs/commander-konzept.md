# Commander-Konzept: TDG40k

> `TDG40k` ist aktuell ein Arbeitstitel.

## Zweck des Dokuments

Dieses Dokument definiert den **Commander** für den MVP von **TDG40k**.
Der Commander ist eine **aktive Einheit auf dem Schlachtfeld** und ergänzt das
Tower-Defense-Gameplay um eine kontrollierte taktische Ebene.

Wichtig:

- Der Commander ist **Teil des Feldes**, nicht nur ein globales Skill-Menü.
- Der Commander ist **nicht** das Zentrum des Spiels.
- **Tower und Platzierung bleiben die Hauptsäulen** des Gameplays.

Siehe auch:

- `docs/game-design-overview.md`
- `docs/mvp-scope.md`
- `docs/tower-klassen-konzept.md`
- `docs/mvp-wave-plan.md`

---

## MVP-Entscheidung

Für den aktuellen MVP gilt:

- **Commander auf dem Feld**
- **Godot** als Engine
- **freie Platzierung** für Tower / Defense Units

Diese Entscheidung hat direkte Auswirkungen auf:

- Kartenlayout
- Pathing- und Build-Regeln
- UI und Steuerung
- Wave-Design und Druckspitzen

---

## Rolle des Commanders im Spiel

Der Commander ist ein **taktischer Support-Fighter**, der an Hotspots eingreifen,
Tower lokal verstärken und Druckspitzen abfangen kann.

Seine Aufgabe ist **nicht**:

- Wellen alleine zu löschen
- Tower-Entscheidungen zu ersetzen
- wie ein Action- oder RTS-Held das gesamte Spiel zu dominieren

Seine Aufgabe ist:

- Lücken im Build kurzfristig stabilisieren
- wichtige Ziele markieren oder fokussieren
- bei Elite- und Bossdruck aktiv helfen
- dem Spieler zusätzliche, aber kontrollierte Entscheidungsräume geben

---

## Designziele

- **Hohe Lesbarkeit**: Der Commander muss im Kampf klar von Towern und Gegnern
  unterscheidbar sein.
- **Niedrige bis mittlere APM-Anforderung**: keine Mikro-Überladung.
- **Spürbarer Einfluss** ohne Solo-Carry-Potenzial.
- **Thematische Stärkung** der Belagerungs- und Kommandantenfantasie.
- **Gute Integration** in freie Platzierung und TD-Kernloop.

---

## Nicht-Ziele für den MVP

- kein komplexes Heldensystem mit großem Skilltree
- kein Inventar- oder Loot-System
- keine Squad-Steuerung
- kein zweiter Commander
- kein tiefes In-Run-Leveling mit vielen Talententscheidungen
- keine Story-/Dialogmechanik als Kernelement

---

## Core Gameplay auf dem Feld

### Bewegung

- Der Commander bewegt sich aktiv über **begehbare Spielerzonen**.
- Er ist repositionierbar, um auf Bedrohungsschwerpunkte zu reagieren.
- Die Bewegung soll taktisch relevant sein, aber nicht hektisch.

### Positionierung

Gute Commander-Positionierung soll belohnt werden bei:

- Engstellen
- gefährdeten Flanken
- Elite-Schwerpunkten
- Bosswellen
- Tower-Clustern mit Supportbedarf

### Präsenz auf dem Feld

Der Commander soll sich anfühlen wie:

- mobile Einsatzreserve
- Führungsfigur an Brennpunkten
- Unterstützungsanker für kritische Verteidigungszonen

---

## Interaktion mit freier Platzierung

Die freie Platzierung bleibt das wichtigste räumliche System im Spiel.

Daraus folgen für den Commander diese Regeln:

- Der Commander **nutzt keine Build-Slots**.
- Der Commander darf **Tower-Platzierung nicht unlesbar machen**.
- Der Commander darf **keine Buildflächen dauerhaft blockieren**.
- Der Commander darf **gegnerisches Pathing nicht brechen**.
- Der Commander soll Entscheidungen über Tower-Platzierung **ergänzen**,
  nicht unterlaufen.

### Designregel

Wenn ein Spieler durch Commander-Mikro dauerhaft schlechte Platzierung
kompensieren kann, ist der Commander zu stark.

---

## Kollision, Überleben und Failure Rules

Für den MVP wird folgende Richtung empfohlen:

- Commander ist **verwundbar**
- Commander hat **eigene Lebenspunkte**
- Commander kann **nicht dauerhaft sterben**
- bei Niederlage / Downstate wird er für kurze Zeit deaktiviert oder muss sich
  regenerieren

### Empfohlene MVP-Lösung

- Der Commander kann Schaden nehmen.
- Bei 0 HP geht er in einen **kurzen Downstate / Rückzugszustand**.
- Danach kehrt er nach einer kurzen Verzögerung wieder zurück.

Vorteile:

- der Commander fühlt sich real an
- falsche Positionierung hat Konsequenzen
- ein Fehler beendet nicht sofort den ganzen Run

---

## Rollenprofil

### Primäre Rolle

- taktischer Support
- Fokusverstärker
- Krisenreaktion an Durchbruchspunkten

### Sekundäre Rolle

- begrenzter Zusatzschaden gegen wichtige Ziele
- lokale Kontrolle oder Stabilisierung

### Keine Rolle im MVP

- Haupttank
- Haupt-DPS
- Sololöser für Bosswellen

---

## MVP-Gameplay-Kit

Der Commander erhält im MVP:

- **1 Basisangriff**
- **2 aktive Fähigkeiten**
- optional **1 passive Grundfunktion**

### Basisangriff

Der Basisangriff sollte:

- verständlich sein
- auf mittlere Distanz funktionieren
- gegen leichte und mittlere Ziele nützlich sein
- gegen Elite-/Bossdruck nur unterstützend wirken

Empfohlene Identität:

- präziser Karabiner / Energiewaffe / Kommando-Seitenwaffe
- kein überladener Flächenlöscher

---

## MVP-Fähigkeiten

### Fähigkeit 1: Target Uplink

#### Funktion

Der Commander markiert ein Ziel oder eine kleine Zielzone. Markierte Gegner
nehmen für kurze Zeit erhöhten Schaden durch Tower.

#### Zweck

- Fokusfeuer gegen Elites und Boss
- Wertsteigerung für Heavy Battery und Siege Mortar Platform
- klare Teamplay-Synergie zwischen Commander und Towern

#### Einsatzfenster

- Shellback Brute
- Spore Herald
- Maw Colossus
- einzelne gefährliche Durchbruchseinheiten

#### Designvorteil

Die Fähigkeit stärkt den TD-Kern, statt ihn zu ersetzen.

### Fähigkeit 2: Overwatch Beacon

#### Funktion

Der Commander setzt einen temporären Beacon / Befehlsmarker in seiner Nähe.
Tower im Wirkbereich erhalten kurzzeitig einen Bonus auf Angriffstempo,
Zielerfassung oder Reichweite.

#### Zweck

- lokale Stabilisierung einer Druckzone
- belohnt gute Vorpositionierung des Commanders
- passt gut zu Engstellen und Build-Clustern

#### Einsatzfenster

- gemischte Mid-Game-Wellen
- Druckspitzen vor dem Boss
- Reaktion auf schwache Flanken

#### Designvorteil

Die Fähigkeit schafft ein klares, lesbares Zusammenspiel aus Feldpräsenz und
Tower-Verstärkung.

---

## Optionale passive Grundfunktion

### Battlefield Presence

Tower in unmittelbarer Nähe des Commanders erhalten einen **kleinen,
permanenten Mini-Bonus** auf Genauigkeit oder Zielreaktion.

Wichtig:

- nur klein ausprägen
- eher Identity als Power Spike
- darf aktive Fähigkeiten nicht entwerten

---

## Ressourcenmodell

Für den MVP wird empfohlen:

- **Cooldown-basiertes Fähigkeitssystem**
- keine zusätzliche Commander-Spezialwährung im ersten Schritt

### Warum

- reduziert UI-Komplexität
- schneller prototypisierbar
- besser lesbar
- leichter zu balancen

Eine Zweitressource kann später ergänzt werden, wenn der Kern funktioniert.

---

## UI- und Readability-Anforderungen

Der Commander braucht im MVP:

- klaren Auswahlzustand
- Lebensbalken
- Positionsmarker / Silhouette, die sich von Towern unterscheidet
- sichtbare Reichweiten- oder Skillindikatoren
- klare Cooldown-Anzeige für 2 Fähigkeiten

### Wichtige Lesbarkeitsregel

Der Commander darf in intensiven Kämpfen **nie** mit Towern oder Elite-Gegnern
visuell verschmelzen.

---

## Balance-Leitplanken

- Tower bleiben die Hauptquelle für langfristigen Schaden.
- Der Commander soll **gute Entscheidungen verstärken**, nicht schlechte Builds
  vollständig retten.
- Elite- und Bosswellen sollen Commander-Nutzung belohnen, aber nicht zu einem
  Pflicht-Mikrotest werden.
- Commander-Schaden darf nützlich sein, aber nicht effizienter als gut
  platzierte Tower.

---

## Interaktion mit Towern

Besonders gute Synergien im MVP:

- **Heavy Battery** + Target Uplink
- **Siege Mortar Platform** + Zielmarkierung / gebündelte Gegner
- **Line Trooper Post** + Overwatch Beacon
- **Signal Relay Node** + Commander-Buff-Zonen für starke Support-Cluster

---

## Interaktion mit Gegnern

### Besonders relevant gegen

- **Shellback Brute**: Fokusziel für Uplink
- **Razor Leaper**: Commander kann kurze Reaktionslücke schließen
- **Spore Herald**: gutes Prioritätsziel
- **Maw Colossus**: Commander wird für Bossfenster sehr wertvoll

### Weniger relevant gegen

- reine Massenwellen kleiner Scuttleborn ohne Druckspitze

---

## Technische Implikationen für Godot

Der Commander braucht in der ersten Godot-Struktur mindestens:

- eigene Szene
- eigenes Script für Bewegung und State
- Fähigkeitensystem mit einfachen Cooldowns
- UI-Panel für Status und Fähigkeiten
- saubere Trennung von Tower- und Commander-Logik

---

## Out of Scope / Später

- mehrere Commander-Klassen
- Commander-Leveling im Run
- Ausrüstungs-Slots
- alternative Waffenmodi
- Summons / Begleittruppen
- komplexe Dialog-/Narrativsysteme

---

## Offene Detailfragen

Diese Fragen sind jetzt **nicht mehr blocker**, aber später zu klären:

- Auto-Attack oder direkte Zielanwahl?
- Exakte Bewegungssteuerung in Godot?
- Kollision mit Gegnern ja oder nur durch Schaden relevant?
- Downstate visuell / mechanisch wie stark ausprägen?
- Wie groß soll der Radius von Overwatch Beacon im MVP sein?

---

## Kurzfazit

Der Commander im MVP von **TDG40k** ist eine **aktive Feld-Einheit**, die:

- mobile taktische Unterstützung liefert
- wichtige Ziele markiert
- lokale Verteidigungscluster stärkt
- Tower-Defense-Gameplay vertieft, ohne es zu verdrängen

So bleibt der Commander spannend, thematisch stark und zugleich
scope-kontrollierbar.
