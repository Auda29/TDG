# TDG40k – Klassenkatalog (25 Klassen)

## Zweck

Dieses Dokument sammelt **10 Tower**, **5 Commander** und **10 Enemy-Klassen** für den aktuellen Prototyp.
Die Namen sind **eigenständig**, die Rollen und Fantasien sind aber bewusst an klar erkennbare **Warhammer-40k-Archetypen** angelehnt.

Wichtig:
- **Keine 1:1-Kopien** von Fraktionen, Einheiten oder Eigennamen.
- **Stats sind Startwerte** für einen ersten spielbaren Balance-Pass.
- **Upgradepfade sind bewusst ausgespart** und kommen später.

## Stat- und Design-Annahmen

### Allgemein
- **DPS** = theoretischer Single-Target-Dauerschaden **vor** Buffs, Crits, Armor-Formel und Resistenzlogik.
- **Armor Rating** = relativer Designwert von **0 bis 10**. Die exakte Schadensformel ist noch offen.
- **Reichweite** und **Bewegung** sind in **Spielmetern** gedacht.
- **Kosten** = generische Build-Kosten / Credits / Supply, je nachdem wie du deine Ökonomie später benennst.
- **Leak-Schaden** = Schaden am Kern / der Festung, falls ein Gegner durchkommt.

### Faction-Arbeitstitel
- **Defender-Faction:** The Helion Bastion
- **Enemy-Faction:** The Carrion Tide

---

# 1. Tower-Klassen

## Kurzübersicht

| Tower | Rolle | 40k-Äquivalent | Kosten | Reichweite | DPS |
|---|---|---:|---:|---:|---:|
| Musterline Redoubt | günstiger Generalist | Astra Militarum | 80 | 7.5 | 34 |
| Geneward Bastion | Elite-Allrounder | Space Marines | 145 | 8.0 | 60 |
| Auric Sentinel Lancepost | Anti-Armor / Elite | Adeptus Custodes | 210 | 8.5 | 80 |
| Pyre Chapel Array | Anti-Swarm / Nahbereich | Adepta Sororitas | 130 | 3.8 | 90* |
| Cogforged Relay Spire | Support / Scan | Adeptus Mechanicus | 160 | 6.0 | 14 |
| Reliquary Bombard | indirektes Feuer / AoE | Dreadnought / Relic Walker | 190 | 11.5 | 40* |
| Null Ward Obelisk | Anti-Buff / Anti-Special | Grey Knights / Sisters of Silence | 175 | 7.0 | 33 |
| Veilshot Eyrie | Sniper / Priority Kill | Vindicare / Assassinorum | 155 | 10.5 | 76 |
| Crown Engine Ballista | Endgame Super-Heavy | Imperial Knights | 350 | 12.0 | 111 |
| Xenocell Watchkeep | adaptiver Spezialist | Deathwatch / Imperial Agents | 185 | 8.0 | 63–72 |

\* Pyre Chapel Array und Reliquary Bombard skalieren vor allem über **Mehrfachtreffer**.

---

## 1.1 Musterline Redoubt

**Rolle:** günstiger Generalist, Linienhalter, Basistower  
**40k-Äquivalent:** Astra Militarum / kasernierte Infanterielinie / Bunkerstellung  
**Beschreibung:** Ein standardisierter Verteidigungsbunker für zuverlässiges Dauerfeuer. Kein Glamour, keine aristokratische Goldrüstung, aber genau das Ding hält frühe und mittlere Wellen zusammen.

| Stat | Wert |
|---|---|
| Kosten | 80 |
| Tags | ballistic, infantry, core, generalist |
| Schaden pro Schuss | 12 |
| Angriffsintervall | 0.35 s |
| DPS | 34 |
| Reichweite | 7.5 |
| Armor Pressure | niedrig |
| Zielmodus | First / Nearest |
| Sonderregel | **Formation Link:** +5 % Angriffstempo pro angrenzendem Musterline Redoubt, max. 3 Stacks |

---

## 1.2 Geneward Bastion

**Rolle:** Elite-Allrounder, verlässlicher Midgame-Anker  
**40k-Äquivalent:** Space Marines / genetisch verstärkte Schocktruppen  
**Beschreibung:** Disziplinierte Burst-Salven, hohe Zuverlässigkeit, starke Baseline. Teurer als Linieninfanterie, aber deutlich weniger peinlich gegen gemischte Wellen.

| Stat | Wert |
|---|---|
| Kosten | 145 |
| Tags | elite, ballistic, burst, generalist |
| Schaden pro Angriff | 3 × 24 |
| Zyklus pro Burst | 1.2 s |
| DPS | 60 |
| Reichweite | 8.0 |
| Armor Pressure | mittel |
| Zielmodus | First / Strongest |
| Sonderregel | **Disciplined Fire:** +10 % Genauigkeit und +15 % Schaden gegen Ziele über 50 % HP |

---

## 1.3 Auric Sentinel Lancepost

**Rolle:** Anti-Armor, Elite-Killer, Bossdruck  
**40k-Äquivalent:** Adeptus Custodes / goldene Halbgott-Wächter  
**Beschreibung:** Wenige Schüsse, brutale Präzision. Ein Luxusproblem in Turmform – solange das Luxusproblem Dinge zuverlässig tötet, ist das völlig in Ordnung.

| Stat | Wert |
|---|---|
| Kosten | 210 |
| Tags | elite, precision, anti-armor, anti-boss |
| Schaden pro Schuss | 160 |
| Angriffsintervall | 2.0 s |
| DPS | 80 |
| Reichweite | 8.5 |
| Armor Pressure | sehr hoch |
| Zielmodus | Strongest / Elite / Boss |
| Sonderregel | **Priority Lance:** +35 % Schaden gegen Elite- und Bossziele |

---

## 1.4 Pyre Chapel Array

**Rolle:** Anti-Swarm, Nahbereichskontrolle, Engstellen-Tower  
**40k-Äquivalent:** Adepta Sororitas / heilige Flammen- und Läuterungswaffen  
**Beschreibung:** Ein kurzer, brutaler Flammenkegel für Korridore, Kurven und alles, was in großer Zahl schlechte Entscheidungen trifft. Genau das also, was Schwärme tun.

| Stat | Wert |
|---|---|
| Kosten | 130 |
| Tags | flame, aoe, short-range, anti-swarm |
| Schaden pro Tick | 18 |
| Tickintervall | 0.2 s |
| DPS gegen Primärziel | 90 |
| Reichweite | 3.8 Kegel |
| Armor Pressure | niedrig |
| Zielmodus | dichteste Gruppe / nächster Gegner im Kegel |
| Sonderregel | **Lingering Burn:** 8 Burn-DPS für 2.5 s, wird bei weiterem Treffer erneuert |

---

## 1.5 Cogforged Relay Spire

**Rolle:** Support, Scan, Cluster-Buff  
**40k-Äquivalent:** Adeptus Mechanicus / Tech-Priest- und Skitarii-Supportnetz  
**Beschreibung:** Kein Tower für Leute mit “mehr Explosionen = mehr Design”. Er macht benachbarte Tower besser, sauberer und deutlich weniger blind.

| Stat | Wert |
|---|---|
| Kosten | 160 |
| Tags | support, scan, arc, utility |
| Schaden pro Schuss | 10 |
| Angriffsintervall | 0.7 s |
| DPS | 14 |
| Reichweite | 6.0 |
| Aura-Radius | 5.5 |
| Armor Pressure | gering |
| Zielmodus | nächstes Ziel |
| Sonderregel | **Relay Field:** Tower in Aura erhalten +12 % Angriffstempo und +10 % Zielerfassung; Burrow-/Stealth-Gegner werden in der Aura sichtbar |

---

## 1.6 Reliquary Bombard

**Rolle:** indirektes Feuer, Splash, Hinterreihen-Druck  
**40k-Äquivalent:** Dreadnought / reliquiengebundener Veteran in schwerer Waffenplattform  
**Beschreibung:** Eine uralte, sarkophaggebundene Artillerieplattform. Sie schießt langsam, trifft spät und wirkt dabei trotzdem wie ein sehr überzeugendes Argument gegen Gruppenbildung.

| Stat | Wert |
|---|---|
| Kosten | 190 |
| Tags | artillery, explosive, indirect, aoe |
| Direktschaden | 120 |
| Splash-Schaden | 60 |
| Angriffsintervall | 3.0 s |
| Single-Target-DPS | 40 |
| Reichweite | 11.5 |
| Splash-Radius | 2.2 |
| Zielmodus | größte Gruppe / markierte Zone |
| Sonderregel | **Buried Coordinates:** +25 % Genauigkeit gegen markierte Gegner und verlangsamte Gruppen |

---

## 1.7 Null Ward Obelisk

**Rolle:** Anti-Buff, Anti-Regeneration, Reveal  
**40k-Äquivalent:** Grey Knights / Sisters of Silence / anti-psyker Nullzonen  
**Beschreibung:** Weniger Schadensmonster, mehr “dein nerviger Support-Stack funktioniert jetzt plötzlich nicht mehr”. Einer dieser Tower, die erst unterschätzt und danach nicht mehr aus dem Build wegzudenken sind.

| Stat | Wert |
|---|---|
| Kosten | 175 |
| Tags | null, support, anti-buff, reveal |
| Schaden pro Puls | 40 |
| Angriffsintervall | 1.2 s |
| DPS | 33 |
| Reichweite | 7.0 |
| Feld-Radius | 4.8 |
| Armor Pressure | mittel |
| Zielmodus | nächste Support- oder Eliteeinheit |
| Sonderregel | **Null Field:** reduziert Buffstärke und Regeneration von Gegnern im Feld um 60 %; enttarnt Stealth-Ziele |

---

## 1.8 Veilshot Eyrie

**Rolle:** Sniper, Prioritätseliminierung, Anti-Special  
**40k-Äquivalent:** Vindicare Assassin / Officio Assassinorum  
**Beschreibung:** Der Tower für alles, was du eigentlich sofort tot sehen willst: Heralds, Leaper, Stalker, andere Spezialisten. Entfernt Probleme, bevor sie ihre Hobbys ausleben.

| Stat | Wert |
|---|---|
| Kosten | 155 |
| Tags | sniper, precision, anti-special, priority |
| Schaden pro Schuss | 190 |
| Angriffsintervall | 2.5 s |
| DPS | 76 |
| Reichweite | 10.5 |
| Armor Pressure | hoch |
| Zielmodus | Support / Stealth / Fast / Elite |
| Sonderregel | **Clean Sightline:** ignoriert Body-Blocking; +50 % Schaden gegen Support-, Stealth- und Leaper-Tags |

---

## 1.9 Crown Engine Ballista

**Rolle:** Super-Heavy, Bosskiller, Endgame-Anker  
**40k-Äquivalent:** Imperial Knights / uralte adelige Kriegsmaschinen  
**Beschreibung:** Enorm teuer, enorm groß, enorm effektiv. Genau die Art Tower, die dir im Lategame sagt: “Fein, ich regel das”, bevor der Boss deine Verteidigung beleidigt.

| Stat | Wert |
|---|---|
| Kosten | 350 |
| Tags | super-heavy, beam, anti-boss, anti-armor |
| Schaden pro Schuss | 420 |
| Angriffsintervall | 3.8 s |
| DPS | 111 |
| Reichweite | 12.0 |
| Armor Pressure | extrem |
| Zielmodus | Boss / Strongest |
| Sonderregel | **Solar Lance:** +60 % Schaden gegen Boss- und Colossus-Ziele; 30 % Liniendurchschlag auf Sekundärziele |

---

## 1.10 Xenocell Watchkeep

**Rolle:** adaptiver Spezialist, flexibler Konterturm  
**40k-Äquivalent:** Deathwatch / Imperial Agents / spezialisierte Xenosjäger  
**Beschreibung:** Kein roher Stat-Blocker, sondern ein Problemlöser. Wechselt Munition je nach Zielprofil und verhindert, dass der Build an genau einer Freak-Welle stirbt.

| Stat | Wert |
|---|---|
| Kosten | 185 |
| Tags | adaptive, specialist, xeno-hunter, utility |
| Reichweite | 8.0 |
| Armor Pressure | variabel |
| Zielmodus | auto-adaptiv nach Zieltag |
| Modus A – Cleaver Rounds | 4 × 18 Schaden, 1.0 s Zyklus, 72 DPS, priorisiert swarm/light |
| Modus B – Piercer Round | 70 Schaden, 1.1 s Intervall, 64 DPS, +20 % gegen armor/heavy |
| Modus C – Interdictor Beam | 38 Schaden, 0.6 s Intervall, 63 DPS, verlangsamt fast/special um 15 % |
| Sonderregel | **Adaptive Loadout:** wechselt automatisch alle 0.5 s auf den sinnvollsten Modus im Zielsektor |

---

# 2. Commander-Klassen

## Kurzübersicht

| Commander | Rolle | 40k-Äquivalent | HP | Armor | DPS |
|---|---|---|---:|---:|---:|
| Legion Prefect | Standard-Support-Commander | Space Marine Captain | 900 | 3 | 58 |
| Auric Tribune | Elite-Fronter / Zone Control | Custodian Captain | 1400 | 6 | 80 |
| Cog-Seer Dominus | Tower-Buff-Spezialist | Tech-Priest Dominus | 1000 | 4 | 68 |
| Pyre Abbess | Burn / Control Support | Canoness / Palatine | 980 | 3 | 80* |
| Veil Inquisitor | Priority Hunter / Utility | Inquisitor | 850 | 2 | 67 |

\* Pyre Abbess skaliert stark über Burn- und Zonenwirkung.

---

## 2.1 Legion Prefect

**Rolle:** Standard-Commander, Fokusfeuer-Support, Feldpräsenz  
**40k-Äquivalent:** Space Marine Captain / Primaris-Captain  
**Beschreibung:** Der sauberste Einstieg in dein Commander-System. Er verstärkt gute Tower-Platzierung, ohne selbst zum peinlich überdesignten One-Man-Army-Problem zu werden.

| Stat | Wert |
|---|---|
| HP | 900 |
| Armor Rating | 3 |
| Bewegung | 3.2 |
| Basisangriff | 26 Schaden |
| Angriffsintervall | 0.45 s |
| DPS | 58 |
| Angriffsreichweite | 6.5 |
| Tags | commander, support, ballistic, doctrine |

**Fähigkeiten**
1. **Kill Designation** – markiert ein Ziel für 10 s; Tower verursachen **+25 % Schaden** gegen dieses Ziel. Cooldown: **22 s**. Reichweite: **8.0**  
2. **Bulwark Beacon** – Beacon mit **5.0 Radius** für **8 s**; Tower erhalten **+15 % Angriffstempo** und **+10 % Reichweite**. Cooldown: **30 s**

**Passiv**
- **Battle Doctrine:** Tower im Umkreis von **3.0** erhalten **+8 % Zielreaktion / Genauigkeit**

---

## 2.2 Auric Tribune

**Rolle:** Elite-Commander, Hotspot-Stabilisator, Anti-Fast-Control  
**40k-Äquivalent:** Adeptus Custodes Shield-Captain  
**Beschreibung:** Sehr robust, sehr direkt, sehr unangenehm für Durchbruchsgegner. Wenn irgendwo etwas “nur kurz” durchrutscht, steht dieser Commander bereits dort und ist anderer Meinung.

| Stat | Wert |
|---|---|
| HP | 1400 |
| Armor Rating | 6 |
| Bewegung | 3.0 |
| Basisangriff | 72 Schaden |
| Angriffsintervall | 0.9 s |
| DPS | 80 |
| Angriffsreichweite | 4.5 |
| Tags | commander, elite, control, anti-fast |

**Fähigkeiten**
1. **Guardian Intercept** – Sprint/Dash über **6.0** Meter, verursacht **140 Schaden**; schnelle Ziele werden **1.5 s betäubt**, schwere Ziele **2.5 s um 35 % verlangsamt**. Cooldown: **20 s**  
2. **Adamant Halo** – Aura mit **5.0 Radius** für **8 s**; Gegner in der Zone bewegen sich **20 % langsamer**, Tower erhalten **+15 % Armor Pressure**. Cooldown: **28 s**

**Passiv**
- **Golden Presence:** Tower in **3.5** Radius ignorieren **1 Armor Rating** des Ziels

---

## 2.3 Cog-Seer Dominus

**Rolle:** Cluster-Buffer, Scan-Commander, Synergie-Katalysator  
**40k-Äquivalent:** Tech-Priest Dominus / Mechanicus-Kommandeur  
**Beschreibung:** Der Commander für Leute, die lieber ein sauberes System optimieren als selbst die dickste Waffe zu tragen. Also natürlich auch gefährlich.

| Stat | Wert |
|---|---|
| HP | 1000 |
| Armor Rating | 4 |
| Bewegung | 2.9 |
| Basisangriff | 34 Schaden |
| Angriffsintervall | 0.5 s |
| DPS | 68 |
| Angriffsreichweite | 5.8 |
| Tags | commander, support, scan, arc |

**Fähigkeiten**
1. **Machine Benediction** – bufft einen Tower für **10 s** mit **+25 % Schaden** und **+20 % Zielerfassung**. Cooldown: **18 s**  
2. **Overcharge Lattice** – Aura mit **5.0 Radius** für **8 s**; Tower erhalten **+12 % Angriffstempo** und verursachen alle **2 s** einen zusätzlichen **20 Arc-Schaden** auf ihr Ziel. Cooldown: **30 s**

**Passiv**
- **Auspex Mesh:** Burrow- und Stealth-Gegner werden im Radius **6.0** früher aufgedeckt

---

## 2.4 Pyre Abbess

**Rolle:** Burn-Support, Engstellenkontrolle, Midrange-Cleanser  
**40k-Äquivalent:** Canoness / Palatine / fanatische Flammenführerin  
**Beschreibung:** Kein subtiler Commander. Sie beantwortet Schwarmdruck mit Feuer, Moral mit mehr Feuer und Designzweifel ebenfalls mit Feuer.

| Stat | Wert |
|---|---|
| HP | 980 |
| Armor Rating | 3 |
| Bewegung | 3.1 |
| Basisangriff | 16 Schaden pro Tick |
| Tickintervall | 0.2 s |
| DPS | 80 |
| Angriffsreichweite | 3.6 Kegel |
| Tags | commander, flame, aoe, burn |

**Fähigkeiten**
1. **Consecration Line** – legt eine **6.0 Meter** lange Feuerlinie für **6 s**; Gegner darin erleiden **22 Burn-DPS**. Cooldown: **20 s**  
2. **Canticle of Ash** – Aura mit **5.0 Radius** für **8 s**; Tower erhalten **+20 % Burn-/Explosive-Schaden** und **+10 % Angriffstempo**. Cooldown: **28 s**

**Passiv**
- **Zeal Flame:** brennende Gegner erleiden **+10 % Schaden** aus allen Quellen

---

## 2.5 Veil Inquisitor

**Rolle:** Spezialistenjäger, Enttarnung, flexible Krisenreaktion  
**40k-Äquivalent:** Inquisitor / Imperial Agent / Hexenjäger  
**Beschreibung:** Zielpriorisierung als Person. Er ist weniger der “Frontmann” und mehr der Grund, warum gegnerische Support- und Ambush-Einheiten plötzlich sehr schlechte Tage haben.

| Stat | Wert |
|---|---|
| HP | 850 |
| Armor Rating | 2 |
| Bewegung | 3.4 |
| Basisangriff | 54 Schaden |
| Angriffsintervall | 0.8 s |
| DPS | 67 |
| Angriffsreichweite | 6.8 |
| Tags | commander, precision, reveal, anti-special |

**Fähigkeiten**
1. **Writ of Erasure** – ein Ziel verliert alle aktiven Buffs und nimmt **8 s lang +20 % Schaden**. Cooldown: **18 s**. Reichweite: **8.5**  
2. **Shadow Transit** – kurze Teleport-Reposition über **7.0** Meter; der nächste Schuss innerhalb von **4 s** verursacht **220 Schaden** und ignoriert **4 Armor Rating**. Cooldown: **24 s**

**Passiv**
- **Unseen No More:** Specials, Burrower und Stealth-Ziele werden im Radius **7.0** früher markiert

---

# 3. Enemy-Klassen – The Carrion Tide

## Kurzübersicht

| Enemy | Rolle | 40k-Äquivalent | HP | Armor | Speed | Leak |
|---|---|---|---:|---:|---:|---:|
| Scuttleborn | leichter Schwarmgegner | Termagants / Rippers | 40 | 0 | 3.6 | 1 |
| Razor Leaper | Fast-Mover / Gap Punisher | Genestealers / Leapers | 95 | 1 | 5.2 | 2 |
| Shellback Brute | gepanzerter Frontbrecher | Carnifex / Tyrant Guard | 520 | 6 | 1.6 | 5 |
| Broodwarden | Synapse-Leader | Tyranid Warriors / Node Beasts | 260 | 3 | 2.3 | 3 |
| Spore Herald | Support-Buffer | Zoanthrope / Neuro-support | 180 | 1 | 2.0 | 2 |
| Burrow Mite | Tunnler / Flanker | Raveners / Burrow Swarm | 70 | 0 | 3.4 | 1 |
| Harrow Stalker | Stealth-Assassin | Lictor | 140 | 2 | 4.4 | 2 |
| Spine Mortar Beast | lebende Artillerie | Biovore | 340 | 2 | 1.8 | 4 |
| Cystbearer Hulk | Tank mit Death-Spawn | Brood-beast / Tervigon-Mix | 760 | 4 | 1.4 | 6 |
| Maw Colossus | Boss / Belagerungsmonster | Norn-/Bio-Titan-Lite | 5200 | 8 | 1.1 | 20 |

---

## 3.1 Scuttleborn

**Rolle:** Standard-Schwarmgegner, früher Mengendruck  
**40k-Äquivalent:** Tyranid Gaunts / Rippers / leichte Schwarmorganismen  
**Beschreibung:** Klein, schnell, zahlreich und lästig. Der Job dieser Einheit ist nicht Würde, sondern deine AoE-Disziplin zu testen.

| Stat | Wert |
|---|---|
| HP | 40 |
| Armor Rating | 0 |
| Bewegung | 3.6 |
| Leak-Schaden | 1 |
| Bounty | 5 |
| Threat | 2 |
| Tags | swarm, light, organic |
| Sonderregel | erscheint häufig in Gruppen von 8–20 Einheiten |

---

## 3.2 Razor Leaper

**Rolle:** schneller Durchbruchsgegner, Reaktionscheck  
**40k-Äquivalent:** Genestealers / Von Ryan's Leapers / vanguard predators  
**Beschreibung:** Diese Einheit bestraft langsame Heavy-Only-Builds und zwingt Nahbereichskontrolle. Wenn sie frei läuft, ist das keine “interessante emergente Situation”, sondern einfach schlecht verteidigt.

| Stat | Wert |
|---|---|
| HP | 95 |
| Armor Rating | 1 |
| Bewegung | 5.2 |
| Leak-Schaden | 2 |
| Bounty | 10 |
| Threat | 4 |
| Tags | fast, leaper, assault |
| Sonderregel | **Pounce:** alle 6 s kurzer Sprung nach vorn; ignoriert dabei kurze Slow-Effekte |

---

## 3.3 Shellback Brute

**Rolle:** Tank, Feuerbinder, Frontbrecher  
**40k-Äquivalent:** Carnifex / Tyrant Guard / lebender Rammbock  
**Beschreibung:** Langsam, zäh, unerquicklich. Er frisst Schüsse, damit der Rest des Schwarms seine ekelhaften Karriereziele verfolgen kann.

| Stat | Wert |
|---|---|
| HP | 520 |
| Armor Rating | 6 |
| Bewegung | 1.6 |
| Leak-Schaden | 5 |
| Bounty | 28 |
| Threat | 7 |
| Tags | armored, brute, frontline |
| Sonderregel | **Bulwark Carapace:** erleidet 20 % weniger Schaden von Flame- und Light-Projectile-Quellen |

---

## 3.4 Broodwarden

**Rolle:** Synapse-Leiter, Formationstreiber, Mid-Late-Support  
**40k-Äquivalent:** Tyranid Warriors / synaptische Kommandobioformen  
**Beschreibung:** Kein roher Boss, aber ein Problem-Multiplikator. Solange er lebt, bewegt sich der Schwarm koordinierter und nerviger.

| Stat | Wert |
|---|---|
| HP | 260 |
| Armor Rating | 3 |
| Bewegung | 2.3 |
| Leak-Schaden | 3 |
| Bounty | 20 |
| Threat | 6 |
| Tags | synapse, elite, support |
| Sonderregel | **Command Pulse:** verbündete light/brute-Einheiten im Radius 4.0 erhalten +15 % Bewegung und +1 Armor Rating |

---

## 3.5 Spore Herald

**Rolle:** Backline-Support, Buff-Carrier, Prioritätsziel  
**40k-Äquivalent:** Zoanthrope / Neurotyrant / sporenbasierter Support-Knoten  
**Beschreibung:** Bleibt hinter der Front und macht andere Gegner besser. Deshalb will man ihn höflich, aber sofort erschießen.

| Stat | Wert |
|---|---|
| HP | 180 |
| Armor Rating | 1 |
| Bewegung | 2.0 |
| Leak-Schaden | 2 |
| Bounty | 18 |
| Threat | 6 |
| Tags | support, spore, buffer |
| Sonderregel | **Spore Burst Aura:** verbündete Gegner im Radius 4.5 regenerieren 8 HP/s oder erhalten +20 % Bewegung, je nach Wellen-Setup |

---

## 3.6 Burrow Mite

**Rolle:** Tunnler, Backline-Störer, Flankendruck  
**40k-Äquivalent:** Raveners / burrow-adapted swarmforms  
**Beschreibung:** Klein, unangenehm und genau die Sorte Gegner, wegen der man Reveal- und Tracking-Tools plötzlich doch nicht mehr optional findet.

| Stat | Wert |
|---|---|
| HP | 70 |
| Armor Rating | 0 |
| Bewegung | 3.4 |
| Leak-Schaden | 1 |
| Bounty | 7 |
| Threat | 3 |
| Tags | burrower, light, flanker |
| Sonderregel | **Tunnel Break:** taucht an festem Map-Knoten kurz unter und erscheint 5–8 Meter weiter vorn wieder |

---

## 3.7 Harrow Stalker

**Rolle:** Stealth-Elite, Ambush-Jäger, Spezialistenkiller  
**40k-Äquivalent:** Lictor / Schatten-Assassine des Schwarms  
**Beschreibung:** Keine Massenbedrohung, sondern ein chirurgisch ekliges Einzelproblem. Wird er zu spät gesehen, ist das genau so unerquicklich, wie es klingt.

| Stat | Wert |
|---|---|
| HP | 140 |
| Armor Rating | 2 |
| Bewegung | 4.4 |
| Leak-Schaden | 2 |
| Bounty | 14 |
| Threat | 5 |
| Tags | stealth, assassin, elite |
| Sonderregel | **Veil Carapace:** ist nur durch Scan, Null-Felder oder Nähe sichtbar; beim ersten Reveal erhält er 2 s lang +40 % Bewegung |

---

## 3.8 Spine Mortar Beast

**Rolle:** lebende Artillerie, Debuff-Druck, Belagerungsunterstützung  
**40k-Äquivalent:** Biovore / sporenwerfende Bio-Artillerie  
**Beschreibung:** Es bringt unangenehme Fernwirkung in die Welle. Nicht schnell, nicht elegant, aber hochmotiviert, deine Defense-Cluster schlecht aussehen zu lassen.

| Stat | Wert |
|---|---|
| HP | 340 |
| Armor Rating | 2 |
| Bewegung | 1.8 |
| Leak-Schaden | 4 |
| Bounty | 24 |
| Threat | 6 |
| Tags | artillery, spore, siege |
| Sonderregel | **Spore Lob:** alle 7 s landet eine Sporenkapsel auf einer Verteidigungszone und reduziert Tower-Genauigkeit dort 4 s lang um 15 % |

---

## 3.9 Cystbearer Hulk

**Rolle:** Tank-Monster, Death-Spawn-Träger, Lategame-Druck  
**40k-Äquivalent:** brood-bearing siege beast / Tervigon-Harvest-Mix  
**Beschreibung:** Langsam, massiv und genau die Art Gegner, die man ungern direkt vor der Exit-Zone tötet – weil dann der Nachlass noch weiterläuft.

| Stat | Wert |
|---|---|
| HP | 760 |
| Armor Rating | 4 |
| Bewegung | 1.4 |
| Leak-Schaden | 6 |
| Bounty | 35 |
| Threat | 8 |
| Tags | tank, brood, death-spawn |
| Sonderregel | **Rupture Brood:** beim Tod spawnen 6 Cystlings mit je 25 HP, 0 Armor und 3.2 Bewegung |

---

## 3.10 Maw Colossus

**Rolle:** MVP-Boss, Abschlussprüfung, Belagerungsorganismus  
**40k-Äquivalent:** boss-scale Tyranid siege monster / Norn- oder Bio-Titan-Lite-Fantasie  
**Beschreibung:** Der Endgegner des aktuellen Schwarm-Sets. Viel HP, viel Armor, viel Druck – also der Moment, in dem der Build entweder funktioniert oder den Kontakt zur Realität verliert.

| Stat | Wert |
|---|---|
| HP | 5200 |
| Armor Rating | 8 |
| Bewegung | 1.1 |
| Leak-Schaden | 20 |
| Bounty | 180 |
| Threat | 10 |
| Tags | boss, colossal, siege |
| Sonderregel | **Brood Call:** bei 80 %, 60 %, 40 % und 20 % HP spawnt er je 6 Scuttleborn |
| Zusatzregel | **Rage Threshold:** unter 25 % HP erhält er +20 % Bewegung |

---

# 4. Empfohlene MVP-Auswahl

Falls du zuerst nur einen sauberen Vertical Slice willst:

## Tower
- Musterline Redoubt
- Auric Sentinel Lancepost
- Pyre Chapel Array
- Cogforged Relay Spire
- Reliquary Bombard

## Commander
- Legion Prefect

## Enemies
- Scuttleborn
- Razor Leaper
- Shellback Brute
- Spore Herald
- Maw Colossus

---

# 5. Kurzfazit

Diese 25 Klassen bilden zusammen:
- eine gut lesbare **Defender-Seite** mit Generalist-, Elite-, Flame-, Artillery-, Support- und Super-Heavy-Rollen
- eine klare erste **Enemy-Faction** mit Schwarm, Fast-Mover, Tank, Support, Stealth, Artillery und Boss
- genügend thematische Nähe zu 40k, ohne dabei stumpf Namen umzupinseln und so zu tun, als wäre das plötzlich originell

Upgradepfade sind absichtlich noch nicht ausformuliert.
Die hier notierten Werte sind als **erste prototypische Data-Sheets** gedacht und sollten nach den ersten 5–10 Testläufen sauber nachgeschärft werden.
