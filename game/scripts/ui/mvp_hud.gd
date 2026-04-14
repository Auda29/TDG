extends Control

signal build_tower_requested(tower_id: String)
signal sell_selected_requested
signal cycle_targeting_previous_requested
signal cycle_targeting_next_requested
signal pause_toggled(paused: bool)
signal auto_wave_toggled(enabled: bool)
signal next_wave_requested
signal restart_requested
signal menu_requested
signal continue_free_mode_requested
signal settings_requested

const UI_COLOR_DEFENDER := Color(0.36, 0.88, 0.96)
const UI_COLOR_DEFENDER_SOFT := Color(0.58, 0.90, 0.96)
const UI_COLOR_CARRION := Color(0.88, 0.26, 0.16)
const UI_COLOR_CARRION_SOFT := Color(0.96, 0.62, 0.28)
const UI_COLOR_NEUTRAL := Color(0.76, 0.80, 0.82)
const UI_COLOR_WARNING := Color(0.96, 0.72, 0.24)
const UI_COLOR_SUCCESS := Color(0.46, 0.92, 0.68)
const BASIC_TOWER_DATA = preload("res://data/towers/basic_tower.tres")
const HEAVY_BATTERY_DATA = preload("res://data/towers/heavy_battery.tres")

const TOWER_DISPLAY_DATA := {
	"basic_tower": BASIC_TOWER_DATA,
	"heavy_battery": HEAVY_BATTERY_DATA,
}

const TARGET_ICONS := {
	"First": "➤",
	"Closest": "◎",
	"Strongest": "✦",
	"Last": "◁",
	"Boss-Focus": "☠",
}

@onready var damage_flash: ColorRect = $DamageFlash
@onready var game_over_overlay: Control = $GameOverOverlay
@onready var game_over_panel: PanelContainer = $GameOverOverlay/GameOverCenter/GameOverPanel
@onready var game_over_glow: ColorRect = $GameOverOverlay/GameOverCenter/GameOverPanel/GameOverGlow
@onready var game_over_frame_top: ColorRect = $GameOverOverlay/GameOverCenter/GameOverPanel/GameOverFrameTop
@onready var game_over_frame_bottom: ColorRect = $GameOverOverlay/GameOverCenter/GameOverPanel/GameOverFrameBottom
@onready var game_over_side_left: ColorRect = $GameOverOverlay/GameOverCenter/GameOverPanel/GameOverSideLeft
@onready var game_over_side_right: ColorRect = $GameOverOverlay/GameOverCenter/GameOverPanel/GameOverSideRight
@onready var game_over_title_label: Label = $GameOverOverlay/GameOverCenter/GameOverPanel/GameOverMargin/GameOverVBox/GameOverTitleLabel
@onready var game_over_status_label: Label = $GameOverOverlay/GameOverCenter/GameOverPanel/GameOverMargin/GameOverVBox/GameOverStatusLabel
@onready var game_over_stats_label: Label = $GameOverOverlay/GameOverCenter/GameOverPanel/GameOverMargin/GameOverVBox/GameOverStatsLabel
@onready var game_over_hint_label: Label = $GameOverOverlay/GameOverCenter/GameOverPanel/GameOverMargin/GameOverVBox/GameOverHintLabel
@onready var game_over_restart_button: Button = $GameOverOverlay/GameOverCenter/GameOverPanel/GameOverMargin/GameOverVBox/GameOverActionRow/GameOverRestartButton
@onready var game_over_menu_button: Button = $GameOverOverlay/GameOverCenter/GameOverPanel/GameOverMargin/GameOverVBox/GameOverActionRow/GameOverMenuButton
@onready var game_over_continue_button: Button = $GameOverOverlay/GameOverCenter/GameOverPanel/GameOverMargin/GameOverVBox/GameOverActionRow/GameOverContinueButton
@onready var banner_label: Label = $TopBanner/BannerLabel
@onready var boss_bar: MarginContainer = $BossBar
@onready var boss_name_label: Label = $BossBar/BossBarPanel/BossBarVBox/BossNameLabel
@onready var boss_health_bar: ProgressBar = $BossBar/BossBarPanel/BossBarVBox/BossHealthBar
@onready var bottom_bar: PanelContainer = $BottomBar
@onready var status_panel: PanelContainer = $BottomBar/Margin/RootHBox/StatusPanel
@onready var center_panel: PanelContainer = $BottomBar/Margin/RootHBox/CenterPanel
@onready var selected_panel: PanelContainer = $SelectedPanel
@onready var frame_top: ColorRect = $SelectedPanel/FrameTop
@onready var frame_bottom: ColorRect = $SelectedPanel/FrameBottom
@onready var corner_tl: ColorRect = $SelectedPanel/CornerTL
@onready var corner_br: ColorRect = $SelectedPanel/CornerBR
@onready var credits_label: Label = $BottomBar/Margin/RootHBox/StatusPanel/StatusMargin/StatusVBox/StatsGrid/CreditsLabel
@onready var wave_label: Label = $BottomBar/Margin/RootHBox/StatusPanel/StatusMargin/StatusVBox/StatsGrid/WaveLabel
@onready var base_label: Label = $BottomBar/Margin/RootHBox/StatusPanel/StatusMargin/StatusVBox/StatsGrid/BaseLabel
@onready var mode_label: Label = $BottomBar/Margin/RootHBox/StatusPanel/StatusMargin/StatusVBox/StatsGrid/ModeLabel
@onready var placement_label: Label = $BottomBar/Margin/RootHBox/StatusPanel/StatusMargin/StatusVBox/StatsGrid/PlacementLabel
@onready var commander_label: Label = $BottomBar/Margin/RootHBox/StatusPanel/StatusMargin/StatusVBox/StatsGrid/CommanderLabel
@onready var event_label: Label = $BottomBar/Margin/RootHBox/StatusPanel/StatusMargin/StatusVBox/EventLabel
@onready var threat_label: Label = $BottomBar/Margin/RootHBox/StatusPanel/StatusMargin/StatusVBox/ThreatLabel
@onready var hint_label: Label = $BottomBar/Margin/RootHBox/StatusPanel/StatusMargin/StatusVBox/HintLabel

@onready var basic_tower_button: Button = $BottomBar/Margin/RootHBox/CenterPanel/CenterMargin/CenterHBox/BuildPanel/BasicTowerButton
@onready var heavy_battery_button: Button = $BottomBar/Margin/RootHBox/CenterPanel/CenterMargin/CenterHBox/BuildPanel/HeavyBatteryButton
@onready var pause_button: Button = $BottomBar/Margin/RootHBox/CenterPanel/CenterMargin/CenterHBox/FlowPanel/PauseButton
@onready var auto_wave_button: CheckButton = $BottomBar/Margin/RootHBox/CenterPanel/CenterMargin/CenterHBox/FlowPanel/AutoWaveButton
@onready var next_wave_button: Button = $BottomBar/Margin/RootHBox/CenterPanel/CenterMargin/CenterHBox/FlowPanel/NextWaveButton
@onready var settings_button: Button = $BottomBar/Margin/RootHBox/CenterPanel/CenterMargin/CenterHBox/FlowPanel/SettingsButton
@onready var header_panel: PanelContainer = $SelectedPanel/SelectedMargin/SelectedVBox/HeaderPanel
@onready var header_divider: ColorRect = $SelectedPanel/SelectedMargin/SelectedVBox/HeaderDivider
@onready var silhouette_panel: PanelContainer = $SelectedPanel/SelectedMargin/SelectedVBox/HeaderPanel/HeaderMargin/HeaderHBox/SilhouettePanel
@onready var silhouette_label: Label = $SelectedPanel/SelectedMargin/SelectedVBox/HeaderPanel/HeaderMargin/HeaderHBox/SilhouettePanel/SilhouetteLabel
@onready var selected_title_label: Label = $SelectedPanel/SelectedMargin/SelectedVBox/HeaderPanel/HeaderMargin/HeaderHBox/HeaderTextVBox/SelectedTitleLabel
@onready var selected_subtitle_label: Label = $SelectedPanel/SelectedMargin/SelectedVBox/HeaderPanel/HeaderMargin/HeaderHBox/HeaderTextVBox/SelectedSubtitleLabel
@onready var stats_panel: PanelContainer = $SelectedPanel/SelectedMargin/SelectedVBox/StatsPanel
@onready var stats_divider: ColorRect = $SelectedPanel/SelectedMargin/SelectedVBox/StatsDivider
@onready var selected_stats_label: Label = $SelectedPanel/SelectedMargin/SelectedVBox/StatsPanel/StatsMargin/SelectedStatsLabel
@onready var actions_panel: PanelContainer = $SelectedPanel/SelectedMargin/SelectedVBox/ActionsPanel
@onready var actions_divider: ColorRect = $SelectedPanel/SelectedMargin/SelectedVBox/ActionsDivider
@onready var target_prev_button: Button = $SelectedPanel/SelectedMargin/SelectedVBox/ActionsPanel/ActionsMargin/ActionsVBox/TargetingRow/TargetPrevButton
@onready var target_mode_label: Label = $SelectedPanel/SelectedMargin/SelectedVBox/ActionsPanel/ActionsMargin/ActionsVBox/TargetingRow/TargetModeLabel
@onready var target_next_button: Button = $SelectedPanel/SelectedMargin/SelectedVBox/ActionsPanel/ActionsMargin/ActionsVBox/TargetingRow/TargetNextButton
@onready var sell_button: Button = $SelectedPanel/SelectedMargin/SelectedVBox/ActionsPanel/ActionsMargin/ActionsVBox/SellButton
@onready var upgrades_panel: PanelContainer = $SelectedPanel/SelectedMargin/SelectedVBox/UpgradesPanel
@onready var upgrade_slot_a: Button = $SelectedPanel/SelectedMargin/SelectedVBox/UpgradesPanel/UpgradesMargin/UpgradesVBox/UpgradeSlots/UpgradeSlotA
@onready var upgrade_slot_b: Button = $SelectedPanel/SelectedMargin/SelectedVBox/UpgradesPanel/UpgradesMargin/UpgradesVBox/UpgradeSlots/UpgradeSlotB
@onready var upgrade_slot_c: Button = $SelectedPanel/SelectedMargin/SelectedVBox/UpgradesPanel/UpgradesMargin/UpgradesVBox/UpgradeSlots/UpgradeSlotC
@onready var upgrade_slot_d: Button = $SelectedPanel/SelectedMargin/SelectedVBox/UpgradesPanel/UpgradesMargin/UpgradesVBox/UpgradeSlots/UpgradeSlotD

var _placement_text: String = "Build off"
var _banner_timer: float = 0.0
var _damage_flash_timer: float = 0.0
var _screen_flash_timer: float = 0.0
var _threat_timer: float = 0.0
var _threat_text: String = ""
var _threat_color: Color = UI_COLOR_CARRION_SOFT
var _placement_color: Color = Color(0.7, 0.7, 0.7)
var _event_text: String = ""
var _event_color: Color = Color(1, 1, 1)
var _event_timer: float = 0.0
var _commander: Node = null
var _selected_tower: Node = null
var _is_paused: bool = false
var _auto_wave_enabled: bool = true
var _can_start_next_wave: bool = false
var _run_over: bool = false
var _run_status_text: String = ""
var _header_pulse_time: float = 0.0
var _current_header_base_color: Color = Color(0.26, 0.42, 0.48, 1.0)
var _current_silhouette_base_color: Color = Color(0.16, 0.22, 0.26, 1.0)
var _current_accent_color: Color = UI_COLOR_DEFENDER_SOFT
var _end_screen_pulse_time: float = 0.0

func _ready() -> void:
	basic_tower_button.pressed.connect(func() -> void: build_tower_requested.emit("basic_tower"))
	heavy_battery_button.pressed.connect(func() -> void: build_tower_requested.emit("heavy_battery"))
	sell_button.pressed.connect(func() -> void: sell_selected_requested.emit())
	target_prev_button.pressed.connect(func() -> void: cycle_targeting_previous_requested.emit())
	target_next_button.pressed.connect(func() -> void: cycle_targeting_next_requested.emit())
	target_prev_button.mouse_entered.connect(func() -> void: _set_arrow_button_visual(target_prev_button, "hover"))
	target_prev_button.mouse_exited.connect(func() -> void: _set_arrow_button_visual(target_prev_button, "normal"))
	target_prev_button.button_down.connect(func() -> void: _set_arrow_button_visual(target_prev_button, "pressed"))
	target_prev_button.button_up.connect(func() -> void: _set_arrow_button_visual(target_prev_button, "hover" if target_prev_button.get_rect().has_point(target_prev_button.get_local_mouse_position()) else "normal"))
	target_next_button.mouse_entered.connect(func() -> void: _set_arrow_button_visual(target_next_button, "hover"))
	target_next_button.mouse_exited.connect(func() -> void: _set_arrow_button_visual(target_next_button, "normal"))
	target_next_button.button_down.connect(func() -> void: _set_arrow_button_visual(target_next_button, "pressed"))
	target_next_button.button_up.connect(func() -> void: _set_arrow_button_visual(target_next_button, "hover" if target_next_button.get_rect().has_point(target_next_button.get_local_mouse_position()) else "normal"))
	pause_button.pressed.connect(_on_pause_button_pressed)
	auto_wave_button.toggled.connect(func(enabled: bool) -> void: auto_wave_toggled.emit(enabled))
	next_wave_button.pressed.connect(func() -> void: next_wave_requested.emit())
	settings_button.pressed.connect(func() -> void: settings_requested.emit())
	game_over_restart_button.pressed.connect(func() -> void: restart_requested.emit())
	game_over_menu_button.pressed.connect(func() -> void: menu_requested.emit())
	game_over_continue_button.pressed.connect(func() -> void: continue_free_mode_requested.emit())
	basic_tower_button.text = "%s (%d)" % [BASIC_TOWER_DATA.get_localized_display_name(), BASIC_TOWER_DATA.tower_cost]
	heavy_battery_button.text = "%s (%d)" % [HEAVY_BATTERY_DATA.get_localized_display_name(), HEAVY_BATTERY_DATA.tower_cost]
	_apply_visual_theme()
	_update_selected_panel()
	_update_flow_panel()

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
	threat_label.text = _threat_text
	threat_label.modulate = _threat_color
	hint_label.text = _run_status_text if _run_over else RunState.t("hint_gameplay")
	_header_pulse_time += delta
	if selected_panel.visible:
		var pulse_strength: float = 0.08 + 0.04 * sin(_header_pulse_time * 2.2)
		header_panel.self_modulate = _current_header_base_color.lerp(Color(1, 1, 1, 1), pulse_strength)
		silhouette_panel.self_modulate = _current_silhouette_base_color.lerp(Color(1, 1, 1, 1), pulse_strength * 0.45)
		frame_top.color = _current_accent_color.lerp(Color(1, 1, 1, 1), pulse_strength * 0.55)
		frame_bottom.color = _current_accent_color.lerp(Color(0, 0, 0, 1), 0.35)
		corner_tl.color = _current_accent_color.lerp(Color(1, 1, 1, 1), pulse_strength * 0.65)
		corner_br.color = _current_accent_color.lerp(Color(0, 0, 0, 1), 0.18)
	if _damage_flash_timer > 0.0:
		_damage_flash_timer = maxf(0.0, _damage_flash_timer - delta)
		var flash_alpha: float = (_damage_flash_timer / 0.45) * 0.28
		damage_flash.color = Color(0.45, 0.02, 0.02, flash_alpha)
	else:
		damage_flash.color = Color(0.45, 0.02, 0.02, 0.0)
	boss_bar.modulate = Color(1, 1, 1, 1)
	if _screen_flash_timer > 0.0:
		_screen_flash_timer = maxf(0.0, _screen_flash_timer - delta)
		var flash_strength := _screen_flash_timer / 0.35
		boss_bar.modulate = Color(1.0, 1.0, 1.0, 1.0).lerp(Color(1.0, 0.92, 0.68, 1.0), flash_strength * 0.65)
		banner_label.modulate = banner_label.modulate.lerp(Color(1.0, 0.96, 0.72), flash_strength * 0.5)
	if _run_over:
		_end_screen_pulse_time += delta
		var end_pulse := 0.5 + sin(_end_screen_pulse_time * 2.0) * 0.5
		game_over_glow.color.a = 0.08 + end_pulse * 0.08
		game_over_frame_top.color.a = 0.72 + end_pulse * 0.20
		game_over_frame_bottom.color.a = 0.40 + end_pulse * 0.18
		game_over_side_left.color.a = 0.22 + end_pulse * 0.16
		game_over_side_right.color.a = 0.22 + end_pulse * 0.16
	if _banner_timer > 0.0:
		_banner_timer = maxf(0.0, _banner_timer - delta)
		if _banner_timer <= 0.0:
			banner_label.text = ""
	if _event_timer > 0.0:
		_event_timer = maxf(0.0, _event_timer - delta)
		if _event_timer <= 0.0:
			_event_text = ""
	if _threat_timer > 0.0:
		_threat_timer = maxf(0.0, _threat_timer - delta)
		if _threat_timer <= 0.0:
			_threat_text = ""
	_update_selected_panel()
	_update_flow_panel()

func set_placement_status(text: String, color: Color) -> void:
	_placement_text = text
	_placement_color = color

func show_event(text: String, color: Color = Color(1, 1, 1), duration: float = 1.5) -> void:
	_event_text = text
	_event_color = color
	_event_timer = duration

func trigger_damage_flash(duration: float = 0.45) -> void:
	_damage_flash_timer = duration

func show_banner(text: String, color: Color, duration: float = 1.6) -> void:
	banner_label.text = text
	banner_label.modulate = color
	_banner_timer = duration

func trigger_boss_flash(duration: float = 0.35) -> void:
	_screen_flash_timer = duration

func show_threat(text: String, color: Color = UI_COLOR_CARRION_SOFT, duration: float = 1.8) -> void:
	_threat_text = text
	_threat_color = color
	_threat_timer = duration
	threat_label.text = _threat_text
	threat_label.modulate = _threat_color

func set_commander_state(commander: Node) -> void:
	_commander = commander

func set_boss_state(active: bool, boss_name: String = "", health_ratio: float = 1.0) -> void:
	boss_bar.visible = active
	if not active:
		return
	boss_name_label.text = "[BOSS] %s" % boss_name
	boss_health_bar.value = clampf(health_ratio, 0.0, 1.0) * 100.0

func set_selected_build_mode(tower_id: String) -> void:
	basic_tower_button.button_pressed = tower_id == "basic_tower"
	heavy_battery_button.button_pressed = tower_id == "heavy_battery"
	basic_tower_button.modulate = Color(0.30, 0.48, 0.54, 1.0) if tower_id == "basic_tower" else Color(0.24, 0.34, 0.38, 1.0)
	heavy_battery_button.modulate = Color(0.50, 0.34, 0.20, 1.0) if tower_id == "heavy_battery" else Color(0.34, 0.26, 0.22, 1.0)

func set_selected_tower(tower: Node) -> void:
	_selected_tower = tower
	_update_selected_panel()

func set_pause_state(paused: bool) -> void:
	_is_paused = paused
	_update_flow_panel()

func set_wave_flow_state(auto_enabled: bool, can_start_next_wave: bool) -> void:
	_auto_wave_enabled = auto_enabled
	_can_start_next_wave = can_start_next_wave
	_update_flow_panel()

func set_end_state(end_state: String, status_text: String = "", hint_text: String = "", show_continue: bool = false) -> void:
	_run_over = end_state != ""
	_run_status_text = status_text
	game_over_overlay.visible = _run_over
	if _run_over:
		var is_victory: bool = end_state == "victory"
		game_over_title_label.text = RunState.t("victory") if is_victory else RunState.t("game_over")
		game_over_status_label.text = status_text if status_text != "" else (RunState.t("target_secured") if is_victory else RunState.t("base_integrity_collapsed"))
		game_over_stats_label.text = RunState.get_run_stats_text()
		game_over_hint_label.text = hint_text if hint_text != "" else (RunState.t("victory_hint") if is_victory else RunState.t("defeat_hint"))
		game_over_continue_button.visible = show_continue
		game_over_continue_button.disabled = not show_continue
		game_over_restart_button.text = RunState.t("restart_run")
		game_over_menu_button.text = RunState.t("return_to_menu")
		game_over_continue_button.text = RunState.t("continue_free_mode")
		game_over_panel.self_modulate = Color(0.78, 0.90, 0.82, 0.98) if is_victory else Color(0.90, 0.82, 0.78, 0.98)
		game_over_glow.color = Color(0.32, 0.92, 0.58, 0.10) if is_victory else Color(0.82, 0.24, 0.18, 0.10)
		game_over_frame_top.color = Color(0.46, 0.92, 0.68, 0.88) if is_victory else Color(1.0, 0.42, 0.28, 0.88)
		game_over_frame_bottom.color = Color(0.58, 0.90, 0.96, 0.55) if is_victory else Color(1.0, 0.72, 0.24, 0.55)
		game_over_side_left.color = Color(0.58, 0.90, 0.96, 0.32)
		game_over_side_right.color = Color(0.46, 0.92, 0.68, 0.32) if is_victory else Color(1.0, 0.72, 0.24, 0.32)
		game_over_title_label.add_theme_color_override("font_color", UI_COLOR_SUCCESS if is_victory else Color(1.0, 0.42, 0.28))
		game_over_status_label.add_theme_color_override("font_color", UI_COLOR_SUCCESS if is_victory else UI_COLOR_WARNING)
	_update_flow_panel()

func _get_commander_text() -> String:
	if _commander == null or not is_instance_valid(_commander):
		return RunState.t("commander_offline")
	if not _commander.has_method("get_overwatch_cooldown_remaining"):
		return RunState.t("commander_active")
	if _commander.has_method("is_overwatch_active") and _commander.is_overwatch_active():
		return RunState.t("commander_active_timer") % _commander.get_overwatch_remaining()
	if _commander.is_overwatch_ready():
		return RunState.t("commander_ready")
	return RunState.t("commander_cooldown") % _commander.get_overwatch_cooldown_remaining()

func _get_build_mode_text() -> String:
	var tower_data = TOWER_DISPLAY_DATA.get(GameState.selected_tower_id)
	if tower_data == null:
		return RunState.t("build_mode_off")
	return "%s (%d)" % [tower_data.get_localized_display_name(), tower_data.tower_cost]

func _apply_visual_theme() -> void:
	bottom_bar.self_modulate = Color(0.74, 0.82, 0.90, 0.98)
	status_panel.self_modulate = Color(0.74, 0.82, 0.90, 1.0)
	center_panel.self_modulate = Color(0.74, 0.82, 0.90, 1.0)
	selected_panel.self_modulate = Color(0.74, 0.82, 0.90, 1.0)
	selected_panel.modulate = Color(1, 1, 1, 0.98)
	header_panel.self_modulate = Color(0.72, 0.82, 0.90, 1.0)
	silhouette_panel.self_modulate = Color(0.18, 0.24, 0.28, 1.0)
	stats_panel.self_modulate = Color(0.86, 0.90, 0.96, 1.0)
	actions_panel.self_modulate = Color(0.82, 0.88, 0.94, 1.0)
	upgrades_panel.self_modulate = Color(0.80, 0.84, 0.90, 1.0)
	header_divider.color = Color(0.48, 0.82, 0.94, 0.45)
	stats_divider.color = Color(0.48, 0.82, 0.94, 0.25)
	actions_divider.color = Color(0.96, 0.72, 0.24, 0.22)
	frame_top.color = Color(0.42, 0.82, 0.96, 0.85)
	frame_bottom.color = Color(0.42, 0.82, 0.96, 0.45)
	corner_tl.color = Color(0.60, 0.90, 1.0, 0.9)
	corner_br.color = Color(0.96, 0.72, 0.24, 0.8)
	for label in [credits_label, wave_label, base_label, mode_label, placement_label, commander_label, hint_label, selected_title_label, selected_subtitle_label, selected_stats_label, silhouette_label, target_mode_label]:
		label.add_theme_color_override("font_color", UI_COLOR_NEUTRAL)
	credits_label.add_theme_color_override("font_color", UI_COLOR_DEFENDER)
	wave_label.add_theme_color_override("font_color", UI_COLOR_CARRION_SOFT)
	base_label.add_theme_color_override("font_color", UI_COLOR_WARNING)
	mode_label.add_theme_color_override("font_color", UI_COLOR_DEFENDER_SOFT)
	commander_label.add_theme_color_override("font_color", UI_COLOR_DEFENDER_SOFT)
	event_label.add_theme_color_override("font_color", UI_COLOR_NEUTRAL)
	threat_label.add_theme_color_override("font_color", UI_COLOR_CARRION_SOFT)
	banner_label.add_theme_color_override("font_color", UI_COLOR_CARRION_SOFT)
	boss_name_label.add_theme_color_override("font_color", UI_COLOR_WARNING)
	for button in [basic_tower_button, heavy_battery_button, pause_button, auto_wave_button, next_wave_button, settings_button, target_prev_button, target_next_button, sell_button, upgrade_slot_a, upgrade_slot_b, upgrade_slot_c, upgrade_slot_d, game_over_restart_button, game_over_menu_button, game_over_continue_button]:
		button.add_theme_color_override("font_color", UI_COLOR_NEUTRAL)
	basic_tower_button.modulate = Color(0.24, 0.34, 0.38, 1.0)
	heavy_battery_button.modulate = Color(0.34, 0.26, 0.22, 1.0)
	pause_button.modulate = Color(0.24, 0.24, 0.28, 1.0)
	auto_wave_button.modulate = Color(0.24, 0.28, 0.24, 1.0)
	next_wave_button.modulate = Color(0.34, 0.18, 0.16, 1.0)
	settings_button.modulate = Color(0.22, 0.28, 0.34, 1.0)
	_set_arrow_button_visual(target_prev_button, "normal")
	_set_arrow_button_visual(target_next_button, "normal")
	sell_button.modulate = Color(0.28, 0.18, 0.16, 1.0)
	for upgrade_slot in [upgrade_slot_a, upgrade_slot_b, upgrade_slot_c, upgrade_slot_d]:
		upgrade_slot.modulate = Color(0.18, 0.24, 0.30, 0.95)
	boss_bar.self_modulate = Color(0.92, 0.88, 0.74, 1.0)
	boss_health_bar.self_modulate = Color(1.0, 0.78, 0.20, 1.0)
	game_over_panel.self_modulate = Color(0.90, 0.82, 0.78, 0.98)
	game_over_title_label.add_theme_color_override("font_color", Color(1.0, 0.42, 0.28))
	game_over_status_label.add_theme_color_override("font_color", UI_COLOR_WARNING)
	game_over_stats_label.add_theme_color_override("font_color", UI_COLOR_NEUTRAL)
	game_over_hint_label.add_theme_color_override("font_color", UI_COLOR_NEUTRAL)
	game_over_restart_button.modulate = Color(0.50, 0.24, 0.20, 1.0)
	game_over_menu_button.modulate = Color(0.22, 0.28, 0.34, 1.0)
	game_over_continue_button.modulate = Color(0.22, 0.38, 0.28, 1.0)

func _update_selected_panel() -> void:
	if _selected_tower == null or not is_instance_valid(_selected_tower):
		selected_panel.visible = false
		selected_title_label.text = RunState.t("selected_tower")
		selected_subtitle_label.text = RunState.t("defense_unit")
		silhouette_label.text = "⬢"
		_apply_selected_visual_identity("")
		selected_stats_label.text = RunState.t("no_tower_selected")
		target_mode_label.text = RunState.t("targeting")
		target_prev_button.disabled = true
		target_next_button.disabled = true
		_set_arrow_button_visual(target_prev_button, "disabled")
		_set_arrow_button_visual(target_next_button, "disabled")
		sell_button.disabled = true
		return
	selected_panel.visible = true
	var tower_name: String = _selected_tower.get_ui_display_name() if _selected_tower.has_method("get_ui_display_name") else String(_selected_tower.name)
	var refund: int = _selected_tower.get_sell_refund() if _selected_tower.has_method("get_sell_refund") else 0
	var average_dps: float = _selected_tower.get_average_dps() if _selected_tower.has_method("get_average_dps") else 0.0
	var targeting_label: String = _selected_tower.get_targeting_mode_label() if _selected_tower.has_method("get_targeting_mode_label") else "First"
	selected_title_label.text = RunState.t("tower_control") % tower_name
	var icon: String = TARGET_ICONS.get(targeting_label, "◎")
	target_mode_label.text = "%s %s" % [icon, targeting_label]
	target_prev_button.disabled = false
	target_next_button.disabled = false
	_set_arrow_button_visual(target_prev_button, "normal")
	_set_arrow_button_visual(target_next_button, "normal")
	_apply_selected_visual_identity(tower_name)
	selected_stats_label.text = RunState.t("tower_stats") % [
		_selected_tower.damage,
		average_dps,
		_selected_tower.total_damage_dealt,
		_selected_tower.total_kills,
		_selected_tower.attack_range,
		_selected_tower.fire_rate,
		refund,
	]
	sell_button.text = RunState.t("sell_tower") % refund
	sell_button.disabled = false

func _apply_selected_visual_identity(tower_name: String) -> void:
	if tower_name == HEAVY_BATTERY_DATA.get_localized_display_name():
		_current_header_base_color = Color(0.54, 0.38, 0.24, 1.0)
		_current_silhouette_base_color = Color(0.22, 0.16, 0.12, 1.0)
		_current_accent_color = Color(1.0, 0.74, 0.34, 0.95)
		silhouette_label.text = "▉"
		selected_subtitle_label.text = RunState.t("siege_battery")
		selected_subtitle_label.add_theme_color_override("font_color", Color(1.0, 0.74, 0.34))
		for upgrade_slot in [upgrade_slot_a, upgrade_slot_b, upgrade_slot_c, upgrade_slot_d]:
			upgrade_slot.modulate = Color(0.34, 0.22, 0.16, 0.95)
	else:
		_current_header_base_color = Color(0.26, 0.42, 0.48, 1.0)
		_current_silhouette_base_color = Color(0.16, 0.22, 0.26, 1.0)
		_current_accent_color = Color(0.58, 0.90, 0.96, 0.95)
		silhouette_label.text = "⬢"
		selected_subtitle_label.text = RunState.t("line_defense") if tower_name != "" else RunState.t("defense_unit")
		selected_subtitle_label.add_theme_color_override("font_color", UI_COLOR_DEFENDER_SOFT)
		for upgrade_slot in [upgrade_slot_a, upgrade_slot_b, upgrade_slot_c, upgrade_slot_d]:
			upgrade_slot.modulate = Color(0.18, 0.24, 0.30, 0.95)
	frame_top.color = _current_accent_color
	header_divider.color = _current_accent_color.lerp(Color(1, 1, 1, 1), 0.18)
	stats_divider.color = _current_accent_color.lerp(Color(0, 0, 0, 1), 0.35)
	actions_divider.color = _current_accent_color.lerp(Color(0.96, 0.72, 0.24, 1), 0.35)
	header_panel.self_modulate = _current_header_base_color
	silhouette_panel.self_modulate = _current_silhouette_base_color

func _set_arrow_button_visual(button: Button, state: String) -> void:
	match state:
		"pressed":
			button.modulate = Color(0.10, 0.18, 0.24, 1.0)
			button.scale = Vector2(0.96, 0.96)
		"hover":
			button.modulate = Color(0.30, 0.48, 0.58, 1.0)
			button.scale = Vector2(1.03, 1.03)
		"disabled":
			button.modulate = Color(0.14, 0.18, 0.20, 0.7)
			button.scale = Vector2.ONE
		"normal":
			button.modulate = Color(0.18, 0.28, 0.34, 1.0)
			button.scale = Vector2.ONE

func _update_flow_panel() -> void:
	pause_button.text = RunState.t("resume") if _is_paused else RunState.t("pause")
	auto_wave_button.set_pressed_no_signal(_auto_wave_enabled)
	next_wave_button.disabled = _run_over or _auto_wave_enabled or not _can_start_next_wave
	next_wave_button.modulate = Color(0.48, 0.22, 0.18, 1.0) if not next_wave_button.disabled else Color(0.22, 0.18, 0.18, 0.9)
	auto_wave_button.modulate = Color(0.22, 0.34, 0.24, 1.0) if _auto_wave_enabled and not _run_over else Color(0.28, 0.22, 0.20, 1.0)
	pause_button.disabled = _run_over
	auto_wave_button.disabled = _run_over
	settings_button.text = RunState.t("settings")

func _on_pause_button_pressed() -> void:
	pause_toggled.emit(not _is_paused)
