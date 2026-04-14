extends GameContentData
class_name EnemyData

@export var max_health: float = 30.0
@export var move_speed: float = 110.0
@export var fortress_damage: int = 1
@export var credit_reward: int = 15
@export var armor: float = 0.0
@export var is_elite: bool = false
@export var is_boss: bool = false
@export var turn_speed: float = 10.0

func _init() -> void:
	category = "enemy"

func get_gameplay_stats() -> Dictionary:
	var stats := super.get_gameplay_stats()
	stats.merge({
		"max_health": max_health,
		"move_speed": move_speed,
		"fortress_damage": fortress_damage,
		"credit_reward": credit_reward,
		"armor": armor,
		"is_elite": is_elite,
		"is_boss": is_boss,
		"turn_speed": turn_speed,
	}, true)
	return stats
