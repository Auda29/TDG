# MVP Wave Plan: TDG40k

> `TDG40k` ist aktuell ein Arbeitstitel.

## Zweck des Dokuments
Dieses Dokument beschreibt die geplante Wellenstruktur für den ersten spielbaren Vertical Slice von **TDG40k**. Es übersetzt den MVP-Scope, die erste Gegnerfraktion und die Tower-Rollen in eine testbare Eskalationskurve.

Siehe auch:
- `docs/mvp-scope.md`
- `docs/enemy-faction-konzept.md`
- `docs/tower-klassen-konzept.md`
- `docs/commander-konzept.md`

---

## Festgelegte Grundlagen
Für den aktuellen MVP gelten:
- **Godot** als Engine
- **freie Platzierung** für Tower
- **Commander auf dem Feld**
- **The Carrion Tide** als erste Gegnerfraktion
- 4 bis 5 Tower-Klassen
- 1 Boss am Ende des Vertical Slice

---

## MVP-Rahmen für die Wellenstruktur
Empfohlene Form für den ersten Vertical Slice:
- **12 Wellen** insgesamt

Warum 12?
- genug Platz für Eskalation
- genug Raum, um alle Kerngegner einzuführen
- gut testbar und iterierbar
- leichter zu balancen als 20 Wellen im ersten Prototyp

Falls Scope reduziert werden muss:
- kürzbar auf **10 Wellen**
- Welle 12 bleibt dann trotzdem Boss-/Finalwelle

---

## Wave-Design-Prinzipien
- Jede Welle soll **eine neue Lektion** oder eine neue Kombination prüfen.
- Gegnerdruck soll nicht nur numerisch steigen, sondern **qualitativ neue Fragen** stellen.
- Freie Platzierung soll über Engstellen, Reichweiten und Coverage-Lücken relevant werden.
- Der Commander soll gezielte Einsatzfenster erhalten, aber kein permanentes Mikro erzwingen.
- Lesbarkeit hat Vorrang vor maximaler Komplexität.

---

## Verwendete Gegner im MVP
- **Scuttleborn** — Basis-Schwarmdruck
- **Shellback Brute** — Anti-Armor-Check
- **Razor Leaper** — Reaktionsdruck / Lückenfinder
- **Spore Herald** — Priorisierungsziel / Supportdruck
- **Maw Colossus** — Finalboss

Bewusst nicht im MVP-Wellenplan:
- Flieger
- Stealth-Gegner
- Split-on-death-Ketten
- zweite Bossphase
- zu viele Spezialregeln gleichzeitig

---

## Erwartete Tower-Antworten im MVP
Der Wellenplan setzt voraus, dass der Spieler grob diese Rollen aufbauen kann:
- **Generalist** — frühe Stabilität
- **Anti-Swarm** — Druck an Engstellen
- **Anti-Armor** — Shellback Brute und Bossfenster
- **Artillerie / Splash** — Gruppen und hintere Reihen
- **Support** — optional, aber stark für späte Wellen

---

## Commander-Rolle im Wellenplan
Da der Commander auf dem Feld steht, muss der Wellenplan gezielt Momente schaffen für:
- Repositionierung
- Fokusfeuer auf Elites
- lokale Stabilisierung mit Fähigkeiten
- Boss-Unterstützung

Der Commander ist dabei:
- **Verstärker**, nicht Hauptlösung
- **Krisenwerkzeug**, nicht Dauerersatz für schlechte Platzierung

---

## Wellenphasen

## Phase 1: Onboarding (Welle 1–3)
Ziele:
- freie Platzierung verstehen
- Basistower-Rollen lesen
- Commander-Bewegung und Grundnutzung etablieren

### Welle 1
**Hauptgegner:** Scuttleborn

**Spieler-Lektion:**
- erste Buildpositionen setzen
- Grundpfad lesen
- Generalist-Tower einsetzen

**Commander-Moment:**
- einfache Repositionierung ohne Druck
- Basisangriff ausprobieren

**Designfunktion:**
- Einstieg ohne Systemüberladung

### Welle 2
**Hauptgegner:** mehr Scuttleborn, dichterer Schwarm

**Spieler-Lektion:**
- Engstellen erkennen
- frühe Anti-Swarm-Wirkung spüren

**Commander-Moment:**
- Nahunterstützung an einer kritischen Kurve

**Designfunktion:**
- erste Platzierungsfehler werden sichtbar, aber noch verzeihbar

### Welle 3
**Hauptgegner:** Scuttleborn in längeren Gruppen

**Spieler-Lektion:**
- Coverage-Lücken lesen
- erste Upgrade-Entscheidungen treffen

**Commander-Moment:**
- erstes sinnvolles Timing für eine aktive Fähigkeit

**Designfunktion:**
- Abschluss der Lernphase für Grundsysteme

---

## Phase 2: Rollenprüfung (Welle 4–6)
Ziele:
- Anti-Armor-Bedarf einführen
- Reaktionsdruck erhöhen
- Commander als taktischen Stabilisator etablieren

### Welle 4
**Hauptgegner:** Scuttleborn + erster Shellback Brute

**Spieler-Lektion:**
- reiner Schwarm-Clear reicht nicht mehr
- Anti-Armor wird relevant

**Commander-Moment:**
- Target Uplink auf erstes schweres Ziel

**Designfunktion:**
- erster klarer Build-Check

### Welle 5
**Hauptgegner:** Scuttleborn + Shellback Brute in kleiner Mischung

**Spieler-Lektion:**
- kombinierte Rollen sind wichtiger als Einzelantworten
- Positionierung schwerer Waffen wird geprüft

**Commander-Moment:**
- Overwatch Beacon kann eine schwache Zone stabilisieren

**Designfunktion:**
- Druck auf Allround-Builds ohne Spezialisierung

### Welle 6
**Hauptgegner:** erste Razor Leaper + Scuttleborn

**Spieler-Lektion:**
- Reaktionsgeschwindigkeit und kurze Reichweiten werden wichtig
- langsame reine Heavy-Builds bekommen Schwächen

**Commander-Moment:**
- Commander fängt Durchbruchsdruck aktiv mit ab

**Designfunktion:**
- erste echte Mikromomente ohne Chaos zu erzeugen

---

## Phase 3: Kombinationsdruck (Welle 7–9)
Ziele:
- Mischwellen als Kern des Spiels etablieren
- Priorisierung aufbauen
- Commander-Fähigkeiten gezielter abfragen

### Welle 7
**Hauptgegner:** Scuttleborn + Razor Leaper + Shellback Brute

**Spieler-Lektion:**
- gleichzeitige Antworten auf mehrere Bedrohungsarten nötig
- freie Platzierung muss Coverage statt Einzelturm-Denken belohnen

**Commander-Moment:**
- commander muss zwischen zwei Druckzonen sinnvoll gewählt werden

**Designfunktion:**
- Kerngefühl des Spiels beginnt sichtbar zu werden

### Welle 8
**Hauptgegner:** erste Spore Heralds + Begleitschwarm

**Spieler-Lektion:**
- Support-Ziele priorisieren
- Fokusfeuer wird wichtiger

**Commander-Moment:**
- Target Uplink auf Spore Herald oder Shellback Brute

**Designfunktion:**
- erhöht taktische Priorisierung statt nur Schadensdruck

### Welle 9
**Hauptgegner:** dichter Mix aus allen bisherigen Nicht-Boss-Gegnern

**Spieler-Lektion:**
- Tower-Synergien müssen tragen
- Build-Lücken werden klar sichtbar

**Commander-Moment:**
- aktive Stabilisierung einer Front ist jetzt deutlich wertvoll

**Designfunktion:**
- Midgame-Finale / Generalprobe für spätere Druckspitzen

---

## Phase 4: Endgame-Aufbau (Welle 10–11)
Ziele:
- spätes Verteidigungsgefühl aufbauen
- Boss vorbereiten
- Spieler zu finalen Entscheidungen zwingen

### Welle 10
**Hauptgegner:** verstärkte Brute-/Leaper-Mischung

**Spieler-Lektion:**
- Anti-Armor und Reaktionsfähigkeit müssen gleichzeitig stehen
- Platzierung von Mortar und Heavy Battery wird kritisch

**Commander-Moment:**
- Beacon zur Stabilisierung von Boss-Vorbereitungspunkten

**Designfunktion:**
- bereitet auf Enddruck vor, ohne schon Bossniveau zu erreichen

### Welle 11
**Hauptgegner:** Spore Herald + Shellback Brute + dichter Begleitschwarm

**Spieler-Lektion:**
- Support-Ziele unter hohem Druck priorisieren
- letzte Build-Schwäche vor dem Finale sichtbar machen

**Commander-Moment:**
- beide Fähigkeiten können in kurzer Folge entscheidend sein

**Designfunktion:**
- letzte Belastungsprobe vor Welle 12

---

## Phase 5: Finale (Welle 12)

### Welle 12
**Hauptgegner:** Maw Colossus + kontrollierter Begleitdruck

**Spieler-Lektion / Finalprüfung:**
- Fokusfeuer gegen Boss
- Anti-Swarm-Kontrolle gegen Adds
- Build-Stabilität über längeren Druck
- sinnvolle Commander-Positionierung und Fähigkeitennutzung

**Commander-Moment:**
- Target Uplink für Bossfenster
- Overwatch Beacon für zentrale Tower-Cluster
- Repositionierung zwischen Boss und Adds

**Designfunktion:**
- finaler Test des gesamten MVP-Kerns

---

## Bosswellen-Konzept
Der **Maw Colossus** soll im MVP:
- klar lesbar sein
- langsam, aber bedrohlich vorrücken
- optional in kleinen, lesbaren Schüben Begleitgegner erhalten
- keine komplexen Mehrphasenmechaniken brauchen

Wichtig:
- der Boss darf Builds testen
- aber er darf nicht wie ein unfairer Hard-Counter gegen alle Tower-Rollen wirken

---

## Pacing und Planungsfenster
Empfehlung für den MVP:
- kurze Pausen zwischen normalen Wellen
- etwas längeres Planungsfenster vor Welle 6
- klares längeres Vorbereitungsfenster vor Welle 12

Diese Pausen sollen genutzt werden für:
- Upgrades
- neue Platzierung
- Commander-Repositionierung
- UI-Lesen und nächste Entscheidung

---

## Failure Cases / Balancing-Warnungen
- Razor Leaper zu früh oder zu häufig erzeugt Frust.
- Zu viele Spore Heralds gleichzeitig verschlechtern Lesbarkeit.
- Shellback Brute zu früh kann Schwarm-Lernkurve zerstören.
- Boss + Adds dürfen Commander nicht zur einzigen Rettungsoption machen.
- Wenn freie Platzierung zu leicht alle Probleme löst, fehlt Kartendruck.

---

## Scope-Grenzen
Bewusst nicht Teil dieses ersten Wellenplans:
- alternative Routenmodi
- Flugwellen
- Tarnwellen
- mehrere Bosse
- zweite Bossphase
- ausgefeilte numerische Spawn-Tabellen

Der Fokus liegt auf **spielerischer Eskalationslogik**, nicht auf finalem Balancing.

---

## Empfohlene nächste Ableitung
Nach diesem Dokument sollte als nächstes entstehen:
- konkrete Spawnzahlen pro Welle in `game/data/waves/`
- erste Map-Notizen passend zum Wellenplan
- erster Playtest-Loop mit 3 bis 5 Wellen als technische Slice-Version

---

## Kurzfazit
Der MVP-Wellenplan von **TDG40k** ist darauf ausgelegt,
- freie Platzierung früh verständlich zu machen,
- Tower-Rollen schrittweise zu prüfen,
- den Commander sinnvoll ins Feldgeschehen einzubinden,
- und in 12 Wellen einen klaren, testbaren Vertical Slice zu liefern.
