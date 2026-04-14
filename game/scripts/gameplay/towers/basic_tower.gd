extends Node2D

@export var tower_cost: int = 100
@export var attack_range: float = 180.0
@export var fire_rate: float = 1.2
@export var damage: float = 8.0

var _cooldown: float = 0.0
var _is_preview: bool = false
var _preview_is_valid: bool = true
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

func set_preview_valid(is_valid: bool) -> void:
	_preview_is_valid = is_valid
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
		var dealt_damage: float = target.apply_damage(damage, global_position)
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
	var decal_color := Color(0.10, 0.14, 0.16, 0.42)
	if name == "HeavyBattery":
		decal_color = Color(0.14, 0.12, 0.10, 0.48)
	draw_circle(Vector2.ZERO, 28.0 if name == "HeavyBattery" else 22.0, decal_color)
	draw_arc(Vector2.ZERO, 34.0 if name == "HeavyBattery" else 26.0, 0.0, TAU, 48, Color(0.34, 0.40, 0.44, 0.22), 2.0)
	for offset in [Vector2(-20, 0), Vector2(20, 0), Vector2(0, -20), Vector2(0, 20)]:
		var inner := offset * 0.65
		draw_line(inner, offset, Color(0.42, 0.46, 0.48, 0.25), 2.0)
	if _is_preview or _is_selected:
		var ring_color := Color(0.18, 0.26, 0.30, 0.10)
		if _is_preview:
			ring_color = Color(0.45, 0.82, 0.62, 0.16) if _preview_is_valid else Color(0.82, 0.28, 0.22, 0.18)
		elif overwatch_multiplier > 1.0:
			ring_color = Color(0.70, 0.52, 0.14, 0.14)
		draw_circle(Vector2.ZERO, attack_range, ring_color)
		if overwatch_multiplier > 1.0 and not _is_preview:
			draw_arc(Vector2.ZERO, attack_range, 0.0, TAU, 48, Color(0.8, 0.6, 0.1, 0.45), 2.0)
		var pad_color := Color(0.26, 0.42, 0.46, 0.50)
		if _is_preview:
			pad_color = Color(0.38, 0.74, 0.58, 0.55) if _preview_is_valid else Color(0.74, 0.26, 0.20, 0.58)
		draw_arc(Vector2.ZERO, 38.0 if name == "HeavyBattery" else 30.0, 0.0, TAU, 40, pad_color, 3.0)
		for angle in [0.0, PI * 0.5, PI, PI * 1.5]:
			var dir := Vector2.RIGHT.rotated(angle)
			draw_line(dir * 42.0, dir * 54.0, pad_color, 3.0)
	if _is_selected and not _is_preview:
		draw_arc(Vector2.ZERO, 32.0, 0.0, TAU, 40, Color(0.18, 0.74, 0.86, 0.72), 3.0)
	if _shot_flash > 0.0:
		var laser_color := Color(1.0, 0.9, 0.2, 0.9)
		var beam_core := Color(1.0, 0.97, 0.75, 0.95)
		var laser_width := 2.0
		var flash_size := 6.0
		var impact_radius := 8.0
		if name == "HeavyBattery":
			laser_color = Color(1.0, 0.4, 0.1, 0.95)
			beam_core = Color(1.0, 0.72, 0.32, 0.95)
			laser_width = 4.0
			flash_size = 12.0
			impact_radius = 14.0
		var shot_strength := clampf(_shot_flash, 0.0, 1.0)
		var muzzle_pos := Vector2(0, -20).rotated(barrel.rotation if barrel != null else 0.0)
		draw_line(muzzle_pos, _last_target_local, Color(laser_color.r, laser_color.g, laser_color.b, 0.22 * shot_strength), laser_width + 5.0)
		draw_line(muzzle_pos, _last_target_local, laser_color, laser_width)
		draw_line(muzzle_pos, _last_target_local, beam_core, maxf(1.0, laser_width * 0.4))
		draw_circle(muzzle_pos, flash_size, Color(beam_core.r, beam_core.g, beam_core.b, 0.85 * shot_strength))
		draw_circle(_last_target_local, impact_radius, Color(laser_color.r, laser_color.g, laser_color.b, 0.16 * shot_strength))
		draw_arc(_last_target_local, impact_radius + 6.0, 0.0, TAU, 24, Color(beam_core.r, beam_core.g, beam_core.b, 0.45 * shot_strength), 2.0)

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
