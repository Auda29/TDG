# MVP Derived Content Configs

This file derives a concrete MVP content set from:
- `docs/tdg40k_25_klassen.md`

The source document remains unchanged.

## Goal

Provide concrete `.tres` content configs for:
- 5 towers
- 1 commander
- 5 enemies

These are stored separately from the currently wired prototype resources so they can be integrated later without immediately changing live gameplay balance.

## Location

### Towers
- `game/data/mvp/towers/musterline_redoubt.tres`
- `game/data/mvp/towers/auric_sentinel_lancepost.tres`
- `game/data/mvp/towers/pyre_chapel_array.tres`
- `game/data/mvp/towers/cogforged_relay_spire.tres`
- `game/data/mvp/towers/reliquary_bombard.tres`

### Commander
- `game/data/mvp/commander/legion_prefect.tres`

### Enemies
- `game/data/mvp/enemies/scuttleborn-mvp.tres`
- `game/data/mvp/enemies/razor_leaper.tres`
- `game/data/mvp/enemies/shellback_brute-mvp.tres`
- `game/data/mvp/enemies/spore_herald.tres`
- `game/data/mvp/enemies/maw_colossus.tres`

## Notes

- These resources use the unified content-config system introduced through:
  - `game/scripts/data/game_content_data.gd`
  - `game/scripts/data/tower_data.gd`
  - `game/scripts/data/enemy_data.gd`
  - `game/scripts/data/commander_data.gd`
- The resources include localized names and descriptions.
- Unsupported design values from the roster doc are preserved in `extra_stats` where practical.
- Existing live prototype scenes still point to the earlier currently-playable resources unless explicitly rewired.

## Suggested next step

If desired, the next step is to choose which of these MVP configs should be promoted into actual playable scenes/waves first, then wire them into:
- tower scenes
- enemy scenes
- wave definitions
- commander selection / UI
