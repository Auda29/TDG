extends Node2D

const MAP_SCENE := preload("res://scenes/maps/mvp_map.tscn")
const MUSTERLINE_REDOUBT_SCENE := preload("res://scenes/gameplay/towers/musterline_redoubt.tscn")
const AURIC_SENTINEL_SCENE := preload("res://scenes/gameplay/towers/auric_sentinel_lancepost.tscn")
const PYRE_CHAPEL_SCENE := preload("res://scenes/gameplay/towers/pyre_chapel_array.tscn")
const COGFORGED_RELAY_SCENE := preload("res://scenes/gameplay/towers/cogforged_relay_spire.tscn")
const RELIQUARY_BOMBARD_SCENE := preload("res://scenes/gameplay/towers/reliquary_bombard.tscn")
const BASIC_ENEMY_SCENE := preload("res://scenes/gameplay/enemies/scuttleborn_mvp.tscn")
const RAZOR_LEAPER_SCENE := preload("res://scenes/gameplay/enemies/razor_leaper.tscn")
const SHELLBACK_BRUTE_SCENE := preload("res://scenes/gameplay/enemies/shellback_brute_mvp.tscn")
const SPORE_HERALD_SCENE := preload("res://scenes/gameplay/enemies/spore_herald.tscn")
const MAW_COLOSSUS_SCENE := preload("res://scenes/gameplay/enemies/maw_colossus.tscn")
const LEGION_PREFECT_SCENE := preload("res://scenes/gameplay/commander/legion_prefect.tscn")
const LEGION_PREFECT_DATA := preload("res://data/mvp/commander/legion_prefect.tres")
const WAVE_RUNNER_SCENE := preload("res://scenes/gameplay/wave/wave_runner.tscn")
const HUD_SCENE := preload("res://scenes/ui/mvp_hud.tscn")
const MAIN_MENU_SCENE := "res://scenes/bootstrap/main.tscn"
const MUSTERLINE_REDOUBT_DATA := preload("res://data/mvp/towers/musterline_redoubt.tres")
const AURIC_SENTINEL_DATA := preload("res://data/mvp/towers/auric_sentinel_lancepost.tres")
const PYRE_CHAPEL_DATA := preload("res://data/mvp/towers/pyre_chapel_array.tres")
const COGFORGED_RELAY_DATA := preload("res://data/mvp/towers/cogforged_relay_spire.tres")
const RELIQUARY_BOMBARD_DATA := preload("res://data/mvp/towers/reliquary_bombard.tres")

const TOWER_DEFS := {
	"musterline_redoubt": {"scene": MUSTERLINE_REDOUBT_SCENE, "data": MUSTERLINE_REDOUBT_DATA},
	"auric_sentinel_lancepost": {"scene": AURIC_SENTINEL_SCENE, "data": AURIC_SENTINEL_DATA},
	"pyre_chapel_array": {"scene": PYRE_CHAPEL_SCENE, "data": PYRE_CHAPEL_DATA},
	"cogforged_relay_spire": {"scene": COGFORGED_RELAY_SCENE, "data": COGFORGED_RELAY_DATA},
	"reliquary_bombard": {"scene": RELIQUARY_BOMBARD_SCENE, "data": RELIQUARY_BOMBARD_DATA},
}

const COMMANDER_DEFS := {
	"legion_prefect": {"scene": LEGION_PREFECT_SCENE, "data": LEGION_PREFECT_DATA},
}

@onready var map_layer: Node2D = $MapLayer
@onready var build_layer: Node2D = $BuildLayer
@onready var enemy_layer: Node2D = $EnemyLayer
@onready var tower_layer: Node2D = $TowerLayer
@onready var commander_layer: Node2D = $CommanderLayer
@onready var ui_layer: CanvasLayer = $UILayer

var map_instance: Node2D
var commander_instance: Node2D
var wave_runner: Node
var hud_instance: Control
var tower_preview: Node2D
var current_wave_number: int = 1
var auto_start_next_wave: bool = true
var waiting_for_manual_next_wave: bool = false
var is_game_paused: bool = false
var active_boss: Node = null
var _screen_shake_time: float = 0.0
var _screen_shake_strength: float = 0.0
var _pause_before_settings: bool = false
var _build_drag_active: bool = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	RunState.reset_for_new_run()
	GameState.clear_selection()
	_setup_map()
	_setup_commander()
	_setup_hud()
	_setup_wave()

func _process(delta: float) -> void:
	if RunState.is_run_over:
		if Input.is_action_just_pressed("restart_run"):
			_restart_run()
		_update_hud_feedback()
		return
	if is_game_paused:
		_update_hud_feedback()
		return
	RunState.add_elapsed_time(delta)
	_handle_build_input()
	_update_tower_preview()
	_update_boss_state()
	_update_screen_shake(delta)
	_update_hud_feedback()
	if RunState.base_hp <= 0 and not RunState.is_run_over:
		_trigger_game_over()

func _handle_build_input() -> void:
	if Input.is_action_just_pressed("ability_1"):
		_toggle_tower_selection("musterline_redoubt")
		return
	if Input.is_action_just_pressed("ability_3"):
		_toggle_tower_selection("auric_sentinel_lancepost")
		return
	if Input.is_action_just_pressed("sell_selected"):
		_try_sell_selected_tower()
		return
	if Input.is_action_just_pressed("cycle_target_mode"):
		_try_cycle_selected_tower_targeting(1)
		return
	if Input.is_action_just_pressed("command_secondary"):
		_build_drag_active = false
		_clear_selected_placed_tower()
		GameState.clear_selection()
		_clear_preview()
		return
	if Input.is_action_just_pressed("command_primary"):
		if _is_pointer_over_ui():
			return
		if _build_drag_active:
			return
		if _has_selected_tower():
			_try_place_selected_tower()
			return
		if _try_select_tower_at_mouse():
			return
		if _try_select_commander_at_mouse():
			return
		if GameState.is_commander_selected:
			_move_commander_to_mouse()
	if _build_drag_active and Input.is_action_just_released("command_primary"):
		_finalize_build_drag()

func _setup_map() -> void:
	map_instance = MAP_SCENE.instantiate()
	map_layer.add_child(map_instance)

func _setup_commander() -> void:
	var commander_def: Dictionary = COMMANDER_DEFS.get(RunState.selected_commander_id, COMMANDER_DEFS[RunState.DEFAULT_COMMANDER_ID])
	commander_instance = commander_def.get("scene").instantiate()
	commander_layer.add_child(commander_instance)
	commander_instance.global_position = map_instance.get_commander_spawn_position()
	commander_instance.setup(map_instance.get_world_bounds())
	if commander_instance.has_signal("overwatch_activated"):
		commander_instance.overwatch_activated.connect(_on_overwatch_activated)

func _setup_hud() -> void:
	hud_instance = HUD_SCENE.instantiate()
	hud_instance.process_mode = Node.PROCESS_MODE_ALWAYS
	ui_layer.add_child(hud_instance)
	if hud_instance.has_signal("build_tower_requested"):
		hud_instance.build_tower_requested.connect(_toggle_tower_selection)
	if hud_instance.has_signal("build_tower_drag_started"):
		hud_instance.build_tower_drag_started.connect(_begin_tower_drag)
	if hud_instance.has_signal("sell_selected_requested"):
		hud_instance.sell_selected_requested.connect(_try_sell_selected_tower)
	if hud_instance.has_signal("cycle_targeting_previous_requested"):
		hud_instance.cycle_targeting_previous_requested.connect(func() -> void: _try_cycle_selected_tower_targeting(-1))
	if hud_instance.has_signal("cycle_targeting_next_requested"):
		hud_instance.cycle_targeting_next_requested.connect(func() -> void: _try_cycle_selected_tower_targeting(1))
	if hud_instance.has_signal("pause_toggled"):
		hud_instance.pause_toggled.connect(_set_game_paused)
	if hud_instance.has_signal("auto_wave_toggled"):
		hud_instance.auto_wave_toggled.connect(_set_auto_next_wave)
	if hud_instance.has_signal("next_wave_requested"):
		hud_instance.next_wave_requested.connect(_start_next_wave_if_ready)
	if hud_instance.has_signal("restart_requested"):
		hud_instance.restart_requested.connect(_restart_run)
	if hud_instance.has_signal("menu_requested"):
		hud_instance.menu_requested.connect(_return_to_menu)
	if hud_instance.has_signal("continue_free_mode_requested"):
		hud_instance.continue_free_mode_requested.connect(_continue_in_free_mode)
	if hud_instance.has_signal("settings_overlay_toggled"):
		hud_instance.settings_overlay_toggled.connect(_on_settings_overlay_toggled)

func _setup_wave() -> void:
	wave_runner = WAVE_RUNNER_SCENE.instantiate()
	wave_runner.enemy_scene = BASIC_ENEMY_SCENE
	wave_runner.spawn_interval = 0.9
	wave_runner.wave_cleared.connect(_on_wave_cleared)
	wave_runner.enemy_defeated.connect(_on_enemy_defeated)
	wave_runner.enemy_spawned.connect(_on_enemy_spawned)
	add_child(wave_runner)
	_start_wave(current_wave_number)

func _toggle_tower_selection(tower_id: String) -> void:
	if _build_drag_active and GameState.selected_tower_id == tower_id:
		_build_drag_active = false
		return
	_build_drag_active = false
	_clear_selected_placed_tower()
	GameState.is_commander_selected = false
	GameState.selected_tower_id = "" if GameState.selected_tower_id == tower_id else tower_id
	if GameState.selected_tower_id == "":
		_clear_preview()

func _begin_tower_drag(tower_id: String) -> void:
	_clear_selected_placed_tower()
	GameState.is_commander_selected = false
	GameState.selected_tower_id = tower_id
	_build_drag_active = true

func _finalize_build_drag() -> void:
	_build_drag_active = false
	if _is_pointer_over_ui():
		return
	if _has_selected_tower():
		_try_place_selected_tower()

func _has_selected_tower() -> bool:
	return _get_selected_tower_scene() != null

func _try_place_selected_tower() -> void:
	var tower_scene: PackedScene = _get_selected_tower_scene()
	if tower_scene == null:
		return
	var tower = tower_scene.instantiate()
	var mouse_world: Vector2 = get_global_mouse_position()
	var existing_towers: Array = tower_layer.get_children()
	var validation_reason: String = map_instance.get_build_validation_reason(mouse_world, existing_towers)
	if validation_reason != "ready":
		hud_instance.show_event(_format_build_reason(validation_reason), Color(1.0, 0.4, 0.4))
		tower.queue_free()
		return
	var tower_cost: int = tower.tower_cost
	if not RunState.can_afford(tower_cost):
		hud_instance.show_event(RunState.t("not_enough_credits"), Color(1.0, 0.4, 0.4))
		tower.queue_free()
		return
	RunState.spend_credits(tower_cost)
	tower_layer.add_child(tower)
	tower.global_position = mouse_world
	_select_placed_tower(tower)
	hud_instance.show_event(RunState.t("tower_placed"), Color(0.5, 1.0, 0.6))

func _move_commander_to_mouse() -> void:
	if commander_instance != null and is_instance_valid(commander_instance):
		commander_instance.set_move_target(get_global_mouse_position())
		hud_instance.show_event(RunState.t("commander_repositioned"), Color(0.4, 0.9, 0.6), 0.8)

func _is_pointer_over_ui() -> bool:
	return get_viewport().gui_get_hovered_control() != null

func _on_enemy_reached_goal(enemy: Node) -> void:
	var fortress_damage: int = enemy.fortress_damage if enemy != null else 0
	_apply_base_damage(fortress_damage)

func _apply_base_damage(amount: int) -> void:
	if RunState.is_run_over:
		return
	var resolved_amount: int = max(0, amount)
	if resolved_amount <= 0:
		return
	RunState.base_hp = max(0, RunState.base_hp - resolved_amount)
	hud_instance.show_event(RunState.t("base_hit") % resolved_amount, Color(1.0, 0.5, 0.4))
	if hud_instance.has_method("trigger_damage_flash"):
		hud_instance.trigger_damage_flash(0.45)
	if RunState.base_hp <= 0:
		_trigger_game_over()

func _on_enemy_defeated(credit_reward: int) -> void:
	RunState.register_enemy_defeat()
	RunState.gain_credits(credit_reward)
	hud_instance.show_event(RunState.t("credits_gain") % credit_reward, Color(0.6, 1.0, 0.6))

func _on_overwatch_activated() -> void:
	hud_instance.show_event(RunState.t("overwatch_active"), Color(1.0, 0.85, 0.25))

func _on_enemy_spawned(enemy: Node) -> void:
	if enemy == null or not is_instance_valid(enemy):
		return
	if not enemy.has_method("get_threat_label"):
		return
	var threat_label: String = enemy.get_threat_label()
	if threat_label == "Boss":
		active_boss = enemy
		if enemy.has_signal("defeated"):
			enemy.defeated.connect(_on_boss_defeated, CONNECT_ONE_SHOT)
		if enemy.has_signal("reached_goal"):
			enemy.reached_goal.connect(_on_boss_reached_goal, CONNECT_ONE_SHOT)
		hud_instance.show_banner(RunState.t("boss_approaching"), Color(1.0, 0.78, 0.22), 2.4)
		hud_instance.show_event(RunState.t("boss_enter_lane"), Color(1.0, 0.72, 0.30), 2.4)
		if hud_instance.has_method("show_threat"):
			hud_instance.show_threat(RunState.t("boss_priority"), Color(1.0, 0.84, 0.28), 2.8)
		if hud_instance.has_method("trigger_boss_flash"):
			hud_instance.trigger_boss_flash(0.4)
		_start_screen_shake(0.45, 11.0)
		if map_instance != null and is_instance_valid(map_instance) and map_instance.has_method("trigger_lane_warning"):
			map_instance.trigger_lane_warning(enemy.global_position, 2.6, 1.45, Color(1.0, 0.82, 0.24, 1.0))
		return
	if threat_label == "Elite":
		hud_instance.show_banner(RunState.t("elite_contact"), Color(0.98, 0.46, 0.18), 1.8)
		hud_instance.show_event(RunState.t("elite_enter_lane"), Color(0.98, 0.56, 0.24), 1.8)
		if hud_instance.has_method("show_threat"):
			hud_instance.show_threat(RunState.t("elite_pressure"), Color(1.0, 0.66, 0.24), 2.2)
		if map_instance != null and is_instance_valid(map_instance) and map_instance.has_method("trigger_lane_warning"):
			map_instance.trigger_lane_warning(enemy.global_position, 1.8, 1.0, Color(1.0, 0.66, 0.24, 1.0))

func _on_boss_defeated(enemy: Node) -> void:
	if active_boss == enemy:
		active_boss = null
	hud_instance.show_banner(RunState.t("boss_terminated"), Color(1.0, 0.86, 0.32), 2.0)
	hud_instance.show_event(RunState.t("boss_neutralized"), Color(1.0, 0.82, 0.32), 1.8)
	if hud_instance.has_method("show_threat"):
		hud_instance.show_threat(RunState.t("boss_clear"), Color(0.62, 1.0, 0.76), 2.0)
	_start_screen_shake(0.25, 6.0)

func _on_boss_reached_goal(enemy: Node) -> void:
	if active_boss == enemy:
		active_boss = null

func _trigger_game_over() -> void:
	RunState.mark_defeat()
	waiting_for_manual_next_wave = false
	auto_start_next_wave = false
	_build_drag_active = false
	_clear_preview()
	_clear_selected_placed_tower()
	GameState.clear_selection()
	hud_instance.show_banner(RunState.t("fortress_lost"), Color(1.0, 0.42, 0.28), 99.0)
	hud_instance.show_event(RunState.t("run_over_restart"), Color(1.0, 0.68, 0.30), 99.0)
	if hud_instance.has_method("show_threat"):
		hud_instance.show_threat(RunState.t("failure_base"), Color(1.0, 0.56, 0.30), 99.0)
	get_tree().paused = true

func _trigger_victory(cleared_wave: int) -> void:
	RunState.mark_victory()
	waiting_for_manual_next_wave = false
	_build_drag_active = false
	_clear_preview()
	_clear_selected_placed_tower()
	GameState.clear_selection()
	hud_instance.show_banner(RunState.t("objective_secured"), Color(0.46, 0.92, 0.68), 99.0)
	hud_instance.show_event(RunState.t("target_wave_cleared") % cleared_wave, Color(0.72, 1.0, 0.78), 99.0)
	if hud_instance.has_method("show_threat"):
		hud_instance.show_threat(RunState.t("victory_continue"), Color(0.62, 1.0, 0.76), 99.0)
	get_tree().paused = true

func _on_wave_cleared() -> void:
	if RunState.is_run_over:
		return
	var bonus: int = 75
	var cleared_wave: int = current_wave_number
	RunState.gain_credits(bonus)
	hud_instance.show_event(RunState.t("wave_cleared_bonus") % bonus, Color(0.9, 0.9, 0.4))
	current_wave_number += 1
	if RunState.is_target_wave_reached(cleared_wave):
		_trigger_victory(cleared_wave)
		return
	if auto_start_next_wave:
		await get_tree().create_timer(2.0).timeout
		if auto_start_next_wave:
			_start_wave(current_wave_number)
	else:
		waiting_for_manual_next_wave = true
		hud_instance.show_event(RunState.t("wave_cleared_manual"), Color(0.9, 0.95, 0.55), 2.5)

func _start_wave(wave_number: int) -> void:
	waiting_for_manual_next_wave = false
	RunState.current_wave = wave_number
	hud_instance.show_banner(RunState.t("wave_banner") % wave_number, Color(0.96, 0.62, 0.28), 1.5)
	if wave_number >= 2:
		hud_instance.show_event(RunState.t("pressure_rising"), Color(0.94, 0.52, 0.24), 1.2)
	wave_runner.enemy_count = 8 + (wave_number * 2) + (2 if wave_number >= 6 else 0)
	wave_runner.spawn_interval = maxf(0.42, 0.95 - (wave_number - 1) * 0.045)
	wave_runner.speed_scale = minf(1.0 + ((wave_number - 1) * 0.035), 1.32) * RunState.enemy_speed_multiplier
	wave_runner.health_scale = (1.0 if wave_number <= 4 else minf(1.0 + ((wave_number - 4) * 0.07), 1.55)) * RunState.enemy_health_multiplier
	wave_runner.spawn_queue = _build_spawn_queue(wave_number)
	wave_runner.start_wave(enemy_layer, map_instance.get_enemy_curve(), Callable(self, "_on_enemy_reached_goal"))

func _build_spawn_queue(wave_number: int) -> Array:
	var total_count: int = wave_runner.enemy_count
	var queue: Array = []
	for i in range(total_count):
		queue.append(BASIC_ENEMY_SCENE)

	var is_boss_wave := false
	if RunState.game_mode == "campaign" and not RunState.free_mode_active:
		is_boss_wave = wave_number == RunState.target_wave
	else:
		is_boss_wave = wave_number >= 8 and wave_number % 6 == 0

	if wave_number >= 2:
		for i in range(min(2, int(total_count / 4))):
			queue[max(0, total_count - 2 - i)] = RAZOR_LEAPER_SCENE
	if wave_number >= 3:
		for i in range(min(3, int(total_count / 3))):
			queue[max(0, 2 + i * 2)] = RAZOR_LEAPER_SCENE
	if wave_number >= 4:
		queue[max(0, total_count - 4)] = SHELLBACK_BRUTE_SCENE
	if wave_number >= 5:
		queue[max(0, int(total_count / 2))] = SHELLBACK_BRUTE_SCENE
	if wave_number >= 6:
		queue[max(0, total_count - 6)] = SPORE_HERALD_SCENE
	if wave_number >= 7:
		queue[max(0, int(total_count / 3))] = SPORE_HERALD_SCENE
		queue[max(0, total_count - 8)] = SHELLBACK_BRUTE_SCENE
	if wave_number >= 9:
		queue[max(0, total_count - 10)] = RAZOR_LEAPER_SCENE
		queue[max(0, total_count - 12)] = SHELLBACK_BRUTE_SCENE
	if is_boss_wave:
		queue[max(0, total_count - 1)] = MAW_COLOSSUS_SCENE
		queue[max(0, total_count - 3)] = SPORE_HERALD_SCENE
		queue[max(0, total_count - 5)] = SHELLBACK_BRUTE_SCENE

	return queue

func _update_tower_preview() -> void:
	var tower_scene: PackedScene = _get_selected_tower_scene()
	if tower_scene == null:
		_clear_preview()
		return
	var selected_name: String = tower_scene.resource_path.get_file()
	if tower_preview == null or tower_preview.scene_file_path.get_file() != selected_name:
		_clear_preview()
		tower_preview = tower_scene.instantiate()
		tower_preview.set_preview_mode(true)
		build_layer.add_child(tower_preview)
	var mouse_world: Vector2 = get_global_mouse_position()
	tower_preview.global_position = mouse_world
	var validation_reason: String = map_instance.get_build_validation_reason(mouse_world, tower_layer.get_children())
	var affordable: bool = RunState.can_afford(tower_preview.tower_cost)
	var preview_is_valid := validation_reason == "ready" and affordable
	tower_preview.modulate = Color(0.5, 1.0, 0.6, 0.75) if preview_is_valid else Color(1.0, 0.35, 0.35, 0.75)
	if tower_preview.has_method("set_preview_valid"):
		tower_preview.set_preview_valid(preview_is_valid)

func _clear_preview() -> void:
	if tower_preview != null and is_instance_valid(tower_preview):
		tower_preview.queue_free()
	tower_preview = null

func _try_select_tower_at_mouse() -> bool:
	var mouse_world: Vector2 = get_global_mouse_position()
	var best_tower: Node = null
	var best_distance: float = 999999.0
	for tower in tower_layer.get_children():
		if not is_instance_valid(tower) or not tower is Node2D:
			continue
		var tower_node: Node2D = tower
		var distance: float = tower_node.global_position.distance_to(mouse_world)
		var selection_radius: float = tower.get_selection_radius() if tower.has_method("get_selection_radius") else 36.0
		if distance <= selection_radius and distance < best_distance:
			best_distance = distance
			best_tower = tower
	if best_tower != null:
		_select_placed_tower(best_tower)
		GameState.is_commander_selected = false
		hud_instance.show_event(RunState.t("tower_selected"), Color(0.5, 0.9, 1.0))
		return true
	_clear_selected_placed_tower()
	return false

func _select_placed_tower(tower: Node) -> void:
	_clear_selected_placed_tower()
	GameState.selected_placed_tower = tower
	if tower != null and tower.has_method("set_selected"):
		tower.set_selected(true)

func _clear_selected_placed_tower() -> void:
	if GameState.selected_placed_tower != null and is_instance_valid(GameState.selected_placed_tower):
		if GameState.selected_placed_tower.has_method("set_selected"):
			GameState.selected_placed_tower.set_selected(false)
	GameState.selected_placed_tower = null

func _try_cycle_selected_tower_targeting(step: int = 1) -> void:
	var tower := GameState.selected_placed_tower
	if tower == null or not is_instance_valid(tower):
		return
	if not tower.has_method("cycle_targeting_mode"):
		return
	tower.cycle_targeting_mode(step)
	var target_mode_label: String = tower.get_targeting_mode_label() if tower.has_method("get_targeting_mode_label") else "Targeting"
	hud_instance.show_event(RunState.t("targeting_mode") % target_mode_label, Color(0.6, 0.9, 1.0), 0.9)

func _try_sell_selected_tower() -> void:
	var tower := GameState.selected_placed_tower
	if tower == null or not is_instance_valid(tower):
		return
	var refund: int = tower.get_sell_refund() if tower.has_method("get_sell_refund") else int(round(float(tower.tower_cost) * 0.5))
	RunState.gain_credits(refund)
	hud_instance.show_event(RunState.t("tower_sold") % refund, Color(0.6, 1.0, 0.8))
	_clear_selected_placed_tower()
	tower.queue_free()

func _try_select_commander_at_mouse() -> bool:
	if commander_instance == null or not is_instance_valid(commander_instance):
		return false
	var mouse_world: Vector2 = get_global_mouse_position()
	var distance: float = commander_instance.global_position.distance_to(mouse_world)
	if distance > 32.0:
		return false
	_clear_selected_placed_tower()
	GameState.selected_tower_id = ""
	_clear_preview()
	GameState.is_commander_selected = true
	hud_instance.show_event(RunState.t("commander_selected"), Color(0.6, 0.95, 0.75), 0.8)
	return true

func _update_boss_state() -> void:
	if hud_instance == null or not hud_instance.has_method("set_boss_state"):
		return
	if active_boss == null or not is_instance_valid(active_boss):
		hud_instance.set_boss_state(false)
		active_boss = null
		return
	var boss_name: String = active_boss.get_display_name() if active_boss.has_method("get_display_name") else String(active_boss.name)
	var boss_health_ratio: float = active_boss.get_health_ratio() if active_boss.has_method("get_health_ratio") else 1.0
	hud_instance.set_boss_state(true, boss_name, boss_health_ratio)

func _update_screen_shake(delta: float) -> void:
	if _screen_shake_time > 0.0:
		_screen_shake_time = maxf(0.0, _screen_shake_time - delta)
		var offset: Vector2 = Vector2(randf_range(-_screen_shake_strength, _screen_shake_strength), randf_range(-_screen_shake_strength, _screen_shake_strength))
		map_layer.position = offset
		tower_layer.position = offset
		enemy_layer.position = offset
		commander_layer.position = offset
	else:
		map_layer.position = Vector2.ZERO
		tower_layer.position = Vector2.ZERO
		enemy_layer.position = Vector2.ZERO
		commander_layer.position = Vector2.ZERO

func _start_screen_shake(duration: float, strength: float) -> void:
	_screen_shake_time = duration
	_screen_shake_strength = strength

func _update_hud_feedback() -> void:
	if hud_instance == null:
		return
	var placement_status: String = "Build off"
	var placement_color: Color = Color(0.7, 0.7, 0.7)
	if _has_selected_tower():
		var reason: String = map_instance.get_build_validation_reason(get_global_mouse_position(), tower_layer.get_children())
		if not RunState.can_afford(_get_selected_tower_cost()):
			reason = "not_enough_credits"
		placement_status = _format_build_reason(reason)
		placement_color = Color(0.5, 1.0, 0.6) if reason == "ready" else Color(1.0, 0.45, 0.45)
	elif GameState.selected_placed_tower != null and is_instance_valid(GameState.selected_placed_tower):
		var refund: int = GameState.selected_placed_tower.get_sell_refund() if GameState.selected_placed_tower.has_method("get_sell_refund") else int(round(float(GameState.selected_placed_tower.tower_cost) * 0.5))
		var targeting_label: String = GameState.selected_placed_tower.get_targeting_mode_label() if GameState.selected_placed_tower.has_method("get_targeting_mode_label") else "First"
		placement_status = RunState.t("selected_tower_status")
		placement_color = Color(0.5, 0.9, 1.0)
	elif GameState.is_commander_selected:
		placement_status = RunState.t("commander_selected_status")
		placement_color = Color(0.6, 0.95, 0.75)
	hud_instance.set_placement_status(placement_status, placement_color)
	hud_instance.set_commander_state(commander_instance)
	hud_instance.set_selected_build_mode(GameState.selected_tower_id)
	hud_instance.set_selected_tower(GameState.selected_placed_tower)
	hud_instance.set_pause_state(is_game_paused)
	hud_instance.set_wave_flow_state(auto_start_next_wave, waiting_for_manual_next_wave)
	if hud_instance.has_method("set_end_state"):
		if RunState.end_state == "victory":
			hud_instance.set_end_state("victory", (RunState.t("objective_target_wave") % RunState.target_wave) + " | " + RunState.difficulty_name, RunState.t("victory_hint"), true)
		elif RunState.end_state == "defeat":
			hud_instance.set_end_state("defeat", RunState.t("base_integrity_collapsed"), RunState.t("defeat_hint"), false)
		else:
			hud_instance.set_end_state("", "", "", false)

func _get_selected_tower_scene() -> PackedScene:
	var tower_def: Dictionary = TOWER_DEFS.get(GameState.selected_tower_id, {})
	var tower_scene: PackedScene = tower_def.get("scene", null)
	return tower_scene

func _get_selected_tower_cost() -> int:
	var tower_def: Dictionary = TOWER_DEFS.get(GameState.selected_tower_id, {})
	var tower_data: TowerData = tower_def.get("data", null)
	return tower_data.tower_cost if tower_data != null else 0

func _format_build_reason(reason: String) -> String:
	match reason:
		"ready":
			return RunState.t("ready")
		"out_of_bounds":
			return RunState.t("blocked_outside_build_zone")
		"path_blocked":
			return RunState.t("blocked_lane")
		"too_close_to_tower":
			return RunState.t("blocked_tower")
		"not_enough_credits":
			return RunState.t("blocked_credits")
		_:
			return RunState.t("blocked")

func _set_game_paused(paused: bool) -> void:
	is_game_paused = paused
	get_tree().paused = paused

func _on_settings_overlay_toggled(visible: bool) -> void:
	if visible:
		_pause_before_settings = get_tree().paused
		_set_game_paused(true)
	else:
		_set_game_paused(_pause_before_settings)

func _set_auto_next_wave(enabled: bool) -> void:
	auto_start_next_wave = enabled
	if enabled and waiting_for_manual_next_wave:
		_start_wave(current_wave_number)

func _start_next_wave_if_ready() -> void:
	if waiting_for_manual_next_wave:
		_start_wave(current_wave_number)

func _restart_run() -> void:
	get_tree().paused = false
	SceneRouter.goto_scene("res://scenes/bootstrap/game_root.tscn")

func _return_to_menu() -> void:
	get_tree().paused = false
	SceneRouter.goto_scene(MAIN_MENU_SCENE)

func _continue_in_free_mode() -> void:
	if RunState.end_state != "victory":
		return
	RunState.resume_free_mode()
	get_tree().paused = false
	hud_instance.show_banner(RunState.t("free_mode_banner"), Color(0.62, 1.0, 0.76), 2.0)
	hud_instance.show_event(RunState.t("free_mode_continue"), Color(0.72, 1.0, 0.78), 2.6)
	if auto_start_next_wave:
		_start_wave(current_wave_number)
	else:
		waiting_for_manual_next_wave = true
		hud_instance.show_event(RunState.t("free_mode_manual"), Color(0.72, 1.0, 0.78), 2.8)
