extends Node2D

@export var tower_cost: int = 100
@export var attack_range: float = 180.0
@export var fire_rate: float = 1.2
@export var damage: float = 8.0

var _cooldown: float = 0.0
var _is_preview: bool = false

func set_preview_mode(enabled: bool) -> void:
	_is_preview = enabled
	set_process(not enabled)
	queue_redraw()

func _process(delta: float) -> void:
	_cooldown = maxf(0.0, _cooldown - delta)
	if _cooldown > 0.0:
		queue_redraw()
		return
	var target := _get_target()
	if target != null:
		target.apply_damage(damage)
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
	var ring_color := Color(0.3, 0.7, 1.0, 0.08)
	if _is_preview:
		ring_color = Color(0.8, 0.8, 1.0, 0.12)
	draw_circle(Vector2.ZERO, attack_range, ring_color)

func _get_overwatch_multiplier() -> float:
	var commander = GameState.selected_commander
	if commander == null or not is_instance_valid(commander):
		return 1.0
	if not commander.has_method("get_overwatch_multiplier_for_position"):
		return 1.0
	return commander.get_overwatch_multiplier_for_position(global_position)
