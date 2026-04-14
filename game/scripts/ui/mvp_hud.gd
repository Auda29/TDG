extends Control

@onready var credits_label: Label = $Panel/VBoxContainer/CreditsLabel
@onready var wave_label: Label = $Panel/VBoxContainer/WaveLabel
@onready var base_label: Label = $Panel/VBoxContainer/BaseLabel
@onready var mode_label: Label = $Panel/VBoxContainer/ModeLabel
@onready var placement_label: Label = $Panel/VBoxContainer/PlacementLabel
@onready var commander_label: Label = $Panel/VBoxContainer/CommanderLabel
@onready var event_label: Label = $Panel/VBoxContainer/EventLabel
@onready var hint_label: Label = $Panel/VBoxContainer/HintLabel

var _placement_text: String = "Build off"
var _placement_color: Color = Color(0.7, 0.7, 0.7)
var _event_text: String = ""
var _event_color: Color = Color(1, 1, 1)
var _event_timer: float = 0.0
var _commander: Node = null

func _process(delta: float) -> void:
	credits_label.text = "Credits: %d" % RunState.credits
	wave_label.text = "Wave: %d" % RunState.current_wave
	base_label.text = "Base HP: %d" % RunState.base_hp
	mode_label.text = "Build Mode: %s" % ("Basic Tower (100)" if GameState.selected_tower_id != "" else "Off")
	placement_label.text = "Placement: %s" % _placement_text
	placement_label.modulate = _placement_color
	commander_label.text = _get_commander_text()
	event_label.text = _event_text
	event_label.modulate = _event_color
	hint_label.text = "1 = arm tower | Left Click = place | Right Click = cancel | 2 = Overwatch | WASD = commander"
	if _event_timer > 0.0:
		_event_timer = maxf(0.0, _event_timer - delta)
		if _event_timer <= 0.0:
			_event_text = ""

func set_placement_status(text: String, color: Color) -> void:
	_placement_text = text
	_placement_color = color

func show_event(text: String, color: Color = Color(1, 1, 1), duration: float = 1.5) -> void:
	_event_text = text
	_event_color = color
	_event_timer = duration

func set_commander_state(commander: Node) -> void:
	_commander = commander

func _get_commander_text() -> String:
	if _commander == null or not is_instance_valid(_commander):
		return "Commander: offline"
	if not _commander.has_method("get_overwatch_cooldown_remaining"):
		return "Commander: active"
	if _commander.is_overwatch_ready():
		return "Commander: Overwatch READY"
	return "Commander: Overwatch %.1fs" % _commander.get_overwatch_cooldown_remaining()
