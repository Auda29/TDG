extends Node2D

const MAP_SCENE := preload("res://scenes/maps/mvp_map.tscn")
const BASIC_TOWER_SCENE := preload("res://scenes/gameplay/towers/basic_tower.tscn")
const HEAVY_BATTERY_SCENE := preload("res://scenes/gameplay/towers/heavy_battery.tscn")
const BASIC_ENEMY_SCENE := preload("res://scenes/gameplay/enemies/basic_enemy.tscn")
const SHELLBACK_BRUTE_SCENE := preload("res://scenes/gameplay/enemies/shellback_brute.tscn")
const BASIC_COMMANDER_SCENE := preload("res://scenes/gameplay/commander/basic_commander.tscn")
const WAVE_RUNNER_SCENE := preload("res://scenes/gameplay/wave/wave_runner.tscn")
const HUD_SCENE := preload("res://scenes/ui/mvp_hud.tscn")

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

func _ready() -> void:
	RunState.reset_for_new_run(300, 20)
	GameState.clear_selection()
	_setup_map()
	_setup_commander()
	_setup_hud()
	_setup_wave()

func _process(_delta: float) -> void:
	_handle_build_input()
	_update_tower_preview()
	_update_hud_feedback()

func _handle_build_input() -> void:
	if Input.is_action_just_pressed("ability_1"):
		_toggle_tower_selection("basic_tower")
		return
	if Input.is_action_just_pressed("ability_3"):
		_toggle_tower_selection("heavy_battery")
		return
	if Input.is_action_just_pressed("command_secondary"):
		GameState.clear_selection()
		_clear_preview()
		return
	if Input.is_action_just_pressed("command_primary") and _has_selected_tower():
		_try_place_selected_tower()

func _setup_map() -> void:
	map_instance = MAP_SCENE.instantiate()
	map_layer.add_child(map_instance)

func _setup_commander() -> void:
	commander_instance = BASIC_COMMANDER_SCENE.instantiate()
	commander_layer.add_child(commander_instance)
	commander_instance.global_position = map_instance.get_commander_spawn_position()
	commander_instance.setup(map_instance.get_world_bounds())

func _setup_hud() -> void:
	hud_instance = HUD_SCENE.instantiate()
	ui_layer.add_child(hud_instance)

func _setup_wave() -> void:
	wave_runner = WAVE_RUNNER_SCENE.instantiate()
	wave_runner.enemy_scene = BASIC_ENEMY_SCENE
	wave_runner.spawn_interval = 0.9
	wave_runner.wave_cleared.connect(_on_wave_cleared)
	wave_runner.enemy_defeated.connect(_on_enemy_defeated)
	add_child(wave_runner)
	_start_wave(current_wave_number)

func _toggle_tower_selection(tower_id: String) -> void:
	GameState.selected_tower_id = "" if GameState.selected_tower_id == tower_id else tower_id
	if GameState.selected_tower_id == "":
		_clear_preview()

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
		hud_instance.show_event("Not enough credits", Color(1.0, 0.4, 0.4))
		tower.queue_free()
		return
	RunState.spend_credits(tower_cost)
	tower_layer.add_child(tower)
	tower.global_position = mouse_world
	hud_instance.show_event("Tower placed", Color(0.5, 1.0, 0.6))

func _on_enemy_reached_goal(enemy: Node) -> void:
	RunState.base_hp -= enemy.fortress_damage
	hud_instance.show_event("Base hit -%d" % enemy.fortress_damage, Color(1.0, 0.5, 0.4))

func _on_enemy_defeated(credit_reward: int) -> void:
	RunState.gain_credits(credit_reward)
	hud_instance.show_event("+%d credits" % credit_reward, Color(0.6, 1.0, 0.6))

func _on_wave_cleared() -> void:
	var bonus: int = 75
	RunState.gain_credits(bonus)
	hud_instance.show_event("Wave cleared +%d" % bonus, Color(0.9, 0.9, 0.4))
	current_wave_number += 1
	await get_tree().create_timer(2.0).timeout
	_start_wave(current_wave_number)

func _start_wave(wave_number: int) -> void:
	RunState.current_wave = wave_number
	wave_runner.enemy_count = 8 + (wave_number * 2)
	wave_runner.spawn_interval = maxf(0.45, 0.9 - (wave_number - 1) * 0.05)
	wave_runner.spawn_queue = _build_spawn_queue(wave_number)
	wave_runner.start_wave(enemy_layer, map_instance.get_enemy_curve(), Callable(self, "_on_enemy_reached_goal"))

func _build_spawn_queue(wave_number: int) -> Array:
	var total_count: int = 8 + (wave_number * 2)
	var queue: Array = []
	for i in range(total_count):
		queue.append(BASIC_ENEMY_SCENE)
	if wave_number >= 2:
		queue[max(0, total_count - 2)] = SHELLBACK_BRUTE_SCENE
	if wave_number >= 3:
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
	tower_preview.modulate = Color(0.5, 1.0, 0.6, 0.75) if validation_reason == "ready" and affordable else Color(1.0, 0.35, 0.35, 0.75)

func _clear_preview() -> void:
	if tower_preview != null and is_instance_valid(tower_preview):
		tower_preview.queue_free()
	tower_preview = null

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
	hud_instance.set_placement_status(placement_status, placement_color)
	hud_instance.set_commander_state(commander_instance)

func _get_selected_tower_scene() -> PackedScene:
	match GameState.selected_tower_id:
		"basic_tower":
			return BASIC_TOWER_SCENE
		"heavy_battery":
			return HEAVY_BATTERY_SCENE
		_:
			return null

func _get_selected_tower_cost() -> int:
	match GameState.selected_tower_id:
		"basic_tower":
			return 100
		"heavy_battery":
			return 175
		_:
			return 0

func _format_build_reason(reason: String) -> String:
	match reason:
		"ready":
			return "Ready"
		"out_of_bounds":
			return "Blocked: outside build zone"
		"path_blocked":
			return "Blocked: too close to lane"
		"too_close_to_tower":
			return "Blocked: too close to tower"
		"not_enough_credits":
			return "Blocked: not enough credits"
		_:
			return "Blocked"
