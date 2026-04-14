extends Resource
class_name GameContentData

@export var content_id: String = ""
@export var category: String = "content"
@export var display_name: String = ""
@export var display_name_de: String = ""
@export_multiline var short_description: String = ""
@export_multiline var short_description_de: String = ""
@export_multiline var description: String = ""
@export_multiline var description_de: String = ""
@export var tags: PackedStringArray = []
@export var extra_stats: Dictionary = {}

func get_localized_display_name(language: String = "") -> String:
	var resolved_language := _resolve_language(language)
	if resolved_language == "de" and display_name_de != "":
		return display_name_de
	return display_name

func get_localized_short_description(language: String = "") -> String:
	var resolved_language := _resolve_language(language)
	if resolved_language == "de" and short_description_de != "":
		return short_description_de
	return short_description

func get_localized_description(language: String = "") -> String:
	var resolved_language := _resolve_language(language)
	if resolved_language == "de" and description_de != "":
		return description_de
	return description

func get_gameplay_stats() -> Dictionary:
	return extra_stats.duplicate(true)

func _resolve_language(language: String) -> String:
	if language != "":
		return language
	if Engine.has_singleton("RunState"):
		return RunState.menu_language
	return "en"
