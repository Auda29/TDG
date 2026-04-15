# TDG Project Guidelines

These instructions apply to this repository and override the global `AGENTS.md` where they are more specific.

## Base guidelines inherited from global AGENTS.md

## General working style
- Be concise, practical, and explicit about assumptions.
- Prefer understanding existing code before making changes.
- Make minimal, targeted edits that preserve project conventions.
- Respect project-local `AGENTS.md` files as more specific instructions.

## Core file and code tools
- Use `read` to inspect files.
- Use `bash` for discovery tasks such as `ls`, `find`, and `rg`.
- Use `edit` for precise modifications to existing files.
- Use `write` for new files or complete rewrites only.
- Prefer semantic/code-aware tools over text search when accuracy matters.

## Code intelligence
- Use `lsp_navigation` first for symbol-aware navigation when available.
- Use `ast_grep_search` and `ast_grep_replace` for structural code search and refactors.

## Subagents
Use the `subagent` tool when:
- repository exploration or context gathering is needed
- planning would benefit from a dedicated pass
- review should be separated from implementation
- multiple independent investigations can run in parallel
- a task is large enough to benefit from delegation

Built-in subagents may include:
- `context-builder`
- `delegate`
- `planner`
- `researcher`
- `reviewer`
- `scout`
- `worker`

Typical patterns:
- run a `scout` to inspect a repo or feature area
- run a `planner` to produce an implementation plan
- run `worker` agents in parallel for independent subtasks
- use a `reviewer` after implementation for a second pass

## Task system
Use the task system.

Available task tools may include:
- `TaskCreate`
- `TaskList`
- `TaskGet`
- `TaskUpdate`
- `TaskExecute`
- `TaskOutput`
- `TaskStop`

Recommended workflow:
1. Create tasks for complex or multi-step work.
2. Mark a task `in_progress` before starting it.
3. Complete implementation and validation.
4. Mark the task `completed` only when the work is fully done.
5. Use `TaskExecute` when a task should be run by a subagent workflow.

Rules:
- Do not start meaningful multi-step work without tracking it.
- Do not mark tasks `completed` if implementation is partial or validation is still pending.
- After completing a task, check for newly unblocked follow-up work.

## MCP usage
- Use `mcp({})` to list connected MCP servers.
- Use `mcp({ server: "..." })` to inspect tools on a server.
- Use `mcp({ describe: "tool_name" })` before using an unfamiliar tool.
- Call MCP tools with valid JSON args.
- Prefer MCP tools for browser automation, remote integrations, GitHub operations, and external systems not covered by local repo tools.

## Docker MCP toolkit
If a Docker MCP server such as `MCP_DOCKER` is available:
- inspect available tools first
- describe the target tool before first use
- prefer it for browser workflows, GitHub actions, fetching external data, and other remote integrations

Typical flow:
1. list MCP servers
2. list tools on `MCP_DOCKER`
3. describe the target tool
4. call the tool with JSON args

---

## TDG-specific project guidance

## Project identity
- This project is a **tower defense game** inspired by the clarity, progression, and upgrade depth of games like Bloons TD6, but it must develop an **original identity**.
- The intended theme is **grim, militaristic sci-fi warfare** inspired by the feel of Warhammer 40k, without directly copying protected factions, names, iconography, lore, unit names, or visual designs.
- When creating content, prefer **original terminology**, **original factions**, and **distinct visual language**.

## Current design direction
- Prioritize a readable tower defense core loop.
- Favor strong upgrade paths, meaningful build choices, and replayability.
- Keep readability high even in visually dense or dramatic scenes.
- The current recommended prototype direction is:
  - singleplayer first
  - top-down or isometric presentation
  - one defendable fortress/outpost fantasy
  - 4 to 5 tower classes for MVP
  - 1 commander/hero with a small number of active skills
  - 1 enemy faction for the first playable slice

## Scope discipline
- Prefer small, playable milestones over broad but unfinished systems.
- For early work, optimize for an MVP / vertical slice before adding campaign-scale systems.
- Default MVP assumptions unless the user says otherwise:
  - 1 map
  - 1 enemy faction
  - 4 to 5 tower/unit types
  - 1 commander/hero
  - 10 to 20 waves
  - a basic upgrade system
  - 1 boss encounter
- Avoid introducing large meta-progression, multiplayer, or multiple factions too early unless specifically requested.

## Documentation conventions
- Put design and planning docs under `docs/`.
- Use clear, descriptive filenames in kebab-case, for example:
  - `docs/game-design-overview.md`
  - `docs/mvp-scope.md`
  - `docs/tower-klassen-konzept.md`
- When adding or updating design docs:
  - separate vision, mechanics, content, and scope clearly
  - prefer concrete bullet points over vague prose
  - explicitly distinguish MVP ideas from later expansion ideas
  - capture open questions in their own section

## Implementation conventions
- Before writing code, check whether a design document for that area should be created or updated first.
- Prefer data-driven structures for towers, enemies, upgrades, waves, and factions where practical.
- Keep names and APIs consistent with tower-defense terminology:
  - waves
  - enemies
  - towers or defense units
  - upgrades
  - range
  - damage
  - armor
  - shields
  - status effects
- Favor systems that support iteration and balancing over hardcoded one-off behaviors.

## Gameplay design preferences
- Prioritize these gameplay pillars:
  - clarity of combat feedback
  - satisfying progression during a run
  - meaningful upgrade decisions
  - faction fantasy through mechanics, not just visuals
- Strongly consider mechanics such as:
  - suppression or morale
  - support/buff towers
  - artillery or indirect fire
  - elite and boss enemies with distinct counterplay
- Be careful with mechanics that reduce readability or overwhelm the player in early prototypes.

## Content/IP safety guidance
- Do not reproduce Warhammer 40k proper nouns, factions, insignia, or copied lore.
- Avoid direct 1:1 analogs with renamed labels if the design is still obviously derivative.
- If asked to create faction, unit, or lore content, produce **spiritually adjacent but original** material.
- When in doubt, prefer original worldbuilding and neutral placeholder names.

## Working with an early-stage repository
- This repository may begin with little or no code; in that case, help establish structure gradually.
- Favor lightweight foundational files first, for example:
  - `docs/`
  - `.gitignore`
  - core design docs
  - simple source structure once a stack is chosen
- Do not assume engine, language, or framework until it is explicitly chosen.
- If technical implementation is requested before a stack is chosen, first clarify or propose options.

## Decision-making defaults
- If no engine is specified, ask before generating engine-specific code.
- If no art direction is specified beyond the brainstorm, default to:
  - dark sci-fi military tone
  - readable silhouettes
  - exaggerated weapons and defenses
  - functional UI over ornate UI for the prototype
- If no game economy details are specified, default to a simple model with one build currency and optional commander ability resource later.

## Validation
- For design work, validate by checking consistency with current docs and stated project scope.
- For code work, validate with the narrowest relevant checks available in the chosen stack.
- Do not claim gameplay is balanced; frame balancing as provisional unless tested.
