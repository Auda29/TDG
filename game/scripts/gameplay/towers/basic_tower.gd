extends Node2D

@export var tower_data: TowerData
@export var tower_cost: int = 100
@export var attack_range: float = 180.0
@export var fire_rate: float = 1.2
@export var damage: float = 8.0
@export var turn_speed: float = 10.0

const TARGETING_MODES := ["first", "closest", "strongest", "last", "boss_focus"]
const TARGETING_LABELS := {
	"first": "First",
	"closest": "Closest",
	"strongest": "Strongest",
	"last": "Last",
	"boss_focus": "Boss-Focus",
}

var _cooldown: float = 0.0
var _is_preview: bool = false
var _preview_is_valid: bool = true
var _shot_flash: float = 0.0
var _last_target_local: Vector2 = Vector2.ZERO
var _is_selected: bool = false
var _targeting_mode: String = "first"
var _barrel_recoil: float = 0.0
var _idle_sway: float = 0.0
var total_damage_dealt: float = 0.0
var total_kills: int = 0
var active_time: float = 0.0

@onready var barrel: Node2D = $Barrel
@onready var base: Node2D = get_node_or_null("Base")
@onready var base_top: Node2D = get_node_or_null("BaseTop")
@onready var base_inner: Node2D = get_node_or_null("BaseInner")

func _ready() -> void:
	_apply_tower_data()
	_animate_visuals()

func _apply_tower_data() -> void:
	if tower_data == null:
		return
	tower_cost = tower_data.tower_cost
	attack_range = tower_data.attack_range
	fire_rate = tower_data.fire_rate
	damage = tower_data.damage
	turn_speed = tower_data.turn_speed

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
	var sway_speed: float = tower_data.sway_speed if tower_data != null else 2.8
	_idle_sway += delta * sway_speed
	_shot_flash = maxf(0.0, _shot_flash - delta * 4.0)
	var recoil_recover_speed: float = 2.8 if tower_data != null and tower_data.recoil_distance >= 10.0 else 5.0
	_barrel_recoil = maxf(0.0, _barrel_recoil - delta * recoil_recover_speed)
	_cooldown = maxf(0.0, _cooldown - delta)
	var target := _get_target()
	if target != null:
		_last_target_local = to_local(target.global_position)
		if barrel != null:
			var target_rotation: float = _last_target_local.angle() + PI / 2.0
			barrel.rotation = lerp_angle(barrel.rotation, target_rotation, clampf(delta * turn_speed, 0.0, 1.0))
	if _cooldown <= 0.0 and target != null:
		_shot_flash = 1.0
		_barrel_recoil = 1.0
		var target_health_before: float = target.health
		var dealt_damage: float = target.apply_damage(damage, global_position)
		total_damage_dealt += dealt_damage
		if dealt_damage >= target_health_before and target_health_before > 0.0:
			total_kills += 1
		var effective_fire_rate := fire_rate * _get_overwatch_multiplier()
		_cooldown = 1.0 / maxf(0.1, effective_fire_rate)
	_animate_visuals()
	queue_redraw()

func _get_target() -> Node:
	var enemies := get_tree().get_nodes_in_group("enemies")
	var best_target: Node = null
	var best_score: float = -INF
	for enemy in enemies:
		if not is_instance_valid(enemy):
			continue
		var distance: float = global_position.distance_to(enemy.global_position)
		if distance > attack_range:
			continue
		var score: float = _get_target_score(enemy, distance)
		if score > best_score:
			best_score = score
			best_target = enemy
	return best_target

func _get_target_score(enemy: Node, distance: float) -> float:
	var progress: float = float(enemy.get("progress")) if enemy.get("progress") != null else 0.0
	var max_health_value: float = float(enemy.get("max_health")) if enemy.get("max_health") != null else 0.0
	var is_boss_target: bool = bool(enemy.get("is_boss")) if enemy.get("is_boss") != null else false
	match _targeting_mode:
		"closest":
			return -distance + progress * 0.001
		"strongest":
			return max_health_value * 1000.0 + progress - distance * 0.01
		"last":
			return -progress * 1000.0 - distance
		"boss_focus":
			return (1000000.0 if is_boss_target else 0.0) + max_health_value * 10.0 + progress - distance * 0.01
		_:
			return progress * 1000.0 - distance

func _animate_visuals() -> void:
	var sway_amount: float = tower_data.sway_amount if tower_data != null else 1.2
	var recoil_distance: float = tower_data.recoil_distance if tower_data != null else 6.0
	var sway_offset := sin(_idle_sway) * sway_amount
	if barrel != null:
		barrel.position = Vector2(0.0, _barrel_recoil * recoil_distance + sway_offset)
	if base_top != null:
		base_top.position = Vector2(0.0, sin(_idle_sway * 0.8) * 0.8)
		base_top.scale = Vector2.ONE * (1.0 + _shot_flash * 0.03)
	if base_inner != null:
		base_inner.position = Vector2(0.0, sin(_idle_sway * 0.7) * 0.6)
		base_inner.scale = Vector2.ONE * (1.0 + _shot_flash * 0.02)
	if base != null:
		base.scale = Vector2.ONE * (1.0 + _shot_flash * 0.015)

func _draw() -> void:
	var overwatch_multiplier := _get_overwatch_multiplier()
	var selection_radius: float = tower_data.selection_radius if tower_data != null else 30.0
	var decal_color: Color = tower_data.decal_fill_color if tower_data != null else Color(0.10, 0.14, 0.16, 0.42)
	var decal_arc_color: Color = tower_data.decal_arc_color if tower_data != null else Color(0.34, 0.40, 0.44, 0.22)
	draw_circle(Vector2.ZERO, maxf(18.0, selection_radius - 8.0), decal_color)
	draw_arc(Vector2.ZERO, selection_radius - 4.0, 0.0, TAU, 48, decal_arc_color, 2.0)
	for offset: Vector2 in [Vector2(-20, 0), Vector2(20, 0), Vector2(0, -20), Vector2(0, 20)]:
		var inner: Vector2 = offset * 0.65
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
		draw_arc(Vector2.ZERO, selection_radius, 0.0, TAU, 40, pad_color, 3.0)
		for angle: float in [0.0, PI * 0.5, PI, PI * 1.5]:
			var dir: Vector2 = Vector2.RIGHT.rotated(angle)
			draw_line(dir * 42.0, dir * 54.0, pad_color, 3.0)
	if _is_selected and not _is_preview:
		draw_arc(Vector2.ZERO, 32.0, 0.0, TAU, 40, Color(0.18, 0.74, 0.86, 0.72), 3.0)
	if _shot_flash > 0.0:
		var laser_color: Color = tower_data.laser_color if tower_data != null else Color(1.0, 0.9, 0.2, 0.9)
		var beam_core: Color = tower_data.beam_core_color if tower_data != null else Color(1.0, 0.97, 0.75, 0.95)
		var laser_width: float = tower_data.laser_width if tower_data != null else 2.0
		var flash_size: float = tower_data.flash_size if tower_data != null else 6.0
		var impact_radius: float = tower_data.impact_radius if tower_data != null else 8.0
		var shot_strength := clampf(_shot_flash, 0.0, 1.0)
		var muzzle_offset: Vector2 = tower_data.muzzle_offset if tower_data != null else Vector2(0.0, -20.0)
		var muzzle_pos := muzzle_offset.rotated(barrel.rotation if barrel != null else 0.0)
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

func cycle_targeting_mode(step: int = 1) -> void:
	var current_index: int = TARGETING_MODES.find(_targeting_mode)
	if current_index < 0:
		current_index = 0
	_targeting_mode = TARGETING_MODES[posmod(current_index + step, TARGETING_MODES.size())]
	queue_redraw()

func get_targeting_mode_label() -> String:
	return TARGETING_LABELS.get(_targeting_mode, "First")

func get_ui_display_name() -> String:
	if tower_data != null:
		return tower_data.get_localized_display_name()
	return "Turm" if RunState.menu_language == "de" else "Tower"

func get_content_summary() -> String:
	if tower_data != null:
		return tower_data.get_localized_short_description()
	return ""

func get_content_description() -> String:
	if tower_data != null:
		return tower_data.get_localized_description()
	return ""

func get_gameplay_stats() -> Dictionary:
	if tower_data != null:
		return tower_data.get_gameplay_stats()
	return {
		"tower_cost": tower_cost,
		"attack_range": attack_range,
		"fire_rate": fire_rate,
		"damage": damage,
	}

func get_selection_radius() -> float:
	return tower_data.selection_radius if tower_data != null else 30.0

func get_sell_refund() -> int:
	return int(round(float(tower_cost) * 0.5))

func get_average_dps() -> float:
	if active_time <= 0.01:
		return 0.0
	return total_damage_dealt / active_time
