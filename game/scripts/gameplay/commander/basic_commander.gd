extends Node2D

signal overwatch_activated

@export var move_speed: float = 260.0
@export var attack_range: float = 130.0
@export var fire_rate: float = 1.5
@export var damage: float = 6.0
@export var max_health: float = 100.0
@export var overwatch_radius: float = 220.0
@export var overwatch_duration: float = 4.0
@export var overwatch_cooldown: float = 10.0
@export var overwatch_fire_rate_multiplier: float = 1.5

var _cooldown: float = 0.0
var _world_bounds: Rect2 = Rect2(Vector2.ZERO, Vector2(1920, 1080))
var _overwatch_remaining: float = 0.0
var _overwatch_cooldown_remaining: float = 0.0
var _shot_flash: float = 0.0
var _last_target_local: Vector2 = Vector2.ZERO
var _overwatch_pulse: float = 0.0
var _move_target: Vector2 = Vector2.ZERO
var _has_move_target: bool = false

@onready var body: Node2D = $Body
@onready var helmet: Node2D = $Helmet

func _ready() -> void:
	GameState.selected_commander = self

func setup(world_bounds: Rect2) -> void:
	_world_bounds = world_bounds
	_move_target = global_position
	_has_move_target = false

func _process(delta: float) -> void:
	_shot_flash = maxf(0.0, _shot_flash - delta * 4.0)
	_overwatch_pulse = maxf(0.0, _overwatch_pulse - delta * 2.5)
	_handle_movement(delta)
	_handle_attack(delta)
	_handle_overwatch(delta)
	queue_redraw()

func _handle_movement(delta: float) -> void:
	if not _has_move_target:
		return
	var to_target: Vector2 = _move_target - global_position
	if to_target.length() <= 6.0:
		_has_move_target = false
		return
	var direction := to_target.normalized()
	global_position += direction * move_speed * delta
	global_position.x = clampf(global_position.x, _world_bounds.position.x, _world_bounds.end.x)
	global_position.y = clampf(global_position.y, _world_bounds.position.y, _world_bounds.end.y)
	if _get_target() == null:
		rotation = direction.angle() + PI / 2.0

func _handle_attack(delta: float) -> void:
	_cooldown = maxf(0.0, _cooldown - delta)
	if _cooldown > 0.0:
		return
	var target := _get_target()
	if target == null:
		return
	_last_target_local = to_local(target.global_position)
	_shot_flash = 1.0
	rotation = _last_target_local.angle() + PI / 2.0
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
	var base_color := Color(0.2, 1.0, 0.4, 0.06)
	draw_circle(Vector2.ZERO, attack_range, base_color)
	if _shot_flash > 0.0:
		var muzzle_direction: Vector2 = _last_target_local.normalized() if _last_target_local.length() > 0.001 else Vector2.UP
		draw_line(Vector2.ZERO, _last_target_local, Color(0.3, 1.0, 0.5, 0.95), 3.0)
		draw_circle(muzzle_direction * 18.0, 7.0, Color(0.3, 1.0, 0.5, 0.85))
	if _overwatch_remaining > 0.0:
		var pulse_scale := 1.0 + (_overwatch_pulse * 0.12)
		draw_circle(Vector2.ZERO, overwatch_radius * pulse_scale, Color(1.0, 0.85, 0.2, 0.10))
		draw_arc(Vector2.ZERO, overwatch_radius, 0.0, TAU, 64, Color(1.0, 0.85, 0.2, 0.8), 4.0)
		draw_circle(Vector2.ZERO, 16.0, Color(1.0, 0.85, 0.2, 0.35))
		if body != null:
			body.modulate = Color(1.15, 1.05, 0.65, 1.0)
		if helmet != null:
			helmet.modulate = Color(1.2, 0.9, 0.25, 1.0)
	else:
		if body != null:
			body.modulate = Color(1, 1, 1, 1)
		if helmet != null:
			helmet.modulate = Color(1, 1, 1, 1)

func _handle_overwatch(delta: float) -> void:
	_overwatch_cooldown_remaining = maxf(0.0, _overwatch_cooldown_remaining - delta)
	_overwatch_remaining = maxf(0.0, _overwatch_remaining - delta)
	if Input.is_action_just_pressed("ability_2") and _overwatch_cooldown_remaining <= 0.0:
		_overwatch_remaining = overwatch_duration
		_overwatch_cooldown_remaining = overwatch_cooldown
		_overwatch_pulse = 1.0
		overwatch_activated.emit()

func get_overwatch_multiplier_for_position(world_position: Vector2) -> float:
	if _overwatch_remaining <= 0.0:
		return 1.0
	if global_position.distance_to(world_position) > overwatch_radius:
		return 1.0
	return overwatch_fire_rate_multiplier

func get_overwatch_cooldown_remaining() -> float:
	return _overwatch_cooldown_remaining

func is_overwatch_ready() -> bool:
	return _overwatch_cooldown_remaining <= 0.0

func is_overwatch_active() -> bool:
	return _overwatch_remaining > 0.0

func get_overwatch_remaining() -> float:
	return _overwatch_remaining

func set_move_target(world_position: Vector2) -> void:
	_move_target = Vector2(
		clampf(world_position.x, _world_bounds.position.x, _world_bounds.end.x),
		clampf(world_position.y, _world_bounds.position.y, _world_bounds.end.y)
	)
	_has_move_target = true
