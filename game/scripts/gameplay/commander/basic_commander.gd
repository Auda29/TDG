extends Node2D

signal overwatch_activated

@export var commander_data: CommanderData
@export var move_speed: float = 260.0
@export var attack_range: float = 130.0
@export var fire_rate: float = 1.5
@export var damage: float = 6.0
@export var max_health: float = 100.0
@export var overwatch_radius: float = 220.0
@export var overwatch_duration: float = 4.0
@export var overwatch_cooldown: float = 10.0
@export var overwatch_fire_rate_multiplier: float = 1.5
@export var turn_speed: float = 9.0

var _cooldown: float = 0.0
var _world_bounds: Rect2 = Rect2(Vector2.ZERO, Vector2(1920, 1080))
var _overwatch_remaining: float = 0.0
var _overwatch_cooldown_remaining: float = 0.0
var _shot_flash: float = 0.0
var _last_target_local: Vector2 = Vector2.ZERO
var _overwatch_pulse: float = 0.0
var _move_target: Vector2 = Vector2.ZERO
var _has_move_target: bool = false
var _current_target: Node = null
var _step_bob: float = 0.0
var _body_kick: float = 0.0

@onready var body: Node2D = $Body
@onready var helmet: Node2D = $Helmet

func _ready() -> void:
	_apply_commander_data()
	GameState.selected_commander = self

func setup(world_bounds: Rect2) -> void:
	_world_bounds = world_bounds
	_move_target = global_position
	_has_move_target = false

func _process(delta: float) -> void:
	_shot_flash = maxf(0.0, _shot_flash - delta * 4.0)
	_body_kick = maxf(0.0, _body_kick - delta * 4.5)
	_overwatch_pulse = maxf(0.0, _overwatch_pulse - delta * 2.5)
	_handle_movement(delta)
	_handle_attack(delta)
	_animate_visuals(delta)
	_handle_overwatch(delta)
	queue_redraw()

func _handle_movement(delta: float) -> void:
	if not _has_move_target:
		return
	if _get_target() != null:
		return
	var to_target: Vector2 = _move_target - global_position
	if to_target.length() <= 6.0:
		_has_move_target = false
		return
	var direction: Vector2 = to_target.normalized()
	global_position += direction * move_speed * delta
	global_position.x = clampf(global_position.x, _world_bounds.position.x, _world_bounds.end.x)
	global_position.y = clampf(global_position.y, _world_bounds.position.y, _world_bounds.end.y)
	_step_bob += delta * 11.0
	var move_rotation: float = direction.angle() + PI / 2.0
	rotation = lerp_angle(rotation, move_rotation, clampf(delta * turn_speed, 0.0, 1.0))

func _handle_attack(delta: float) -> void:
	_cooldown = maxf(0.0, _cooldown - delta)
	if _cooldown > 0.0:
		return
	var target := _get_target()
	if target == null:
		return
	_last_target_local = to_local(target.global_position)
	_shot_flash = 1.0
	_body_kick = 1.0
	var aim_rotation: float = _last_target_local.angle() + PI / 2.0
	rotation = lerp_angle(rotation, aim_rotation, clampf(delta * (turn_speed + 3.0), 0.0, 1.0))
	target.apply_damage(damage, global_position)
	_cooldown = 1.0 / fire_rate

func _get_target() -> Node:
	if _current_target != null and is_instance_valid(_current_target):
		var current_distance: float = global_position.distance_to(_current_target.global_position)
		if current_distance <= attack_range:
			return _current_target
	var enemies := get_tree().get_nodes_in_group("enemies")
	var best_target: Node = null
	var best_progress: float = -1.0
	var best_distance: float = INF
	for enemy in enemies:
		if not is_instance_valid(enemy):
			continue
		var distance: float = global_position.distance_to(enemy.global_position)
		if distance > attack_range:
			continue
		var enemy_progress: float = float(enemy.get("progress"))
		if enemy_progress > best_progress or (is_equal_approx(enemy_progress, best_progress) and distance < best_distance):
			best_progress = enemy_progress
			best_distance = distance
			best_target = enemy
	_current_target = best_target
	return best_target

func _animate_visuals(delta: float) -> void:
	var bob_offset: float = sin(_step_bob) * 1.4
	if body != null:
		body.position = Vector2(0.0, bob_offset + _body_kick * 2.0)
		body.scale = Vector2.ONE * (1.0 + _shot_flash * 0.04)
	if helmet != null:
		helmet.position = Vector2(0.0, bob_offset * 1.2 + _body_kick * 3.0)
		helmet.scale = Vector2.ONE * (1.0 + _shot_flash * 0.05)
	if not _has_move_target and _current_target == null:
		_step_bob = lerpf(_step_bob, 0.0, clampf(delta * 3.0, 0.0, 1.0))

func _draw() -> void:
	var base_color := Color(0.16, 0.42, 0.36, 0.05)
	draw_circle(Vector2.ZERO, attack_range, base_color)
	draw_arc(Vector2.ZERO, 22.0, 0.0, TAU, 40, Color(0.16, 0.52, 0.56, 0.35), 2.0)
	if _shot_flash > 0.0:
		var muzzle_direction: Vector2 = _last_target_local.normalized() if _last_target_local.length() > 0.001 else Vector2.UP
		var muzzle_pos := muzzle_direction * 18.0
		draw_line(muzzle_pos, _last_target_local, Color(0.16, 1.0, 0.64, 0.22 * _shot_flash), 7.0)
		draw_line(muzzle_pos, _last_target_local, Color(0.3, 1.0, 0.5, 0.95), 3.0)
		draw_circle(muzzle_pos, 7.0, Color(0.3, 1.0, 0.5, 0.85))
		draw_arc(_last_target_local, 10.0, 0.0, TAU, 20, Color(0.45, 1.0, 0.72, 0.55 * _shot_flash), 2.0)
	if _overwatch_remaining > 0.0:
		var pulse_scale := 1.0 + (_overwatch_pulse * 0.12)
		draw_circle(Vector2.ZERO, overwatch_radius * pulse_scale, Color(1.0, 0.85, 0.2, 0.08))
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

func get_display_name() -> String:
	if commander_data != null:
		return commander_data.get_localized_display_name()
	return name

func get_content_summary() -> String:
	if commander_data != null:
		return commander_data.get_localized_short_description()
	return ""

func get_content_description() -> String:
	if commander_data != null:
		return commander_data.get_localized_description()
	return ""

func get_gameplay_stats() -> Dictionary:
	if commander_data != null:
		return commander_data.get_gameplay_stats()
	return {
		"move_speed": move_speed,
		"attack_range": attack_range,
		"fire_rate": fire_rate,
		"damage": damage,
		"max_health": max_health,
	}

func _apply_commander_data() -> void:
	if commander_data == null:
		return
	move_speed = commander_data.move_speed
	attack_range = commander_data.attack_range
	fire_rate = commander_data.fire_rate
	damage = commander_data.damage
	max_health = commander_data.max_health
	overwatch_radius = commander_data.overwatch_radius
	overwatch_duration = commander_data.overwatch_duration
	overwatch_cooldown = commander_data.overwatch_cooldown
	overwatch_fire_rate_multiplier = commander_data.overwatch_fire_rate_multiplier
	turn_speed = commander_data.turn_speed
