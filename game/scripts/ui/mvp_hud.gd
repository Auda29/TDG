extends Control

signal build_tower_requested(tower_id: String)
signal sell_selected_requested

@onready var credits_label: Label = $TopPanel/VBoxContainer/CreditsLabel
@onready var wave_label: Label = $TopPanel/VBoxContainer/WaveLabel
@onready var base_label: Label = $TopPanel/VBoxContainer/BaseLabel
@onready var mode_label: Label = $TopPanel/VBoxContainer/ModeLabel
@onready var placement_label: Label = $TopPanel/VBoxContainer/PlacementLabel
@onready var commander_label: Label = $TopPanel/VBoxContainer/CommanderLabel
@onready var event_label: Label = $TopPanel/VBoxContainer/EventLabel
@onready var hint_label: Label = $TopPanel/VBoxContainer/HintLabel

@onready var basic_tower_button: Button = $Sidebar/SidebarMargin/SidebarVBox/BuildPanel/BuildVBox/BasicTowerButton
@onready var heavy_battery_button: Button = $Sidebar/SidebarMargin/SidebarVBox/BuildPanel/BuildVBox/HeavyBatteryButton
@onready var selected_title_label: Label = $Sidebar/SidebarMargin/SidebarVBox/SelectedPanel/SelectedVBox/SelectedTitleLabel
@onready var selected_stats_label: Label = $Sidebar/SidebarMargin/SidebarVBox/SelectedPanel/SelectedVBox/SelectedStatsLabel
@onready var sell_button: Button = $Sidebar/SidebarMargin/SidebarVBox/SelectedPanel/SelectedVBox/SellButton

var _placement_text: String = "Build off"
var _placement_color: Color = Color(0.7, 0.7, 0.7)
var _event_text: String = ""
var _event_color: Color = Color(1, 1, 1)
var _event_timer: float = 0.0
var _commander: Node = null
var _selected_tower: Node = null

func _ready() -> void:
	basic_tower_button.pressed.connect(func() -> void: build_tower_requested.emit("basic_tower"))
	heavy_battery_button.pressed.connect(func() -> void: build_tower_requested.emit("heavy_battery"))
	sell_button.pressed.connect(func() -> void: sell_selected_requested.emit())
	_update_selected_panel()

func _process(delta: float) -> void:
	credits_label.text = "Credits: %d" % RunState.credits
	wave_label.text = "Wave: %d" % RunState.current_wave
	base_label.text = "Base HP: %d" % RunState.base_hp
	mode_label.text = "Build Mode: %s" % _get_build_mode_text()
	placement_label.text = "Placement: %s" % _placement_text
	placement_label.modulate = _placement_color
	commander_label.text = _get_commander_text()
	event_label.text = _event_text
	event_label.modulate = _event_color
	hint_label.text = "Sidebar or 1/3 = build | LMB = place/select/move commander | RMB = cancel | X = sell | 2 = Overwatch"
	if _event_timer > 0.0:
		_event_timer = maxf(0.0, _event_timer - delta)
		if _event_timer <= 0.0:
			_event_text = ""
	_update_selected_panel()

func set_placement_status(text: String, color: Color) -> void:
	_placement_text = text
	_placement_color = color

func show_event(text: String, color: Color = Color(1, 1, 1), duration: float = 1.5) -> void:
	_event_text = text
	_event_color = color
	_event_timer = duration

func set_commander_state(commander: Node) -> void:
	_commander = commander

func set_selected_build_mode(tower_id: String) -> void:
	basic_tower_button.button_pressed = tower_id == "basic_tower"
	heavy_battery_button.button_pressed = tower_id == "heavy_battery"

func set_selected_tower(tower: Node) -> void:
	_selected_tower = tower
	_update_selected_panel()

func _get_commander_text() -> String:
	if _commander == null or not is_instance_valid(_commander):
		return "Commander: offline"
	if not _commander.has_method("get_overwatch_cooldown_remaining"):
		return "Commander: active"
	if _commander.has_method("is_overwatch_active") and _commander.is_overwatch_active():
		return "Commander: Overwatch ACTIVE %.1fs" % _commander.get_overwatch_remaining()
	if _commander.is_overwatch_ready():
		return "Commander: Overwatch READY"
	return "Commander: Overwatch %.1fs" % _commander.get_overwatch_cooldown_remaining()

func _get_build_mode_text() -> String:
	match GameState.selected_tower_id:
		"basic_tower":
			return "Basic Tower (100)"
		"heavy_battery":
			return "Heavy Battery (175)"
		_:
			return "Off"

func _update_selected_panel() -> void:
	if _selected_tower == null or not is_instance_valid(_selected_tower):
		selected_title_label.text = "Selected Tower"
		selected_stats_label.text = "No tower selected"
		sell_button.disabled = true
		return
	var tower_name: String = _selected_tower.get_ui_display_name() if _selected_tower.has_method("get_ui_display_name") else String(_selected_tower.name)
	var refund: int = _selected_tower.get_sell_refund() if _selected_tower.has_method("get_sell_refund") else 0
	selected_title_label.text = tower_name
	selected_stats_label.text = "DMG: %.1f\nRange: %.0f\nFire Rate: %.2f\nSell: +%d" % [
		_selected_tower.damage,
		_selected_tower.attack_range,
		_selected_tower.fire_rate,
		refund,
	]
	sell_button.disabled = false
