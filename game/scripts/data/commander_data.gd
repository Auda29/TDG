extends GameContentData
class_name CommanderData

@export var move_speed: float = 260.0
@export var attack_range: float = 130.0
@export var fire_rate: float = 1.5
@export var damage: float = 6.0
@export var max_health: float = 100.0
@export var overwatch_radius: float = 220.0
@export var overwatch_duration: float = 4.0
@export var overwatch_cooldown: float = 10.0
@export var overwatch_fire_rate_multiplier: float = 1.5
@export var turn_speed: float = 9.0
@export var ability_name: String = "Overwatch"
@export var ability_name_de: String = "Overwatch"
@export_multiline var ability_description: String = "Boosts nearby defenses for a short duration."
@export_multiline var ability_description_de: String = "Verstärkt nahe Verteidigungen für kurze Zeit."

func _init() -> void:
	category = "commander"

func get_localized_ability_name(language: String = "") -> String:
	var resolved_language := _resolve_language(language)
	if resolved_language == "de" and ability_name_de != "":
		return ability_name_de
	return ability_name

func get_localized_ability_description(language: String = "") -> String:
	var resolved_language := _resolve_language(language)
	if resolved_language == "de" and ability_description_de != "":
		return ability_description_de
	return ability_description

func get_gameplay_stats() -> Dictionary:
	var stats := super.get_gameplay_stats()
	stats.merge({
		"move_speed": move_speed,
		"attack_range": attack_range,
		"fire_rate": fire_rate,
		"damage": damage,
		"max_health": max_health,
		"overwatch_radius": overwatch_radius,
		"overwatch_duration": overwatch_duration,
		"overwatch_cooldown": overwatch_cooldown,
		"overwatch_fire_rate_multiplier": overwatch_fire_rate_multiplier,
		"turn_speed": turn_speed,
		"ability_name": get_localized_ability_name(),
		"ability_description": get_localized_ability_description(),
	}, true)
	return stats
