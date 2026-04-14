extends Node2D

@onready var path: Path2D = $EnemyPath
@onready var commander_spawn: Marker2D = $CommanderSpawn
@onready var build_area: Node2D = $BuildArea

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
