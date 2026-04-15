# Content Config System

This project now uses a shared content-config pattern for gameplay entities.

## Goal

Keep names, descriptions, and gameplay stats data-driven for:
- towers
- enemies
- commander units
- future content such as bosses, upgrades, abilities, factions, and encounters

## Base resource

Common text/meta fields live in:
- `game/scripts/data/game_content_data.gd`

Shared fields include:
- `content_id`
- `category`
- `display_name`
- `display_name_de`
- `short_description`
- `short_description_de`
- `description`
- `description_de`
- `tags`
- `extra_stats`

Shared helper methods include:
- `get_localized_display_name()`
- `get_localized_short_description()`
- `get_localized_description()`
- `get_gameplay_stats()`

## Specialized resources

### Towers
Script:
- `game/scripts/data/tower_data.gd`

Resources:
- `game/data/towers/basic_tower.tres`
- `game/data/towers/heavy_battery.tres`
- `game/data/mvp/towers/musterline_redoubt.tres`
- `game/data/mvp/towers/auric_sentinel_lancepost.tres`
- `game/data/mvp/towers/pyre_chapel_array.tres`
- `game/data/mvp/towers/cogforged_relay_spire.tres`
- `game/data/mvp/towers/reliquary_bombard.tres`

### Enemies
Script:
- `game/scripts/data/enemy_data.gd`

Resources:
- `game/data/enemies/scuttleborn.tres`
- `game/data/enemies/shellback_brute.tres`
- `game/data/enemies/siegebreaker.tres`
- `game/data/mvp/enemies/scuttleborn-mvp.tres`
- `game/data/mvp/enemies/razor_leaper.tres`
- `game/data/mvp/enemies/shellback_brute-mvp.tres`
- `game/data/mvp/enemies/spore_herald.tres`
- `game/data/mvp/enemies/maw_colossus.tres`

### Commander
Script:
- `game/scripts/data/commander_data.gd`

Resources:
- `game/data/commander/basic_commander.tres`
- `game/data/mvp/commander/legion_prefect.tres`

## Runtime usage

### Towers
Tower scenes point to `TowerData` resources.
Gameplay script:
- `game/scripts/gameplay/towers/basic_tower.gd`

Useful methods:
- `get_ui_display_name()`
- `get_content_summary()`
- `get_content_description()`
- `get_gameplay_stats()`

### Enemies
Enemy scenes now point to `EnemyData` resources.
Gameplay script:
- `game/scripts/gameplay/enemies/basic_enemy.gd`

Useful methods:
- `get_display_name()`
- `get_content_summary()`
- `get_content_description()`
- `get_gameplay_stats()`

### Commander
Commander scene now points to a `CommanderData` resource.
Gameplay script:
- `game/scripts/gameplay/commander/basic_commander.gd`

Useful methods:
- `get_display_name()`
- `get_content_summary()`
- `get_content_description()`
- `get_gameplay_stats()`

## How to add future content

### New tower
1. Create a new `.tres` under `game/data/towers/` or `game/data/mvp/towers/`
2. Use `TowerData`
3. Fill in localized names, descriptions, and stats
4. Point the tower scene to that resource

### New enemy or boss
1. Create a new `.tres` under `game/data/enemies/` or `game/data/mvp/enemies/`
2. Use `EnemyData`
3. Fill in localized names, descriptions, and stats
4. Point the enemy scene to that resource

### New commander or hero
1. Create a new `.tres` under `game/data/commander/` or `game/data/mvp/commander/`
2. Use `CommanderData`
3. Fill in localized names, descriptions, ability text, and stats
4. Point the commander scene to that resource

### Future upgrades / abilities / factions
Recommended pattern:
1. Create a new resource script extending `GameContentData`
2. Add typed gameplay fields for that content type
3. Store localized text directly in the resource
4. Expose helper methods similar to the current types

## Notes

- The current system is intentionally lightweight and MVP-friendly.
- Existing gameplay scripts still keep typed fallback exports so scenes remain robust while content is being migrated.
- The currently playable prototype already uses MVP-derived content resources alongside the earlier baseline examples.
- Localization remains dictionary/resource-based through the config objects instead of using Godot translation tables for these entity definitions.
