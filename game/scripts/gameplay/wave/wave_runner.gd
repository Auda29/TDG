extends Node

signal wave_cleared
signal enemy_defeated(credit_reward: int)
signal enemy_spawned(enemy: Node)

@export var enemy_scene: PackedScene
@export var enemy_count: int = 8
@export var spawn_interval: float = 0.8

var enemy_layer: Node
var path_curve: Curve2D
var fortress_callback: Callable
var spawn_queue: Array = []
var speed_scale: float = 1.0
var health_scale: float = 1.0
var spawned_count: int = 0
var active_count: int = 0
var _spawn_timer: float = 0.0
var _started: bool = false

func start_wave(target_enemy_layer: Node, target_curve: Curve2D, on_enemy_reached_goal: Callable) -> void:
	enemy_layer = target_enemy_layer
	path_curve = target_curve
	fortress_callback = on_enemy_reached_goal
	spawned_count = 0
	active_count = 0
	_spawn_timer = 0.0
	_started = true

func _process(delta: float) -> void:
	if not _started:
		return
	if spawned_count < enemy_count:
		_spawn_timer -= delta
		if _spawn_timer <= 0.0:
			_spawn_enemy()
			_spawn_timer = spawn_interval
	elif active_count <= 0:
		_started = false
		wave_cleared.emit()

func _spawn_enemy() -> void:
	var scene_to_spawn: PackedScene = _get_enemy_scene_for_index(spawned_count)
	if scene_to_spawn == null or enemy_layer == null or path_curve == null:
		return
	var enemy = scene_to_spawn.instantiate()
	enemy.setup(path_curve, speed_scale, health_scale)
	enemy.defeated.connect(_on_enemy_removed)
	enemy.reached_goal.connect(_on_enemy_reached_goal)
	enemy_layer.add_child(enemy)
	enemy_spawned.emit(enemy)
	spawned_count += 1
	active_count += 1

func _on_enemy_removed(enemy: Node) -> void:
	active_count = max(0, active_count - 1)
	if is_instance_valid(enemy):
		enemy_defeated.emit(enemy.credit_reward)

func _on_enemy_reached_goal(enemy: Node) -> void:
	active_count = max(0, active_count - 1)
	if fortress_callback.is_valid():
		fortress_callback.call(enemy)

func _get_enemy_scene_for_index(index: int) -> PackedScene:
	if index < spawn_queue.size():
		return spawn_queue[index]
	return enemy_scene
