extends Node2D

@export var tower_cost: int = 100
@export var attack_range: float = 180.0
@export var fire_rate: float = 1.2
@export var damage: float = 8.0

var _cooldown: float = 0.0

func _process(delta: float) -> void:
	_cooldown = maxf(0.0, _cooldown - delta)
	if _cooldown > 0.0:
		queue_redraw()
		return
	var target := _get_target()
	if target != null:
		target.apply_damage(damage)
		_cooldown = 1.0 / fire_rate
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
	draw_circle(Vector2.ZERO, attack_range, Color(0.3, 0.7, 1.0, 0.08))
