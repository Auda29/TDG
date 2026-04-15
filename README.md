# TDG40k

Developer: **Auda29**

> `TDG40k` is currently a **working title**.

TDG40k is an original grim sci-fi **tower defense game** focused on readable combat, strong run progression, and distinct tower roles.

## Project status
This repository is no longer concept-only. It currently contains:
- a documented design/MVP direction under `docs/`
- a playable Godot prototype under `game/`
- lightweight CI for docs and Godot smoke checks

Current prototype features include:
- free tower placement inside a defended build zone
- five playable MVP tower classes with clearer roles:
  - Musterline Redoubt
  - Auric Sentinel Lancepost
  - Pyre Chapel Array
  - Cogforged Relay Spire
  - Reliquary Bombard
- a pre-run commander selection flow with a movable commander and Overwatch support ability
- campaign and endless modes with difficulty selection and unlock progression
- bilingual UI support for English and German
- persistent profile/settings storage for language, mode, audio, fullscreen, and unlocks
- start menu settings, in-game settings overlay, and end-of-run restart/menu/free-mode flow
- wave spawning with scaling enemies and staged elite/boss pacing
- MVP enemy roster integration with swarm, fast, elite, support, and boss threats
- sell refunds, credits, base HP, boss bar, warning banners, and lane threat markers
- data-driven content resources for towers, enemies, and commander content
- an MVP content browser/inspect UI in the start menu

## Vision
The project aims to combine:
- satisfying tower defense gameplay
- meaningful tower roles and upgrade paths
- strong combat readability in dense fights
- dark industrial military sci-fi atmosphere
- original factions, naming, and visual identity

## Current MVP direction
The working prototype follows these assumptions:
- singleplayer first
- one defendable outpost / fortress fantasy
- top-down 2D prototype in Godot
- one enemy faction for the first slice
- commander-led support gameplay
- small, playable milestones before larger systems

For the detailed MVP target, see:
- `docs/mvp-scope.md`

## Repository structure
- `docs/` — design, scope, art direction, and planning docs
- `game/` — Godot prototype project
- `AGENTS.md` — project-specific guidance for coding agents
- `.github/workflows/` — lightweight CI

## Important docs
- `docs/index.md`
- `docs/game-design-overview.md`
- `docs/mvp-scope.md`
- `docs/tower-klassen-konzept.md`
- `docs/enemy-faction-konzept.md`
- `docs/commander-konzept.md`
- `docs/art-direction-notes.md`
- `docs/ip-do-dont.md`

## Prototype entry points
Inside `game/` the main entry points are:
- `project.godot`
- `scenes/bootstrap/main.tscn`
- `scenes/bootstrap/game_root.tscn`
- `scripts/gameplay/game_root.gd`

## Near-term priorities
- runtime-validate the current Godot prototype changes in-editor/headless
- continue polishing the 5-tower MVP roster and wave balance
- deepen tower differentiation with richer mechanics and upgrade paths
- expand commander options beyond the current MVP commander
- keep visuals lightweight but readable

## CI
Current GitHub Actions are intentionally lightweight:
- markdown validation for docs
- headless Godot smoke checks for the prototype project

## License
This repository is licensed under the MIT License. See `LICENSE` for details.
