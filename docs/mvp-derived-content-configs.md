# MVP Derived Content Configs

This file derives a concrete MVP content set from:
- `docs/tdg40k_25_klassen.md`

The source document remains unchanged.

## Goal

Provide concrete `.tres` content configs for:
- 5 towers
- 1 commander
- 5 enemies

These are stored separately under `game/data/mvp/` from the older baseline resources, while the current prototype now already uses the MVP-derived roster in the playable menu, HUD, commander flow, and wave setup.

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
- The prototype now uses MVP-derived tower, enemy, and commander resources in the current playable setup.
- The older baseline resources still exist as legacy/reference content and fallback examples.

## Current usage

The current prototype already wires these MVP configs into:
- tower scenes and build UI
- enemy scenes and wave composition
- commander selection and commander spawn flow
- start-menu inspect/content browser UI

## Suggested next step

If desired, the next step is to continue iterating on balance, mechanical differentiation, and presentation for the already integrated MVP configs.
