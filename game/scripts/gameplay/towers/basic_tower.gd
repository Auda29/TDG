extends Node2D

@export var tower_cost: int = 100
@export var attack_range: float = 180.0
@export var fire_rate: float = 1.2
@export var damage: float = 8.0

var _cooldown: float = 0.0
var _is_preview: bool = false
var _shot_flash: float = 0.0
var _last_target_local: Vector2 = Vector2.ZERO
var _is_selected: bool = false
var total_damage_dealt: float = 0.0
var total_kills: int = 0
var active_time: float = 0.0

@onready var barrel: Node2D = $Barrel

func set_preview_mode(enabled: bool) -> void:
	_is_preview = enabled
	set_process(not enabled)
	queue_redraw()

func set_selected(enabled: bool) -> void:
	_is_selected = enabled
	queue_redraw()

func _process(delta: float) -> void:
	if _is_preview:
		_shot_flash = 0.0
		queue_redraw()
		return
	active_time += delta
	_shot_flash = maxf(0.0, _shot_flash - delta * 4.0)
	_cooldown = maxf(0.0, _cooldown - delta)
	if _cooldown > 0.0:
		queue_redraw()
		return
	var target := _get_target()
	if target != null:
		_last_target_local = to_local(target.global_position)
		_shot_flash = 1.0
		if barrel != null:
			barrel.rotation = _last_target_local.angle() + PI / 2.0
		var target_health_before: float = target.health
		var dealt_damage: float = target.apply_damage(damage)
		total_damage_dealt += dealt_damage
		if dealt_damage >= target_health_before and target_health_before > 0.0:
			total_kills += 1
		var effective_fire_rate := fire_rate * _get_overwatch_multiplier()
		_cooldown = 1.0 / maxf(0.1, effective_fire_rate)
	queue_redraw()

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
	var overwatch_multiplier := _get_overwatch_multiplier()
	if _is_preview or _is_selected:
		var ring_color := Color(0.3, 0.7, 1.0, 0.08)
		if _is_preview:
			ring_color = Color(0.8, 0.8, 1.0, 0.12)
		elif overwatch_multiplier > 1.0:
			ring_color = Color(1.0, 0.82, 0.25, 0.16)
		draw_circle(Vector2.ZERO, attack_range, ring_color)
		if overwatch_multiplier > 1.0 and not _is_preview:
			draw_arc(Vector2.ZERO, attack_range, 0.0, TAU, 48, Color(1.0, 0.82, 0.25, 0.75), 3.0)
	if _is_selected and not _is_preview:
		draw_arc(Vector2.ZERO, 32.0, 0.0, TAU, 40, Color(0.4, 1.0, 0.55, 0.95), 4.0)
	if _shot_flash > 0.0:
		draw_line(Vector2.ZERO, _last_target_local, Color(1.0, 0.9, 0.3, 0.9), 3.0)
		draw_circle(Vector2(0, -20), 8.0, Color(1.0, 0.75, 0.25, 0.8))

func _get_overwatch_multiplier() -> float:
	var commander = GameState.selected_commander
	if commander == null or not is_instance_valid(commander):
		return 1.0
	if not commander.has_method("get_overwatch_multiplier_for_position"):
		return 1.0
	return commander.get_overwatch_multiplier_for_position(global_position)

func get_ui_display_name() -> String:
	match name:
		"HeavyBattery":
			return "Heavy Battery"
		_:
			return "Basic Tower"

func get_sell_refund() -> int:
	return int(round(float(tower_cost) * 0.5))

func get_average_dps() -> float:
	if active_time <= 0.01:
		return 0.0
	return total_damage_dealt / active_time
