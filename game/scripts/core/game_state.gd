extends Node

var selected_tower_id: String = ""
var selected_placed_tower: Node = null
var selected_commander: Node = null
var is_commander_selected: bool = false

func clear_selection() -> void:
	selected_tower_id = ""
	selected_placed_tower = null
	is_commander_selected = false
