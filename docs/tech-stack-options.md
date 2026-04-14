# Tech-Stack-Options: TDG40k

## Zweck des Dokuments
Dieses Dokument vergleicht plausible Tech-Stack-Optionen für den ersten spielbaren Prototyp von **TDG40k**. Ziel ist keine endgültige Technik-Dogmatik, sondern eine fundierte Entscheidung für den **MVP / Vertical Slice**.

---

## Projektanforderungen aus Designsicht
Der geplante Prototyp braucht vor allem:
- Top-down oder isometrische Darstellung
- einfache bis mittlere Pathfinding-/Wave-Logik
- viele wiederholte Gegner- und Projektil-Instanzen
- schnelle Iteration bei Towers, Gegnern und Upgrades
- UI für Bau-, Upgrade- und Wellensteuerung
- gute Möglichkeiten für datengetriebenes Balancing
- solide Tooling-Unterstützung für ein kleines Projekt / Solo- oder kleines Team-Setup

---

## Bewertungskriterien
### 1. Iterationsgeschwindigkeit
Wie schnell lassen sich neue Tower, Gegner, Wellen und UI-Flows bauen und testen?

### 2. Eignung für 2D / 2.5D TD
Wie gut passt die Engine zu Top-down- oder isometrischen Tower-Defense-Spielen?

### 3. Datengetriebene Content-Erstellung
Wie gut lassen sich Tower-, Enemy-, Wave- und Upgrade-Daten pflegen?

### 4. UI-Workflow
Wie effizient lassen sich Build-Menüs, Upgrade-Panels und Ingame-HUD umsetzen?

### 5. Performance für viele Einheiten
Wie gut kommt die Option mit vielen Gegnern, Projektilen und Effekten zurecht?

### 6. Lernkurve / Solo-Dev-Fit
Wie gut eignet sich der Stack für ein kleines Projekt mit Fokus auf schnellen Fortschritt?

### 7. Deployment / Zukunftssicherheit
Wie gut unterstützt der Stack spätere Plattformziele und Weiterentwicklung?

---

## Kandidaten
Für **TDG40k** sind aktuell diese Optionen am sinnvollsten:
1. Godot
2. Unity
3. Unreal Engine
4. Web-Stack (TypeScript + Framework / Engine)

---

## Option 1: Godot
### Kurzbeschreibung
Open-Source-Engine mit sehr gutem 2D-Fokus, schneller Iteration und leichtgewichtigem Workflow.

### Stärken
- sehr gut für 2D und 2.5D-Prototypen
- schnelle Startzeit und kurze Iterationszyklen
- einfache Szenenstruktur
- GDScript ist schnell produktiv nutzbar
- gute Eignung für datengetriebene Prototypen
- geringe Einstiegshürde für kleine Teams

### Schwächen
- kleinere Asset-Store-/Middleware-Landschaft als Unity
- je nach Zielumfang weniger Komfort bei High-End-3D-Workflows
- manche komplexe Tooling-Workflows erfordern Eigenarbeit

### Fit für TDG40k MVP
Sehr gut, wenn der Fokus auf einem **schnellen, spielbaren TD-Prototypen** liegt und nicht auf High-End-Rendering oder komplexer Multi-Plattform-Infrastruktur von Tag 1.

### Risiken
- spätere Skalierung auf sehr spezifische komplexe Pipelines kann mehr Eigenstruktur verlangen
- Team muss sich bewusst auf Godot-Workflow einlassen

---

## Option 2: Unity
### Kurzbeschreibung
Reife, weit verbreitete Engine mit starkem Ökosystem, sehr guter Tool-Unterstützung und solider Eignung für Tower-Defense-Projekte.

### Stärken
- sehr gute Eignung für 2D, 2.5D und stylisierte 3D-Ansätze
- C# ist verbreitet und leistungsfähig
- starkes Ökosystem, viele Tutorials und Assets
- gute UI-Werkzeuge
- solide Profiling- und Debugging-Möglichkeiten
- gute Basis für datengetriebene Systeme

### Schwächen
- mehr Overhead als Godot für kleine frühe Prototypen
- Projekt-Setup und Tooling können schwerer wirken
- manche Architekturentscheidungen können schnell komplex werden

### Fit für TDG40k MVP
Sehr gut, besonders wenn das Projekt später professioneller wachsen oder stärker auf C#-basierte Systemarchitektur setzen soll.

### Risiken
- Gefahr von Overengineering im frühen Stadium
- Auswahl aus vielen Patterns/Packages kann frühe Entscheidungen unnötig aufblähen

---

## Option 3: Unreal Engine
### Kurzbeschreibung
Leistungsstarke Engine mit starkem Rendering, aber höherer Komplexität und meist schwächerem Fit für einen kleinen frühen TD-Prototypen.

### Stärken
- exzellente Rendering-Qualität
- sehr starke 3D-Tools
- leistungsfähige visuelle Scripting-Möglichkeiten
- langfristig gut für aufwendigere Präsentation

### Schwächen
- deutlich höheres Gewicht und größere Komplexität
- für ein 2D/2.5D-TD-MVP oft mehr Engine als nötig
- langsamere Iteration für kleine Gameplay-Schleifen im Vergleich zu leichteren Setups

### Fit für TDG40k MVP
Nur dann attraktiv, wenn von Beginn an ein starker Fokus auf aufwendige 3D-Präsentation oder spätere große Produktionswerte besteht.

### Risiken
- hoher Initialaufwand
- größerer Abstand zwischen Design-Idee und schnell spielbarem Prototyp

---

## Option 4: Web-Stack (TypeScript + Framework / Engine)
### Kurzbeschreibung
Ein browser- oder desktopnaher Stack, z. B. mit TypeScript und einer Rendering-/Game-Library oder Web-Engine.

### Stärken
- gut für schnelle UI-nahe Iteration
- TypeScript ist produktiv und zugänglich
- einfache Distribution im Browser möglich
- hoher Grad an eigener Architekturkontrolle

### Schwächen
- mehr Eigenbau bei Gameplay-Framework, Tools und Editor-Workflows
- Pathing, Content-Pipelines und VFX müssen oft stärker selbst organisiert werden
- weniger direktes Out-of-the-box-Game-Tooling als klassische Engines

### Fit für TDG40k MVP
Interessant, wenn bewusst ein webnaher Workflow gewünscht ist. Für einen klassischen TD-Prototyp meist nur dann sinnvoll, wenn bereits starke Präferenz oder Erfahrung vorhanden ist.

### Risiken
- schneller technischer Eigenbau statt Fokus auf Gameplay
- Tooling-Lücken gegenüber etablierten Engines

---

## Vergleichstabelle

| Kriterium | Godot | Unity | Unreal | Web-Stack |
|---|---|---|---|---|
| Iterationsgeschwindigkeit | sehr gut | gut | mittel | gut |
| 2D / 2.5D TD-Eignung | sehr gut | sehr gut | mittel | mittel |
| Datengetriebene Inhalte | gut | sehr gut | gut | mittel bis gut |
| UI-Workflow | gut | sehr gut | gut | gut |
| Performance für viele Einheiten | gut | gut bis sehr gut | sehr gut | abhängig von Architektur |
| Solo-Dev-Fit | sehr gut | gut | niedrig bis mittel | mittel |
| Zukunft / Skalierung | gut | sehr gut | sehr gut | variabel |

---

## Empfehlung für den MVP
### Primäre Empfehlung: Godot
**Godot** ist aktuell die beste Default-Empfehlung für **TDG40k**, wenn das Ziel ist:
- schnell einen Vertical Slice zu bauen
- 2D oder 2.5D sauber umzusetzen
- Tower, Gegner und Wellen schnell iterieren zu können
- früh mit wenig Overhead spielbare Builds zu erzeugen

### Sekundäre Empfehlung: Unity
**Unity** ist die stärkste Alternative, wenn:
- C# klar bevorzugt wird
- ein größerer späterer Produktionsrahmen denkbar ist
- man stärker von Ökosystem, Assets und etablierten Workflows profitieren möchte

---

## Nicht-Ziele für diese Entscheidung
Diese Dokumentation entscheidet noch **nicht**:
- finale Architektur
- Datenformat im Detail
- ECS vs. klassische Objektstruktur
- Multiplayer-Fähigkeit
- Modding-Support
- Asset-Pipeline im finalen Detail

Diese Punkte sollten erst **nach der Engine-Wahl** konkretisiert werden.

---

## Entscheidungsfragen
Vor einer finalen Wahl sollten folgende Fragen beantwortet werden:
- Soll der Prototyp eher **2D**, **2.5D** oder **stylisiertes 3D** sein?
- Welche Programmiersprache liegt näher: **GDScript**, **C#**, **C++/Blueprints**, **TypeScript**?
- Ist schnelle Spielbarkeit wichtiger als langfristige Produktionspipeline?
- Welche Zielplattform ist zuerst relevant: PC only oder Web optional?
- Gibt es bereits Vorerfahrung mit einer Engine?

---

## Empfohlene nächste Schritte nach der Stack-Wahl
1. Projektstruktur im Repo festlegen
2. Minimalen technischen Prototyp anlegen
3. Datenmodelle für Tower, Gegner und Wellen definieren
4. erste spielbare Map mit Spawn-, Pfad- und Build-Loop bauen
5. nur 2 Tower und 2 Gegnertypen als technischer Start testen

---

## Kurzfazit
Wenn keine starke Präferenz besteht, ist die sinnvollste Reihenfolge aktuell:
1. **Godot zuerst prüfen**
2. **Unity als starke Alternative vergleichen**
3. Unreal und Web-Stack nur bei klarer strategischer Begründung wählen

Für den frühen Scope von **TDG40k** ist **schnelle Iteration** wichtiger als maximale technische Komplexität.
