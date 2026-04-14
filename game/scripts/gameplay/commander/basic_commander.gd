extends Node2D

@export var move_speed: float = 260.0
@export var attack_range: float = 130.0
@export var fire_rate: float = 1.5
@export var damage: float = 6.0
@export var max_health: float = 100.0

var _cooldown: float = 0.0
var _world_bounds: Rect2 = Rect2(Vector2.ZERO, Vector2(1920, 1080))

func _ready() -> void:
	GameState.selected_commander = self

func setup(world_bounds: Rect2) -> void:
	_world_bounds = world_bounds

func _process(delta: float) -> void:
	_handle_movement(delta)
	_handle_attack(delta)
	queue_redraw()

func _handle_movement(delta: float) -> void:
	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_vector == Vector2.ZERO:
		return
	global_position += input_vector.normalized() * move_speed * delta
	global_position.x = clampf(global_position.x, _world_bounds.position.x, _world_bounds.end.x)
	global_position.y = clampf(global_position.y, _world_bounds.position.y, _world_bounds.end.y)

func _handle_attack(delta: float) -> void:
	_cooldown = maxf(0.0, _cooldown - delta)
	if _cooldown > 0.0:
		return
	var target := _get_target()
	if target == null:
		return
	target.apply_damage(damage)
	_cooldown = 1.0 / fire_rate

func _get_target() -> Node:
	var enemies := get_tree().get_nodes_in_group("enemies")
	var best_target: Node = null
	var best_distance := INF
	for enemy in enemies:
		if not is_instance_valid(enemy):
			continue
		var distance := global_position.distance_to(enemy.global_position)
		if distance <= attack_range and distance < best_distance:
			best_distance = distance
			best_target = enemy
	return best_target

func _draw() -> void:
	draw_circle(Vector2.ZERO, attack_range, Color(0.2, 1.0, 0.4, 0.06))
