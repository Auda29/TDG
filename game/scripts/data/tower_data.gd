extends GameContentData
class_name TowerData

@export var tower_id: String = ""
@export var tower_cost: int = 100
@export var attack_range: float = 180.0
@export var fire_rate: float = 1.0
@export var damage: float = 8.0
@export var turn_speed: float = 10.0
@export var recoil_distance: float = 6.0
@export var sway_speed: float = 2.8
@export var sway_amount: float = 1.2
@export var muzzle_offset: Vector2 = Vector2(0.0, -20.0)
@export var selection_radius: float = 30.0
@export var decal_fill_color: Color = Color(0.10, 0.14, 0.16, 0.42)
@export var decal_arc_color: Color = Color(0.34, 0.40, 0.44, 0.22)
@export var laser_color: Color = Color(1.0, 0.9, 0.2, 0.9)
@export var beam_core_color: Color = Color(1.0, 0.97, 0.75, 0.95)
@export var laser_width: float = 2.0
@export var flash_size: float = 6.0
@export var impact_radius: float = 8.0

func _init() -> void:
	category = "tower"

func get_localized_display_name(language: String = "") -> String:
	return super.get_localized_display_name(language)

func get_gameplay_stats() -> Dictionary:
	var stats := super.get_gameplay_stats()
	stats.merge({
		"tower_cost": tower_cost,
		"attack_range": attack_range,
		"fire_rate": fire_rate,
		"damage": damage,
		"turn_speed": turn_speed,
		"selection_radius": selection_radius,
	}, true)
	return stats
