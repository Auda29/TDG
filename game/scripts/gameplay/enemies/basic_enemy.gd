extends Node2D

signal defeated(enemy: Node)
signal reached_goal(enemy: Node)

@export var max_health: float = 30.0
@export var move_speed: float = 110.0
@export var fortress_damage: int = 1
@export var credit_reward: int = 15
@export var armor: float = 0.0
@export var is_elite: bool = false
@export var is_boss: bool = false
@export var turn_speed: float = 10.0

var health: float
var progress: float = 0.0
var curve: Curve2D
var _hit_flash: float = 0.0
var _impact_flash: float = 0.0
var _impact_local: Vector2 = Vector2.ZERO
var _threat_pulse: float = 0.0

func _ready() -> void:
	health = max_health
	add_to_group("enemies")

func setup(path_curve: Curve2D, speed_multiplier: float = 1.0, health_multiplier: float = 1.0) -> void:
	curve = path_curve
	move_speed *= speed_multiplier
	max_health *= health_multiplier
	health = max_health
	progress = 0.0
	_update_position(0.0)

func _process(delta: float) -> void:
	_hit_flash = maxf(0.0, _hit_flash - delta * 5.0)
	_impact_flash = maxf(0.0, _impact_flash - delta * 4.5)
	_threat_pulse += delta * 3.0
	if curve == null:
		return
	progress += move_speed * delta
	var length := curve.get_baked_length()
	if progress >= length:
		reached_goal.emit(self)
		queue_free()
		return
	_update_position(delta)
	queue_redraw()

func apply_damage(amount: float, source_global_position: Vector2 = Vector2.INF) -> float:
	var reduced_amount := maxf(1.0, amount - armor)
	var actual_damage: float = minf(reduced_amount, health)
	health -= reduced_amount
	_hit_flash = 1.35 if is_boss else 1.0
	_impact_flash = 1.25 if is_boss else 1.0
	var resolved_source := source_global_position if source_global_position != Vector2.INF else global_position
	_impact_local = to_local(resolved_source)
	queue_redraw()
	if health <= 0.0:
		defeated.emit(self)
		queue_free()
	return actual_damage

func _update_position(delta: float) -> void:
	var previous_position := global_position
	global_position = curve.sample_baked(progress)
	var move_direction := global_position - previous_position
	if move_direction.length_squared() > 0.001:
		var target_rotation := move_direction.angle()
		if delta <= 0.0:
			rotation = target_rotation
		else:
			rotation = lerp_angle(rotation, target_rotation, clampf(delta * turn_speed, 0.0, 1.0))

func _draw() -> void:
	if _impact_flash > 0.0:
		var impact_dir := _impact_local.normalized() if _impact_local.length() > 0.001 else Vector2.LEFT
		var impact_pos := impact_dir * (14.0 if is_boss else 10.0)
		var impact_radius := 18.0 if is_boss else 10.0
		draw_circle(impact_pos, impact_radius + (1.0 - _impact_flash) * (10.0 if is_boss else 6.0), Color(1.0, 0.62, 0.20, (0.22 if is_boss else 0.16) * _impact_flash))
		draw_arc(impact_pos, impact_radius + 8.0 + (1.0 - _impact_flash) * (12.0 if is_boss else 8.0), 0.0, TAU, 18, Color(1.0, 0.78, 0.30, (0.60 if is_boss else 0.45) * _impact_flash), 2.0)
	if _hit_flash > 0.0:
		draw_circle(Vector2.ZERO, 30.0 if is_boss else (18.0 if not is_elite else 24.0), Color(1.0, 0.6, 0.22, (0.22 if is_boss else 0.15) * _hit_flash))

	draw_set_transform(Vector2.ZERO, -rotation, Vector2.ONE)
	var health_ratio := clampf(health / maxf(1.0, max_health), 0.0, 1.0)
	var bar_width := 52.0 if is_boss else (38.0 if is_elite else 30.0)
	var bar_height := 8.0 if is_boss else (6.0 if is_elite else 5.0)
	var bar_pos := Vector2(-bar_width * 0.5, -42.0 if is_boss else (-34.0 if is_elite else -28.0))
	var bar_fill := Color(0.85, 0.2, 0.1, 0.92)
	if is_elite:
		bar_fill = Color(0.96, 0.36, 0.14, 0.95)
	if is_boss:
		bar_fill = Color(1.0, 0.82, 0.22, 0.96)
	draw_rect(Rect2(bar_pos, Vector2(bar_width, bar_height)), Color(0.06, 0.04, 0.04, 0.92), true)
	draw_rect(Rect2(bar_pos, Vector2(bar_width * health_ratio, bar_height)), bar_fill, true)
	if is_elite:
		var pulse := 0.5 + (sin(_threat_pulse) * 0.5)
		var marker_y := -54.0 if is_boss else -44.0
		var marker_color := Color(1.0, 0.84, 0.24, 0.85) if is_boss else Color(1.0, 0.48, 0.18, 0.75)
		draw_arc(Vector2(0, marker_y), (16.0 if is_boss else 12.0) + pulse * 2.0, PI * 1.05, PI * 1.95, 24, marker_color, 2.0)
		draw_line(Vector2(-14 if is_boss else -10, marker_y), Vector2(14 if is_boss else 10, marker_y), Color(1.0, 0.90, 0.42, 0.9) if is_boss else Color(1.0, 0.74, 0.32, 0.8), 2.0)
		if is_boss:
			draw_arc(Vector2(0, marker_y), 24.0 + pulse * 3.0, 0.0, TAU, 28, Color(1.0, 0.62, 0.16, 0.55), 2.0)
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)

func get_threat_label() -> String:
	if is_boss:
		return "Boss"
	return "Elite" if is_elite else "Swarm"

func get_health_ratio() -> float:
	return clampf(health / maxf(1.0, max_health), 0.0, 1.0)

func get_display_name() -> String:
	if is_boss:
		return "Siegebreaker"
	if is_elite:
		return "Shellback Brute"
	return "Scuttleborn"
