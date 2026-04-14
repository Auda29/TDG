extends Node2D

const MAP_SCENE := preload("res://scenes/maps/mvp_map.tscn")
const BASIC_TOWER_SCENE := preload("res://scenes/gameplay/towers/basic_tower.tscn")
const BASIC_ENEMY_SCENE := preload("res://scenes/gameplay/enemies/basic_enemy.tscn")
const BASIC_COMMANDER_SCENE := preload("res://scenes/gameplay/commander/basic_commander.tscn")
const WAVE_RUNNER_SCENE := preload("res://scenes/gameplay/wave/wave_runner.tscn")
const HUD_SCENE := preload("res://scenes/ui/mvp_hud.tscn")

@onready var map_layer: Node2D = $MapLayer
@onready var enemy_layer: Node2D = $EnemyLayer
@onready var tower_layer: Node2D = $TowerLayer
@onready var commander_layer: Node2D = $CommanderLayer
@onready var ui_layer: CanvasLayer = $UILayer

var map_instance: Node2D
var commander_instance: Node2D
var wave_runner: Node

func _ready() -> void:
	RunState.reset_for_new_run(300, 20)
	GameState.selected_tower_id = ""
	_setup_map()
	_setup_commander()
	_setup_hud()
	_setup_wave()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ability_1"):
		GameState.selected_tower_id = "basic_tower" if GameState.selected_tower_id == "" else ""
		return
	if event.is_action_pressed("command_secondary"):
		GameState.selected_tower_id = ""
		return
	if event.is_action_pressed("command_primary") and GameState.selected_tower_id == "basic_tower":
		_try_place_basic_tower()

func _setup_map() -> void:
	map_instance = MAP_SCENE.instantiate()
	map_layer.add_child(map_instance)

func _setup_commander() -> void:
	commander_instance = BASIC_COMMANDER_SCENE.instantiate()
	commander_layer.add_child(commander_instance)
	commander_instance.global_position = map_instance.get_commander_spawn_position()
	commander_instance.setup(map_instance.get_world_bounds())

func _setup_hud() -> void:
	var hud = HUD_SCENE.instantiate()
	ui_layer.add_child(hud)

func _setup_wave() -> void:
	wave_runner = WAVE_RUNNER_SCENE.instantiate()
	wave_runner.enemy_scene = BASIC_ENEMY_SCENE
	wave_runner.enemy_count = 10
	wave_runner.spawn_interval = 0.9
	wave_runner.wave_cleared.connect(_on_wave_cleared)
	add_child(wave_runner)
	wave_runner.start_wave(enemy_layer, map_instance.get_enemy_curve(), Callable(self, "_on_enemy_reached_goal"))

func _try_place_basic_tower() -> void:
	var tower = BASIC_TOWER_SCENE.instantiate()
	var mouse_world := get_global_mouse_position()
	var existing_towers: Array = tower_layer.get_children()
	if not map_instance.is_build_position_valid(mouse_world, existing_towers):
		tower.queue_free()
		return
	if not RunState.can_afford(tower.tower_cost):
		tower.queue_free()
		return
	RunState.spend_credits(tower.tower_cost)
	tower_layer.add_child(tower)
	tower.global_position = mouse_world

func _on_enemy_reached_goal(_enemy: Node) -> void:
	RunState.base_hp -= 1

func _on_wave_cleared() -> void:
	RunState.current_wave = 1
