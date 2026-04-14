extends Control

const GAME_ROOT_SCENE := "res://scenes/bootstrap/game_root.tscn"

const TEXTS := {
	"en": {
		"title": "TDG Prototype",
		"subtitle": "Choose a siege profile, survive to the target wave, and unlock Free Mode after a campaign victory.",
		"language": "Language",
		"mode": "Mode",
		"campaign": "Campaign",
		"endless": "Endless",
		"difficulty": "Difficulty",
		"custom_settings": "Custom Settings",
		"starting_credits": "Starting Credits",
		"base_hp": "Base HP",
		"enemy_speed": "Enemy Speed",
		"enemy_health": "Enemy Health",
		"target_wave": "Victory Target",
		"selected_suffix": "Difficulty",
		"campaign_goal": "Victory target: Wave %d",
		"endless_goal": "Objective: Endless survival",
		"controls": "Controls: 1/3 build towers | LMB place/select | RMB cancel | 2 Overwatch | X sell | T targeting | R restart",
		"start": "Start Run",
		"quit": "Quit",
		"tooltip_default": "Hover over a difficulty to preview its pressure, economy, and win condition.",
		"settings": "Settings",
		"open_settings": "Open Settings",
		"close_settings": "Close Settings",
		"apply_settings": "Apply Settings",
		"master_volume": "Master Volume",
		"fullscreen": "Fullscreen",
	},
	"de": {
		"title": "TDG Prototyp",
		"subtitle": "Wähle ein Belagerungsprofil, überlebe bis zur Zielwelle und schalte nach einem Kampagnensieg den freien Modus frei.",
		"language": "Sprache",
		"mode": "Modus",
		"campaign": "Kampagne",
		"endless": "Endlos",
		"difficulty": "Schwierigkeit",
		"custom_settings": "Eigene Einstellungen",
		"starting_credits": "Start-Credits",
		"base_hp": "Basis-HP",
		"enemy_speed": "Gegner-Tempo",
		"enemy_health": "Gegner-Leben",
		"target_wave": "Siegziel",
		"selected_suffix": "Schwierigkeit",
		"campaign_goal": "Siegziel: Welle %d",
		"endless_goal": "Ziel: Endlos überleben",
		"controls": "Steuerung: 1/3 Türme bauen | LMB platzieren/auswählen | RMB abbrechen | 2 Overwatch | X verkaufen | T Zielmodus | R Neustart",
		"start": "Run starten",
		"quit": "Beenden",
		"tooltip_default": "Bewege die Maus über eine Schwierigkeit, um Druck, Ökonomie und Ziel zu sehen.",
		"settings": "Einstellungen",
		"open_settings": "Einstellungen öffnen",
		"close_settings": "Einstellungen schließen",
		"apply_settings": "Einstellungen anwenden",
		"master_volume": "Master-Lautstärke",
		"fullscreen": "Vollbild",
	},
}

const DIFFICULTIES := [
	{
		"id": "recruit",
		"name": {"en": "Recruit", "de": "Rekrut"},
		"subtitle": {"en": "Forgiving opening. More resources, sturdier walls, lighter enemy pressure.", "de": "Verzeihender Einstieg. Mehr Ressourcen, stärkere Mauern, geringerer Gegnerdruck."},
		"tooltip": {"en": "Safest onboarding profile with a short campaign target.", "de": "Einsteigerprofil mit kurzer Kampagnenzielwelle."},
		"starting_credits": 420,
		"starting_base_hp": 30,
		"enemy_speed_multiplier": 0.88,
		"enemy_health_multiplier": 0.90,
		"target_wave": 10,
	},
	{
		"id": "standard",
		"name": {"en": "Standard", "de": "Standard"},
		"subtitle": {"en": "Baseline prototype experience with a balanced siege tempo.", "de": "Ausgewogene Prototyp-Erfahrung mit balanciertem Belagerungstempo."},
		"tooltip": {"en": "Recommended first full run with the default objective.", "de": "Empfohlener erster voller Run mit Standardziel."},
		"starting_credits": 300,
		"starting_base_hp": 20,
		"enemy_speed_multiplier": 1.0,
		"enemy_health_multiplier": 1.0,
		"target_wave": 12,
	},
	{
		"id": "veteran",
		"name": {"en": "Veteran", "de": "Veteran"},
		"subtitle": {"en": "Higher pressure and a longer defensive objective.", "de": "Höherer Druck und ein längeres Verteidigungsziel."},
		"tooltip": {"en": "Longer objective with noticeably stronger wave pressure.", "de": "Längeres Ziel mit spürbar stärkerem Wellendruck."},
		"starting_credits": 270,
		"starting_base_hp": 18,
		"enemy_speed_multiplier": 1.05,
		"enemy_health_multiplier": 1.08,
		"target_wave": 14,
	},
	{
		"id": "brutal",
		"name": {"en": "Brutal", "de": "Brutal"},
		"subtitle": {"en": "Tight economy, harder waves, and a tougher win condition.", "de": "Knappere Wirtschaft, härtere Wellen und ein strengeres Siegesziel."},
		"tooltip": {"en": "For players who want pressure from the first minutes onward.", "de": "Für Spieler, die von Beginn an starken Druck wollen."},
		"starting_credits": 240,
		"starting_base_hp": 15,
		"enemy_speed_multiplier": 1.10,
		"enemy_health_multiplier": 1.14,
		"target_wave": 16,
	},
	{
		"id": "nightmare",
		"name": {"en": "Nightmare", "de": "Albtraum"},
		"subtitle": {"en": "Maximum pressure. Survive a long siege with little margin for error.", "de": "Maximaler Druck. Überlebe eine lange Belagerung mit kaum Fehlertoleranz."},
		"tooltip": {"en": "Longest target, weakest start, and the most dangerous enemy scaling.", "de": "Längstes Ziel, schwächster Start und die gefährlichste Gegner-Skalierung."},
		"starting_credits": 210,
		"starting_base_hp": 12,
		"enemy_speed_multiplier": 1.16,
		"enemy_health_multiplier": 1.22,
		"target_wave": 18,
	},
	{
		"id": "custom",
		"name": {"en": "Custom", "de": "Benutzerdefiniert"},
		"subtitle": {"en": "Tune economy, base integrity, enemy strength, and campaign target.", "de": "Passe Wirtschaft, Basisstärke, Gegnerstärke und Kampagnenziel an."},
		"tooltip": {"en": "Use the sliders below to build your own challenge profile.", "de": "Nutze die Regler unten, um dein eigenes Profil zu erstellen."},
		"starting_credits": 300,
		"starting_base_hp": 20,
		"enemy_speed_multiplier": 1.0,
		"enemy_health_multiplier": 1.0,
		"target_wave": 12,
	},
]

@onready var menu_panel: PanelContainer = $Margin/RootVBox/MenuPanel
@onready var back_glow: ColorRect = $BackGlow
@onready var sweep_line: ColorRect = $SweepLine
@onready var title_label: Label = $Margin/RootVBox/HeaderPanel/HeaderMargin/HeaderVBox/TitleLabel
@onready var subtitle_label: Label = $Margin/RootVBox/HeaderPanel/HeaderMargin/HeaderVBox/SubtitleLabel
@onready var language_title_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/TopControlRow/LanguagePanel/LanguageMargin/LanguageVBox/LanguageTitleLabel
@onready var language_en_button: Button = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/TopControlRow/LanguagePanel/LanguageMargin/LanguageVBox/LanguageButtons/LanguageEnButton
@onready var language_de_button: Button = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/TopControlRow/LanguagePanel/LanguageMargin/LanguageVBox/LanguageButtons/LanguageDeButton
@onready var mode_title_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/TopControlRow/ModePanel/ModeMargin/ModeVBox/ModeTitleLabel
@onready var mode_campaign_button: Button = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/TopControlRow/ModePanel/ModeMargin/ModeVBox/ModeButtons/ModeCampaignButton
@onready var mode_endless_button: Button = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/TopControlRow/ModePanel/ModeMargin/ModeVBox/ModeButtons/ModeEndlessButton
@onready var settings_button: Button = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/TopControlRow/SettingsPanel/SettingsMargin/SettingsVBox/OpenSettingsButton
@onready var settings_popup: PanelContainer = $SettingsOverlay/SettingsCenter/SettingsPopup
@onready var settings_title_label: Label = $SettingsOverlay/SettingsCenter/SettingsPopup/SettingsMargin/SettingsVBox/SettingsTitleLabel
@onready var settings_volume_label: Label = $SettingsOverlay/SettingsCenter/SettingsPopup/SettingsMargin/SettingsVBox/VolumeRow/VolumeLabel
@onready var settings_volume_slider: HSlider = $SettingsOverlay/SettingsCenter/SettingsPopup/SettingsMargin/SettingsVBox/VolumeRow/VolumeSlider
@onready var settings_volume_value_label: Label = $SettingsOverlay/SettingsCenter/SettingsPopup/SettingsMargin/SettingsVBox/VolumeRow/VolumeValueLabel
@onready var settings_fullscreen_button: CheckButton = $SettingsOverlay/SettingsCenter/SettingsPopup/SettingsMargin/SettingsVBox/FullscreenButton
@onready var settings_apply_button: Button = $SettingsOverlay/SettingsCenter/SettingsPopup/SettingsMargin/SettingsVBox/SettingsActionRow/ApplySettingsButton
@onready var settings_close_button: Button = $SettingsOverlay/SettingsCenter/SettingsPopup/SettingsMargin/SettingsVBox/SettingsActionRow/CloseSettingsButton
@onready var difficulty_title_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/DifficultyTitleLabel
@onready var recruit_button: Button = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/DifficultyGrid/RecruitButton
@onready var standard_button: Button = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/DifficultyGrid/StandardButton
@onready var veteran_button: Button = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/DifficultyGrid/VeteranButton
@onready var brutal_button: Button = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/DifficultyGrid/BrutalButton
@onready var nightmare_button: Button = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/DifficultyGrid/NightmareButton
@onready var custom_button: Button = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/DifficultyGrid/CustomButton
@onready var tooltip_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/TooltipPanel/TooltipMargin/TooltipLabel
@onready var difficulty_name_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/SelectedDifficultyPanel/SelectedDifficultyMargin/SelectedDifficultyVBox/DifficultyNameLabel
@onready var difficulty_desc_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/SelectedDifficultyPanel/SelectedDifficultyMargin/SelectedDifficultyVBox/DifficultyDescLabel
@onready var stats_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/SelectedDifficultyPanel/SelectedDifficultyMargin/SelectedDifficultyVBox/DifficultyStatsLabel
@onready var custom_panel: PanelContainer = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/CustomPanel
@onready var custom_title_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/CustomPanel/CustomMargin/CustomVBox/CustomTitleLabel
@onready var credits_name_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/CustomPanel/CustomMargin/CustomVBox/CreditsRow/CreditsLabel
@onready var credits_slider: HSlider = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/CustomPanel/CustomMargin/CustomVBox/CreditsRow/CreditsSlider
@onready var credits_value_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/CustomPanel/CustomMargin/CustomVBox/CreditsRow/CreditsValueLabel
@onready var base_hp_name_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/CustomPanel/CustomMargin/CustomVBox/BaseHpRow/BaseHpLabel
@onready var base_hp_slider: HSlider = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/CustomPanel/CustomMargin/CustomVBox/BaseHpRow/BaseHpSlider
@onready var base_hp_value_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/CustomPanel/CustomMargin/CustomVBox/BaseHpRow/BaseHpValueLabel
@onready var enemy_speed_name_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/CustomPanel/CustomMargin/CustomVBox/EnemySpeedRow/EnemySpeedLabel
@onready var enemy_speed_slider: HSlider = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/CustomPanel/CustomMargin/CustomVBox/EnemySpeedRow/EnemySpeedSlider
@onready var enemy_speed_value_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/CustomPanel/CustomMargin/CustomVBox/EnemySpeedRow/EnemySpeedValueLabel
@onready var enemy_health_name_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/CustomPanel/CustomMargin/CustomVBox/EnemyHealthRow/EnemyHealthLabel
@onready var enemy_health_slider: HSlider = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/CustomPanel/CustomMargin/CustomVBox/EnemyHealthRow/EnemyHealthSlider
@onready var enemy_health_value_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/CustomPanel/CustomMargin/CustomVBox/EnemyHealthRow/EnemyHealthValueLabel
@onready var target_wave_name_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/CustomPanel/CustomMargin/CustomVBox/TargetWaveRow/TargetWaveLabel
@onready var target_wave_slider: HSlider = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/CustomPanel/CustomMargin/CustomVBox/TargetWaveRow/TargetWaveSlider
@onready var target_wave_value_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/CustomPanel/CustomMargin/CustomVBox/TargetWaveRow/TargetWaveValueLabel
@onready var controls_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/ControlsPanel/ControlsMargin/ControlsLabel
@onready var start_button: Button = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/ActionRow/StartButton
@onready var quit_button: Button = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/ActionRow/QuitButton

var _difficulty_buttons: Array[Button] = []
var _selected_difficulty_index: int = 1
var _pulse_time: float = 0.0
var _current_language: String = "en"
var _current_mode: String = "campaign"
var _tooltip_locked_to_selection: bool = true

func _ready() -> void:
	_current_language = RunState.menu_language if RunState.menu_language != "" else "en"
	_current_mode = RunState.game_mode if RunState.game_mode != "" else "campaign"
	_difficulty_buttons = [recruit_button, standard_button, veteran_button, brutal_button, nightmare_button, custom_button]
	credits_slider.value_changed.connect(func(_value: float) -> void: _refresh_custom_labels())
	base_hp_slider.value_changed.connect(func(_value: float) -> void: _refresh_custom_labels())
	enemy_speed_slider.value_changed.connect(func(_value: float) -> void: _refresh_custom_labels())
	enemy_health_slider.value_changed.connect(func(_value: float) -> void: _refresh_custom_labels())
	target_wave_slider.value_changed.connect(func(_value: float) -> void: _refresh_custom_labels())
	settings_volume_slider.value_changed.connect(func(value: float) -> void: settings_volume_value_label.text = "%d%%" % int(round(value * 100.0)))
	settings_button.pressed.connect(_toggle_settings)
	settings_apply_button.pressed.connect(_apply_settings)
	settings_close_button.pressed.connect(_toggle_settings)
	language_en_button.pressed.connect(func() -> void: _set_language("en"))
	language_de_button.pressed.connect(func() -> void: _set_language("de"))
	mode_campaign_button.pressed.connect(func() -> void: _set_mode("campaign"))
	mode_endless_button.pressed.connect(func() -> void: _set_mode("endless"))
	for i in range(_difficulty_buttons.size()):
		var button := _difficulty_buttons[i]
		button.pressed.connect(func(index: int = i) -> void: _select_difficulty(index))
		button.mouse_entered.connect(func(index: int = i) -> void: _show_difficulty_tooltip(index, false))
		button.mouse_exited.connect(func() -> void: _restore_selected_tooltip())
	start_button.pressed.connect(_start_game)
	quit_button.pressed.connect(func() -> void: get_tree().quit())
	settings_volume_slider.value = RunState.master_volume
	settings_fullscreen_button.button_pressed = RunState.fullscreen_enabled
	settings_volume_value_label.text = "%d%%" % int(round(RunState.master_volume * 100.0))
	_refresh_custom_labels()
	_apply_language()
	_set_mode(_current_mode)
	_select_difficulty(_selected_difficulty_index)

func _process(delta: float) -> void:
	_pulse_time += delta
	var pulse := 0.5 + sin(_pulse_time * 1.5) * 0.5
	back_glow.modulate = Color(0.28, 0.44, 0.52, 0.14 + pulse * 0.10)
	sweep_line.position.x = -220.0 + fmod(_pulse_time * 180.0, size.x + 440.0)
	menu_panel.scale = Vector2.ONE * (1.0 + sin(_pulse_time * 1.3) * 0.01)

func _set_language(language: String) -> void:
	_current_language = language
	RunState.menu_language = language
	language_en_button.button_pressed = language == "en"
	language_de_button.button_pressed = language == "de"
	language_en_button.modulate = Color(0.24, 0.38, 0.46, 1.0) if language == "en" else Color(0.18, 0.22, 0.26, 1.0)
	language_de_button.modulate = Color(0.24, 0.38, 0.46, 1.0) if language == "de" else Color(0.18, 0.22, 0.26, 1.0)
	_apply_language()
	_select_difficulty(_selected_difficulty_index)

func _set_mode(mode: String) -> void:
	_current_mode = mode
	RunState.game_mode = mode
	mode_campaign_button.button_pressed = mode == "campaign"
	mode_endless_button.button_pressed = mode == "endless"
	mode_campaign_button.modulate = Color(0.24, 0.34, 0.48, 1.0) if mode == "campaign" else Color(0.18, 0.22, 0.26, 1.0)
	mode_endless_button.modulate = Color(0.24, 0.40, 0.30, 1.0) if mode == "endless" else Color(0.18, 0.22, 0.26, 1.0)
	custom_panel.visible = _is_custom_selected() and _current_mode == "campaign"
	_select_difficulty(_selected_difficulty_index)

func _toggle_settings() -> void:
	$SettingsOverlay.visible = not $SettingsOverlay.visible

func _apply_settings() -> void:
	RunState.apply_settings(settings_volume_slider.value, settings_fullscreen_button.button_pressed)
	AudioManager.set_master_volume(RunState.master_volume)
	AudioManager.set_fullscreen(RunState.fullscreen_enabled)
	_toggle_settings()

func _apply_language() -> void:
	title_label.text = _text("title")
	subtitle_label.text = _text("subtitle")
	language_title_label.text = _text("language")
	language_en_button.text = "English"
	language_de_button.text = "Deutsch"
	mode_title_label.text = _text("mode")
	mode_campaign_button.text = _text("campaign")
	mode_endless_button.text = _text("endless")
	settings_button.text = _text("open_settings")
	settings_title_label.text = _text("settings")
	settings_volume_label.text = _text("master_volume")
	settings_fullscreen_button.text = _text("fullscreen")
	settings_apply_button.text = _text("apply_settings")
	settings_close_button.text = _text("close_settings")
	difficulty_title_label.text = _text("difficulty")
	custom_title_label.text = _text("custom_settings")
	credits_name_label.text = _text("starting_credits")
	base_hp_name_label.text = _text("base_hp")
	enemy_speed_name_label.text = _text("enemy_speed")
	enemy_health_name_label.text = _text("enemy_health")
	target_wave_name_label.text = _text("target_wave")
	controls_label.text = _text("controls")
	start_button.text = _text("start")
	quit_button.text = _text("quit")
	for i in range(DIFFICULTIES.size()):
		_difficulty_buttons[i].text = _localized_value(DIFFICULTIES[i].get("name", ""))
	if _tooltip_locked_to_selection:
		_restore_selected_tooltip()

func _select_difficulty(index: int) -> void:
	_selected_difficulty_index = clampi(index, 0, DIFFICULTIES.size() - 1)
	var raw_config: Dictionary = DIFFICULTIES[_selected_difficulty_index]
	var raw_id: String = String(raw_config.get("id", ""))
	if not RunState.can_select_difficulty(raw_id):
		_restore_selected_tooltip()
		return
	var config := _get_selected_config()
	for i in range(_difficulty_buttons.size()):
		var button := _difficulty_buttons[i]
		var difficulty_id: String = String(DIFFICULTIES[i].get("id", ""))
		button.button_pressed = i == _selected_difficulty_index and RunState.can_select_difficulty(difficulty_id)
		button.modulate = _get_button_color(i, i == _selected_difficulty_index and RunState.can_select_difficulty(difficulty_id))
		button.disabled = not RunState.can_select_difficulty(difficulty_id)
	custom_panel.visible = _is_custom_selected() and _current_mode == "campaign"
	difficulty_name_label.text = "%s %s" % [_localized_value(config.get("name", "")), _text("selected_suffix")]
	difficulty_desc_label.text = _localized_value(config.get("subtitle", ""))
	stats_label.text = _build_stats_text(config)
	_restore_selected_tooltip()

func _show_difficulty_tooltip(index: int, locked: bool) -> void:
	_tooltip_locked_to_selection = locked
	var config: Dictionary = DIFFICULTIES[index]
	var difficulty_id: String = String(config.get("id", ""))
	if not RunState.can_select_difficulty(difficulty_id):
		var required_id: String = RunState.get_required_difficulty_for(difficulty_id)
		var required_name: String = required_id.capitalize()
		for candidate in DIFFICULTIES:
			if String(candidate.get("id", "")) == required_id:
				required_name = _localized_value(candidate.get("name", required_name))
				break
		tooltip_label.text = RunState.get_locked_reason(difficulty_id, required_name)
		return
	var mode_line: String = _text("endless_goal") if _current_mode == "endless" else (_text("campaign_goal") % int(config.get("target_wave", 12)))
	tooltip_label.text = "%s\n%s\n%s" % [
		_localized_value(config.get("tooltip", "")),
		_localized_value(config.get("subtitle", "")),
		mode_line,
	]

func _restore_selected_tooltip() -> void:
	_tooltip_locked_to_selection = true
	if _selected_difficulty_index >= 0 and _selected_difficulty_index < DIFFICULTIES.size():
		_show_difficulty_tooltip(_selected_difficulty_index, true)
	else:
		tooltip_label.text = _text("tooltip_default")

func _get_button_color(index: int, active: bool) -> Color:
	match index:
		0:
			return Color(0.24, 0.40, 0.32, 1.0) if active else Color(0.18, 0.24, 0.22, 0.92)
		1:
			return Color(0.24, 0.38, 0.46, 1.0) if active else Color(0.18, 0.22, 0.26, 0.92)
		2:
			return Color(0.28, 0.34, 0.48, 1.0) if active else Color(0.18, 0.22, 0.26, 0.92)
		3:
			return Color(0.46, 0.24, 0.20, 1.0) if active else Color(0.20, 0.20, 0.22, 0.92)
		4:
			return Color(0.52, 0.18, 0.18, 1.0) if active else Color(0.20, 0.18, 0.20, 0.92)
		_:
			return Color(0.32, 0.30, 0.18, 1.0) if active else Color(0.20, 0.20, 0.18, 0.92)

func _refresh_custom_labels() -> void:
	credits_value_label.text = str(int(credits_slider.value))
	base_hp_value_label.text = str(int(base_hp_slider.value))
	enemy_speed_value_label.text = "%d%%" % int(round(enemy_speed_slider.value))
	enemy_health_value_label.text = "%d%%" % int(round(enemy_health_slider.value))
	target_wave_value_label.text = str(int(target_wave_slider.value))
	if _is_custom_selected():
		stats_label.text = _build_stats_text(_get_selected_config())

func _get_selected_config() -> Dictionary:
	var base_config: Dictionary = DIFFICULTIES[_selected_difficulty_index].duplicate(true)
	base_config["name"] = _localized_value(base_config.get("name", ""))
	base_config["subtitle"] = _localized_value(base_config.get("subtitle", ""))
	base_config["tooltip"] = _localized_value(base_config.get("tooltip", ""))
	base_config["language"] = _current_language
	base_config["game_mode"] = _current_mode
	if String(base_config.get("id", "")) != "custom":
		return base_config
	base_config["starting_credits"] = int(credits_slider.value)
	base_config["starting_base_hp"] = int(base_hp_slider.value)
	base_config["enemy_speed_multiplier"] = float(enemy_speed_slider.value) / 100.0
	base_config["enemy_health_multiplier"] = float(enemy_health_slider.value) / 100.0
	base_config["target_wave"] = int(target_wave_slider.value)
	return base_config

func _build_stats_text(config: Dictionary) -> String:
	var objective_text := _text("endless_goal") if _current_mode == "endless" else (_text("campaign_goal") % int(config.get("target_wave", 12)))
	return "%s: %d\n%s: %d\n%s: %d%%\n%s: %d%%\n%s" % [
		_text("starting_credits"),
		int(config.get("starting_credits", 300)),
		_text("base_hp"),
		int(config.get("starting_base_hp", 20)),
		_text("enemy_speed"),
		int(round(float(config.get("enemy_speed_multiplier", 1.0)) * 100.0)),
		_text("enemy_health"),
		int(round(float(config.get("enemy_health_multiplier", 1.0)) * 100.0)),
		objective_text,
	]

func _localized_value(value: Variant) -> String:
	if value is Dictionary:
		return String(value.get(_current_language, value.get("en", "")))
	return String(value)

func _text(key: String) -> String:
	var lang_table: Dictionary = TEXTS.get(_current_language, TEXTS["en"])
	return String(lang_table.get(key, key))

func _is_custom_selected() -> bool:
	return _selected_difficulty_index == DIFFICULTIES.size() - 1

func _start_game() -> void:
	RunState.configure_difficulty(_get_selected_config())
	get_tree().paused = false
	SceneRouter.goto_scene(GAME_ROOT_SCENE)
