extends Node2D

@onready var path: Path2D = $EnemyPath
@onready var commander_spawn: Marker2D = $CommanderSpawn
@onready var build_area: Node2D = $BuildArea

var _lane_warning_timer: float = 0.0
var _lane_warning_position: Vector2 = Vector2.ZERO

const BUILD_RECT := Rect2(Vector2(120, 140), Vector2(1680, 760))
const PATH_BLOCK_RADIUS := 80.0
const PATH_POINTS := [
	Vector2(80, 260),
	Vector2(420, 260),
	Vector2(420, 620),
	Vector2(860, 620),
	Vector2(860, 300),
	Vector2(1400, 300),
	Vector2(1400, 760),
	Vector2(1840, 760),
]

func _ready() -> void:
	if path.curve == null:
		path.curve = Curve2D.new()
	if path.curve.point_count == 0:
		for point in PATH_POINTS:
			path.curve.add_point(point)

func _process(delta: float) -> void:
	if _lane_warning_timer <= 0.0:
		return
	_lane_warning_timer = maxf(0.0, _lane_warning_timer - delta)
	queue_redraw()

func get_enemy_curve() -> Curve2D:
	return path.curve

func get_commander_spawn_position() -> Vector2:
	return commander_spawn.global_position

func get_world_bounds() -> Rect2:
	return BUILD_RECT

func is_build_position_valid(world_pos: Vector2, towers: Array) -> bool:
	return get_build_validation_reason(world_pos, towers) == "ready"

func get_build_validation_reason(world_pos: Vector2, towers: Array) -> String:
	if not BUILD_RECT.has_point(world_pos):
		return "out_of_bounds"
	if _is_too_close_to_path(world_pos):
		return "path_blocked"
	for tower in towers:
		if not is_instance_valid(tower):
			continue
		if tower.global_position.distance_to(world_pos) < 96.0:
			return "too_close_to_tower"
	return "ready"

func _is_too_close_to_path(world_pos: Vector2) -> bool:
	var points := path.curve.get_baked_points()
	for point in points:
		if point.distance_to(world_pos) < PATH_BLOCK_RADIUS:
			return true
	return false

func trigger_lane_warning(world_position: Vector2, duration: float = 1.8) -> void:
	_lane_warning_position = world_position
	_lane_warning_timer = duration
	queue_redraw()

func _draw() -> void:
	if _lane_warning_timer <= 0.0:
		return
	var strength := minf(1.0, _lane_warning_timer / 1.8)
	var pulse := 0.5 + 0.5 * sin((1.8 - _lane_warning_timer) * 12.0)
	var core_color := Color(1.0, 0.34, 0.16, 0.18 + pulse * 0.12)
	var line_color := Color(1.0, 0.66, 0.24, 0.55 + pulse * 0.25)
	draw_circle(_lane_warning_position, 58.0 + pulse * 8.0, core_color)
	draw_arc(_lane_warning_position, 74.0 + pulse * 10.0, 0.0, TAU, 40, line_color, 5.0)
	draw_arc(_lane_warning_position, 96.0 + pulse * 14.0, 0.0, TAU, 48, Color(1.0, 0.44, 0.18, 0.25 * strength), 3.0)
	for offset in [Vector2(-56, 0), Vector2(56, 0), Vector2(0, -56), Vector2(0, 56)]:
		var dir := offset.normalized()
		var tip := _lane_warning_position + offset
		var side := dir.orthogonal() * 10.0
		draw_colored_polygon(PackedVector2Array([
			tip,
			tip - dir * 18.0 + side,
			tip - dir * 18.0 - side,
		]), line_color)
	draw_line(_lane_warning_position + Vector2(-10, -22), _lane_warning_position + Vector2(0, -4), Color(0.18, 0.08, 0.04, 0.95), 4.0)
	draw_circle(_lane_warning_position + Vector2(0, 10), 4.0, Color(0.18, 0.08, 0.04, 0.95))
