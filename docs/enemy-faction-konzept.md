# Enemy-Faction-Konzept: The Carrion Tide

## Zweck des Dokuments
Dieses Dokument definiert die erste Gegnerfraktion für den MVP von **TDG40k**. Die Fraktion soll mechanisch klar lesbar, thematisch stark und für den ersten spielbaren Scope gut geeignet sein.

---

## Fraktionsidentität
### Arbeitstitel
**The Carrion Tide**

### Kurzbeschreibung
The Carrion Tide ist ein biologisch-mutierender Invasionsschwarm, der Planeten und Festungsanlagen mit Masse, Anpassungsdruck und lebender Belagerungsgewalt überrollt. Die Fraktion setzt weniger auf Präzision und Technologie als auf Zahlen, Druck, Mutation und einige wenige schwere Brute-Einheiten.

### Gameplay-Identität
- hoher Druck durch viele Einheiten
- klare Eskalation von Schwarm zu Elite zu Boss
- starke Prüfung von AoE-, Kontroll- und Anti-Armor-Optionen
- leicht verständliche erste Gegnerfraktion für einen TD-Prototyp

---

## Warum diese Fraktion gut für den MVP ist
- Der Schwarmansatz ist **leicht lesbar**.
- Sie testet direkt die wichtigsten Tower-Rollen:
  - Generalist
  - Anti-Swarm
  - Anti-Armor
  - Support / Markierung
- Die Fraktion funktioniert mit **wenigen klaren Gegnertypen**.
- Sie passt gut zur Belagerungsfantasie von **TDG40k**.
- Sie kann früh bedrohlich wirken, ohne komplexe Spezialsysteme zu benötigen.

---

## IP-Sicherheitsleitplanken
- Keine direkte Übernahme bekannter Fraktionen, Kreaturentypen oder Lore-Strukturen aus Warhammer 40k.
- Fokus auf eigene Terminologie und eigene visuelle Signale.
- Designziel ist ein **originaler organisch-belagernder Schwarm**, nicht ein umbenannter 1:1-Klon bestehender IP.

Siehe auch:
- `docs/ip-do-dont.md`
- `docs/inspirations-research.md`

---

## Visuelle Leitlinien
- organische Massen mit harten chitinösen oder knöchernen Elementen
- asymmetrische Körperformen
- aggressive Vorwärtsbewegung
- starke Kontraste zwischen kleinen Schwarmkörpern und massiven Brute-Einheiten
- gut lesbare Farbtrennung zwischen Standard-, Elite- und Boss-Gegnern

---

## Fraktionsmechanik für den MVP
Für den MVP sollte die Fraktion nur **1 bis 2 klare Signaturmechaniken** haben.

Empfohlene Signaturmechaniken:
1. **Swarm Pressure**
   - viele günstige leichte Ziele
   - erzwingt Flächenschaden und gute Platzierung
2. **Mutation Tier Escalation**
   - spätere Wellen bringen deutlich robustere Varianten
   - erzeugt den Wechsel von Anti-Swarm zu Anti-Armor-Prioritäten

Option für später:
- Regeneration in verseuchten Zonen
- Spawn-Untereinheiten beim Tod größerer Kreaturen
- Suppression-Resistenz bestimmter Eliteformen

---

## Einheitenübersicht

| Einheit | Rolle | Bedrohung | Konter | Wellenphase |
|---|---|---|---|---|
| Scuttleborn | Schwarm-Basisgegner | hoher Mengendruck | Line Trooper Post, Purge Flame Array | früh |
| Shellback Brute | Tank / Armor-Träger | bindet Feuerkraft, schützt Schwarm | Heavy Battery, markierte Mortar-Treffer | mittel |
| Razor Leaper | schneller Störgegner | durchbricht Lücken, bestraft schlechte Reaktion | Line Trooper Post, Flame Array | mittel |
| Spore Herald | Support-Gegner | bufft oder verstärkt angrenzende Feinde | fokussiertes Fire, Heavy Battery, markierte Priorisierung | mittel bis spät |
| Maw Colossus | Boss | Abschlussprüfung des gesamten Builds | kombinierter DPS, Support, Anti-Armor, gute Platzierung | spät |

---

## Einzelkonzepte

## 1. Scuttleborn
### Rolle
Leichter Standard-Schwarmgegner.

### Verhalten
- schnell bis mittel-schnell
- geringe Haltbarkeit
- tritt in Gruppen auf

### Zweck im Spieldesign
- erzeugt frühen Druck
- zwingt den Spieler, AoE und effiziente Basisverteidigung aufzubauen
- macht Platzierungsfehler sofort sichtbar

### Lesbarkeit
- kleine, aggressive Silhouette
- hektische Bewegung
- klar schwächer als alle Spezialformen

### MVP-Notizen
- wichtigste Standard-Einheit der frühen Wellen
- darf in späteren Wellen als Massenkomponente zurückkehren

---

## 2. Shellback Brute
### Rolle
Gepanzerter Frontbrecher.

### Verhalten
- langsam
- hohe Lebenspunkte oder Armor
- absorbiert viel Schaden, während kleinere Einheiten nachrücken

### Zweck im Spieldesign
- prüft, ob der Spieler Anti-Armor gebaut hat
- erhöht den Wert spezialisierter Heavy-Tower
- macht Build-Einseitigkeit sichtbar

### Lesbarkeit
- massive Frontsilhouette
- deutlich langsamer als Schwarmgegner
- klarer Panzerungs-Look

### MVP-Notizen
- sollte nicht zu früh erscheinen
- ideal ab dem mittleren Spielabschnitt

---

## 3. Razor Leaper
### Rolle
Schneller Spezialgegner für Reaktionsdruck.

### Verhalten
- sehr schnell
- geringere Haltbarkeit als Tank-Gegner
- kann kurze Sprints oder Sprungbewegungen ausführen

### Zweck im Spieldesign
- bestraft Builds, die nur auf langsame schwere Waffen setzen
- erhöht den Wert kurzer Reaktionsfenster und Nahbereichsverteidigung
- macht Wellen dynamischer

### Lesbarkeit
- schmale, aggressive Silhouette
- deutlich höheres Bewegungstempo
- auffällige Sprung- oder Dash-Animation

### MVP-Notizen
- nur sparsam einsetzen
- soll Druck erzeugen, nicht chaotisch werden

---

## 4. Spore Herald
### Rolle
Support-Gegner.

### Verhalten
- bleibt hinter Frontlinien oder zwischen Gruppen
- verstärkt benachbarte Einheiten
- könnte Tempo-, Resistenz- oder Regenerationsbuffs geben

### Zweck im Spieldesign
- zwingt Priorisierungsentscheidungen
- gibt Support-Towern, Markierungen und Heavy-Focus mehr Wert
- macht gegnerische Formationen interessanter

### Lesbarkeit
- auffällige Rücken-/Spore-Struktur
- sichtbarer Buff-Effekt auf nahe Einheiten
- klar als wichtiges Sekundärziel erkennbar

### MVP-Notizen
- einfache Buff-Mechanik reicht
- keine Ketten komplexer Auren nötig

---

## 5. Maw Colossus
### Rolle
Bossgegner des MVP.

### Kurzkonzept
Ein massiver Belagerungsorganismus, der langsamer als der Schwarm vorrückt, aber durch schiere Haltbarkeit und Druck den finalen Test des Defense-Builds darstellt.

### Designziele
- klare Boss-Silhouette
- deutlich höherer Ressourcen- und Feuerkraftbedarf
- fordert gutes Zusammenspiel mehrerer Tower-Rollen

### Mechanische Anforderungen
- sehr hohe HP oder starke Armor
- eventuell periodischer Spawn kleiner Scuttleborn-Gruppen
- eventuell kurze Rage-Phase bei niedrigem Leben

### Konterlogik
- Heavy Battery für konstanten Bossdruck
- Mortar für Begleitgruppen
- Support-Markierung für Fokusfeuer
- Flame/Generalist zum Aufräumen der Adds

### MVP-Notizen
- Boss soll mechanisch klar, aber nicht überladen sein
- 1 Signaturmechanik genügt

---

## Wellenintegration
### Frühe Wellen
- primär Scuttleborn
- wenige einfache Mischungen
- Spieler lernt Basisplatzierung und Anti-Swarm-Wert

### Mittlere Wellen
- Shellback Brute erscheint
- Razor Leaper erzeugt Lückenstress
- erste Mischwellen erfordern bessere Priorisierung

### Späte Wellen
- Spore Herald verstärkt Verbände
- mehrere Rollen treten gleichzeitig auf
- Tower-Synergien und Commander-Einsatz werden wichtig

### Finale Welle
- Maw Colossus plus Begleitdruck
- finaler Test auf Build-Balance und Platzierung

---

## MVP-Inhalt
Im MVP enthalten:
- Scuttleborn
- Shellback Brute
- Razor Leaper
- Spore Herald
- Maw Colossus

Bewusst später:
- Flieger
- Tarn-/Stealth-Formen
- echte Splitter- oder Spawn-on-Death-Ketten
- komplexe Elite-Unterarten
- mehrere Bossphasen

---

## Counterplay-Ziele
Die Fraktion soll den Spieler dazu bringen:
- nicht nur einen Tower-Typ zu spammen
- Engstellen gezielt zu verteidigen
- Anti-Swarm und Anti-Armor zu kombinieren
- Support-Ziele aktiv zu priorisieren
- Commander-Fähigkeiten für Druckspitzen aufzusparen

---

## Spätere Erweiterungen
- fliegende Biovarianten
- verseuchte Zonen mit Regeneration
- schwere Belagerungsbestien mit Fernangriffen
- Splitterkreaturen, die beim Tod Kleinstschwärme freisetzen
- Elitevarianten mit Suppression-Resistenz

---

## Offene Fragen
- Soll Regeneration bereits im MVP vorkommen oder erst später?
- Ist Razor Leaper für den ersten Prototyp schon nötig oder optional?
- Wie stark darf der Spore Herald Buffing betreiben, ohne Wellen unfair zu machen?
- Soll der Boss Adds spawnen oder nur als reiner Durability-Test funktionieren?
