extends Control

const GAME_ROOT_SCENE := "res://scenes/bootstrap/game_root.tscn"
const UI_BUTTON_ACTIVE := Color(0.88, 0.96, 1.0, 1.0)
const UI_BUTTON_IDLE := Color(0.78, 0.84, 0.90, 0.92)
const UI_BUTTON_ACTIVE_ENDLESS := Color(0.88, 0.98, 0.90, 1.0)
const UI_BUTTON_LOCKED := Color(0.48, 0.52, 0.58, 0.72)
const MENU_SCROLL_STEP := 72.0
const MVP_TOWERS := [
	preload("res://data/mvp/towers/musterline_redoubt.tres"),
	preload("res://data/mvp/towers/auric_sentinel_lancepost.tres"),
	preload("res://data/mvp/towers/pyre_chapel_array.tres"),
	preload("res://data/mvp/towers/cogforged_relay_spire.tres"),
	preload("res://data/mvp/towers/reliquary_bombard.tres"),
]
const MVP_COMMANDERS := [
	preload("res://data/mvp/commander/legion_prefect.tres"),
]
const COMMANDER_OPTIONS := [
	{"id": "legion_prefect", "data": preload("res://data/mvp/commander/legion_prefect.tres")},
]
const MVP_ENEMIES := [
	preload("res://data/mvp/enemies/scuttleborn-mvp.tres"),
	preload("res://data/mvp/enemies/razor_leaper.tres"),
	preload("res://data/mvp/enemies/shellback_brute-mvp.tres"),
	preload("res://data/mvp/enemies/spore_herald.tres"),
	preload("res://data/mvp/enemies/maw_colossus.tres"),
]

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
		"music_volume": "Music Volume",
		"sfx_volume": "SFX Volume",
		"fullscreen": "Fullscreen",
		"content_browser": "MVP Content Browser", "content_towers": "Towers", "content_commander": "Commander", "content_enemies": "Enemies", "content_prev": "Previous", "content_next": "Next",
		"commander_select_title": "Choose Commander", "commander_select_hint": "Select your commander for this run. This choice is locked once the mission begins.", "commander_confirm": "Deploy Commander", "commander_cancel": "Back", "commander_locked_hint": "Commander locked for this run", "selected_commander": "Selected Commander", "commander_card_hint": "Deployment locked after mission start", "commander_dialog_current": "Current selection for this run", "stat_role": "Role", "stat_cost": "Cost", "stat_damage": "Damage", "stat_rate": "Rate", "stat_range": "Range", "stat_formation_link": "Formation Link", "stat_priority_damage": "Priority Damage", "stat_splash": "Splash", "stat_relay_aura": "Relay Aura", "stat_rule": "Rule", "stat_tags": "Tags", "stat_health": "Health", "stat_speed": "Speed", "stat_armor": "Armor", "stat_leak_damage": "Leak Damage", "stat_bounty": "Bounty", "stat_threat_class": "Threat Class", "stat_elite": "Elite", "stat_boss": "Boss", "stat_move_speed": "Move Speed", "stat_overwatch": "Overwatch", "stat_ability": "Ability",
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
		"music_volume": "Musik-Lautstärke",
		"sfx_volume": "SFX-Lautstärke",
		"fullscreen": "Vollbild",
		"content_browser": "MVP-Inhaltsbrowser", "content_towers": "Türme", "content_commander": "Commander", "content_enemies": "Gegner", "content_prev": "Zurück", "content_next": "Weiter",
		"commander_select_title": "Commander wählen", "commander_select_hint": "Wähle deinen Commander für diesen Run. Diese Wahl ist nach Missionsbeginn gesperrt.", "commander_confirm": "Commander einsetzen", "commander_cancel": "Zurück", "commander_locked_hint": "Commander für diesen Run gesperrt", "selected_commander": "Gewählter Commander", "commander_card_hint": "Nach Missionsstart fest zugewiesen", "commander_dialog_current": "Aktuelle Auswahl für diesen Run", "stat_role": "Rolle", "stat_cost": "Kosten", "stat_damage": "Schaden", "stat_rate": "Rate", "stat_range": "Reichweite", "stat_formation_link": "Formationslink", "stat_priority_damage": "Prioritätsschaden", "stat_splash": "Flächenschaden", "stat_relay_aura": "Relais-Aura", "stat_rule": "Regel", "stat_tags": "Tags", "stat_health": "Leben", "stat_speed": "Tempo", "stat_armor": "Panzerung", "stat_leak_damage": "Basis-Schaden", "stat_bounty": "Belohnung", "stat_threat_class": "Bedrohungsklasse", "stat_elite": "Elite", "stat_boss": "Boss", "stat_move_speed": "Bewegung", "stat_overwatch": "Overwatch", "stat_ability": "Fähigkeit",
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

@onready var margin_root: MarginContainer = $Margin
@onready var root_vbox: VBoxContainer = $Margin/RootVBox
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
@onready var settings_master_volume_label: Label = $SettingsOverlay/SettingsCenter/SettingsPopup/SettingsMargin/SettingsVBox/MasterVolumeRow/VolumeLabel
@onready var settings_master_volume_slider: HSlider = $SettingsOverlay/SettingsCenter/SettingsPopup/SettingsMargin/SettingsVBox/MasterVolumeRow/VolumeSlider
@onready var settings_master_volume_value_label: Label = $SettingsOverlay/SettingsCenter/SettingsPopup/SettingsMargin/SettingsVBox/MasterVolumeRow/VolumeValueLabel
@onready var settings_music_volume_label: Label = $SettingsOverlay/SettingsCenter/SettingsPopup/SettingsMargin/SettingsVBox/MusicVolumeRow/MusicLabel
@onready var settings_music_volume_slider: HSlider = $SettingsOverlay/SettingsCenter/SettingsPopup/SettingsMargin/SettingsVBox/MusicVolumeRow/MusicSlider
@onready var settings_music_volume_value_label: Label = $SettingsOverlay/SettingsCenter/SettingsPopup/SettingsMargin/SettingsVBox/MusicVolumeRow/MusicValueLabel
@onready var settings_sfx_volume_label: Label = $SettingsOverlay/SettingsCenter/SettingsPopup/SettingsMargin/SettingsVBox/SfxVolumeRow/SfxLabel
@onready var settings_sfx_volume_slider: HSlider = $SettingsOverlay/SettingsCenter/SettingsPopup/SettingsMargin/SettingsVBox/SfxVolumeRow/SfxSlider
@onready var settings_sfx_volume_value_label: Label = $SettingsOverlay/SettingsCenter/SettingsPopup/SettingsMargin/SettingsVBox/SfxVolumeRow/SfxValueLabel
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
@onready var content_browser_title_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/ContentBrowserPanel/ContentBrowserMargin/ContentBrowserVBox/ContentBrowserTitleLabel
@onready var tower_category_button: Button = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/ContentBrowserPanel/ContentBrowserMargin/ContentBrowserVBox/ContentCategoryRow/TowerCategoryButton
@onready var commander_category_button: Button = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/ContentBrowserPanel/ContentBrowserMargin/ContentBrowserVBox/ContentCategoryRow/CommanderCategoryButton
@onready var enemy_category_button: Button = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/ContentBrowserPanel/ContentBrowserMargin/ContentBrowserVBox/ContentCategoryRow/EnemyCategoryButton
@onready var content_name_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/ContentBrowserPanel/ContentBrowserMargin/ContentBrowserVBox/ContentNameLabel
@onready var content_summary_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/ContentBrowserPanel/ContentBrowserMargin/ContentBrowserVBox/ContentSummaryLabel
@onready var content_stats_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/ContentBrowserPanel/ContentBrowserMargin/ContentBrowserVBox/ContentStatsLabel
@onready var prev_content_button: Button = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/ContentBrowserPanel/ContentBrowserMargin/ContentBrowserVBox/ContentNavRow/PrevContentButton
@onready var next_content_button: Button = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/ContentBrowserPanel/ContentBrowserMargin/ContentBrowserVBox/ContentNavRow/NextContentButton
@onready var commander_dialog: Control = $CommanderOverlay
@onready var commander_title_label: Label = $CommanderOverlay/CommanderCenter/CommanderPopup/CommanderMargin/CommanderVBox/CommanderTitleLabel
@onready var commander_hint_label: Label = $CommanderOverlay/CommanderCenter/CommanderPopup/CommanderMargin/CommanderVBox/CommanderHintLabel
@onready var commander_prev_button: Button = $CommanderOverlay/CommanderCenter/CommanderPopup/CommanderMargin/CommanderVBox/CommanderNavRow/CommanderPrevButton
@onready var commander_next_button: Button = $CommanderOverlay/CommanderCenter/CommanderPopup/CommanderMargin/CommanderVBox/CommanderNavRow/CommanderNextButton
@onready var commander_name_label: Label = $CommanderOverlay/CommanderCenter/CommanderPopup/CommanderMargin/CommanderVBox/CommanderNameLabel
@onready var commander_summary_label: Label = $CommanderOverlay/CommanderCenter/CommanderPopup/CommanderMargin/CommanderVBox/CommanderSummaryLabel
@onready var commander_stats_label: Label = $CommanderOverlay/CommanderCenter/CommanderPopup/CommanderMargin/CommanderVBox/CommanderStatsLabel
@onready var commander_confirm_button: Button = $CommanderOverlay/CommanderCenter/CommanderPopup/CommanderMargin/CommanderVBox/CommanderActionRow/CommanderConfirmButton
@onready var commander_cancel_button: Button = $CommanderOverlay/CommanderCenter/CommanderPopup/CommanderMargin/CommanderVBox/CommanderActionRow/CommanderCancelButton
@onready var selected_commander_title_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/SelectedCommanderPanel/SelectedCommanderMargin/SelectedCommanderVBox/SelectedCommanderTitleLabel
@onready var selected_commander_value_label: Label = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/SelectedCommanderPanel/SelectedCommanderMargin/SelectedCommanderVBox/SelectedCommanderValueLabel
@onready var start_button: Button = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/ActionRow/StartButton
@onready var quit_button: Button = $Margin/RootVBox/MenuPanel/MenuMargin/MenuVBox/ActionRow/QuitButton

var _difficulty_buttons: Array[Button] = []
var _selected_difficulty_index: int = 1
var _pulse_time: float = 0.0
var _current_language: String = "en"
var _current_mode: String = "campaign"
var _tooltip_locked_to_selection: bool = true
var _content_category: String = "tower"
var _content_index: int = 0
var _selected_commander_index: int = 0
var _scroll_offset: float = 0.0
var _max_scroll_offset: float = 0.0

func _ready() -> void:
	_current_language = RunState.menu_language if RunState.menu_language != "" else "en"
	_current_mode = RunState.game_mode if RunState.game_mode != "" else "campaign"
	_difficulty_buttons = [recruit_button, standard_button, veteran_button, brutal_button, nightmare_button, custom_button]
	credits_slider.value_changed.connect(func(_value: float) -> void: _refresh_custom_labels())
	base_hp_slider.value_changed.connect(func(_value: float) -> void: _refresh_custom_labels())
	enemy_speed_slider.value_changed.connect(func(_value: float) -> void: _refresh_custom_labels())
	enemy_health_slider.value_changed.connect(func(_value: float) -> void: _refresh_custom_labels())
	target_wave_slider.value_changed.connect(func(_value: float) -> void: _refresh_custom_labels())
	settings_master_volume_slider.value_changed.connect(func(value: float) -> void: settings_master_volume_value_label.text = "%d%%" % int(round(value * 100.0)))
	settings_music_volume_slider.value_changed.connect(func(value: float) -> void: settings_music_volume_value_label.text = "%d%%" % int(round(value * 100.0)))
	settings_sfx_volume_slider.value_changed.connect(func(value: float) -> void: settings_sfx_volume_value_label.text = "%d%%" % int(round(value * 100.0)))
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
	tower_category_button.pressed.connect(func() -> void: _set_content_category("tower"))
	commander_category_button.pressed.connect(func() -> void: _set_content_category("commander"))
	enemy_category_button.pressed.connect(func() -> void: _set_content_category("enemy"))
	prev_content_button.pressed.connect(func() -> void: _step_content(-1))
	next_content_button.pressed.connect(func() -> void: _step_content(1))
	commander_prev_button.pressed.connect(func() -> void: _step_commander(-1))
	commander_next_button.pressed.connect(func() -> void: _step_commander(1))
	commander_confirm_button.pressed.connect(_confirm_start_game)
	commander_cancel_button.pressed.connect(_toggle_commander_dialog)
	start_button.pressed.connect(_start_game)
	quit_button.pressed.connect(func() -> void: get_tree().quit())
	settings_master_volume_slider.value = RunState.master_volume
	settings_music_volume_slider.value = RunState.music_volume
	settings_sfx_volume_slider.value = RunState.sfx_volume
	settings_fullscreen_button.button_pressed = RunState.fullscreen_enabled
	AudioManager.set_master_volume(RunState.master_volume)
	AudioManager.set_music_volume(RunState.music_volume)
	AudioManager.set_sfx_volume(RunState.sfx_volume)
	AudioManager.set_fullscreen(RunState.fullscreen_enabled)
	settings_master_volume_value_label.text = "%d%%" % int(round(RunState.master_volume * 100.0))
	settings_music_volume_value_label.text = "%d%%" % int(round(RunState.music_volume * 100.0))
	settings_sfx_volume_value_label.text = "%d%%" % int(round(RunState.sfx_volume * 100.0))
	_refresh_custom_labels()
	_selected_commander_index = _find_commander_index(RunState.selected_commander_id)
	_apply_language()
	_set_mode(_current_mode)
	_select_difficulty(_selected_difficulty_index)
	_refresh_content_browser()
	_refresh_commander_dialog()
	_refresh_selected_commander_summary()
	resized.connect(_update_scroll_bounds)
	get_viewport().size_changed.connect(_update_scroll_bounds)
	call_deferred("_update_scroll_bounds")

func _process(delta: float) -> void:
	_pulse_time += delta
	var glow_alpha := 0.14 + sin(_pulse_time * 0.35) * 0.015
	back_glow.modulate = Color(0.28, 0.44, 0.52, glow_alpha)
	sweep_line.position.x = -260.0 + fmod(_pulse_time * 38.0, size.x + 520.0)
	menu_panel.scale = Vector2.ONE

func _unhandled_input(event: InputEvent) -> void:
	if commander_dialog.visible or $SettingsOverlay.visible:
		return
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_set_scroll_offset(_scroll_offset - MENU_SCROLL_STEP)
			get_viewport().set_input_as_handled()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_set_scroll_offset(_scroll_offset + MENU_SCROLL_STEP)
			get_viewport().set_input_as_handled()

func _update_scroll_bounds() -> void:
	await get_tree().process_frame
	_max_scroll_offset = maxf(0.0, root_vbox.get_combined_minimum_size().y - margin_root.size.y)
	_set_scroll_offset(_scroll_offset)

func _set_scroll_offset(value: float) -> void:
	_scroll_offset = clampf(value, 0.0, _max_scroll_offset)
	root_vbox.position.y = -_scroll_offset

func _set_language(language: String) -> void:
	_current_language = language
	RunState.menu_language = language
	language_en_button.button_pressed = language == "en"
	language_de_button.button_pressed = language == "de"
	language_en_button.modulate = UI_BUTTON_ACTIVE if language == "en" else UI_BUTTON_IDLE
	language_de_button.modulate = UI_BUTTON_ACTIVE if language == "de" else UI_BUTTON_IDLE
	RunState.persist_profile()
	_apply_language()
	_select_difficulty(_selected_difficulty_index)

func _set_mode(mode: String) -> void:
	_current_mode = mode
	RunState.game_mode = mode
	mode_campaign_button.button_pressed = mode == "campaign"
	mode_endless_button.button_pressed = mode == "endless"
	mode_campaign_button.modulate = UI_BUTTON_ACTIVE if mode == "campaign" else UI_BUTTON_IDLE
	mode_endless_button.modulate = UI_BUTTON_ACTIVE_ENDLESS if mode == "endless" else UI_BUTTON_IDLE
	custom_panel.visible = _is_custom_selected() and _current_mode == "campaign"
	RunState.persist_profile()
	_select_difficulty(_selected_difficulty_index)

func _toggle_settings() -> void:
	$SettingsOverlay.visible = not $SettingsOverlay.visible

func _apply_settings() -> void:
	RunState.apply_settings(settings_master_volume_slider.value, settings_music_volume_slider.value, settings_sfx_volume_slider.value, settings_fullscreen_button.button_pressed)
	AudioManager.set_master_volume(RunState.master_volume)
	AudioManager.set_music_volume(RunState.music_volume)
	AudioManager.set_sfx_volume(RunState.sfx_volume)
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
	settings_master_volume_label.text = _text("master_volume")
	settings_music_volume_label.text = _text("music_volume")
	settings_sfx_volume_label.text = _text("sfx_volume")
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
	content_browser_title_label.text = _text("content_browser")
	tower_category_button.text = _text("content_towers")
	commander_category_button.text = _text("content_commander")
	enemy_category_button.text = _text("content_enemies")
	prev_content_button.text = _text("content_prev")
	next_content_button.text = _text("content_next")
	commander_title_label.text = _text("commander_select_title")
	commander_hint_label.text = _text("commander_select_hint")
	selected_commander_title_label.text = _text("selected_commander")
	commander_prev_button.text = _text("content_prev")
	commander_next_button.text = _text("content_next")
	commander_confirm_button.text = _text("commander_confirm")
	commander_cancel_button.text = _text("commander_cancel")
	start_button.text = _text("start")
	quit_button.text = _text("quit")
	for i in range(DIFFICULTIES.size()):
		var difficulty_id: String = String(DIFFICULTIES[i].get("id", ""))
		var label_text: String = _localized_value(DIFFICULTIES[i].get("name", ""))
		if not RunState.can_select_difficulty(difficulty_id):
			label_text = "🔒 " + label_text
		_difficulty_buttons[i].text = label_text
	if _tooltip_locked_to_selection:
		_restore_selected_tooltip()
	_refresh_content_browser()
	_refresh_commander_dialog()
	_refresh_selected_commander_summary()
	call_deferred("_update_scroll_bounds")

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
		var unlocked: bool = RunState.can_select_difficulty(difficulty_id)
		button.button_pressed = i == _selected_difficulty_index and unlocked
		button.modulate = _get_button_color(i, i == _selected_difficulty_index and unlocked, not unlocked)
		button.disabled = false
		button.tooltip_text = "" if unlocked else "🔒"
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

func _get_button_color(index: int, active: bool, locked: bool = false) -> Color:
	if locked:
		return UI_BUTTON_LOCKED
	match index:
		0:
			return Color(0.86, 0.98, 0.90, 1.0) if active else Color(0.80, 0.90, 0.84, 0.94)
		1:
			return Color(0.86, 0.94, 1.0, 1.0) if active else Color(0.80, 0.86, 0.92, 0.94)
		2:
			return Color(0.88, 0.90, 1.0, 1.0) if active else Color(0.82, 0.84, 0.92, 0.94)
		3:
			return Color(1.0, 0.88, 0.84, 1.0) if active else Color(0.92, 0.82, 0.78, 0.94)
		4:
			return Color(1.0, 0.82, 0.82, 1.0) if active else Color(0.92, 0.78, 0.78, 0.94)
		_:
			return Color(0.96, 0.92, 0.82, 1.0) if active else Color(0.90, 0.86, 0.78, 0.94)

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

func _set_content_category(category: String) -> void:
	_content_category = category
	_content_index = 0
	_refresh_content_browser()

func _step_content(step: int) -> void:
	var entries: Array = _get_content_entries_for_category()
	if entries.is_empty():
		return
	_content_index = posmod(_content_index + step, entries.size())
	_refresh_content_browser()

func _get_content_entries_for_category() -> Array:
	match _content_category:
		"commander":
			return MVP_COMMANDERS
		"enemy":
			return MVP_ENEMIES
		_:
			return MVP_TOWERS

func _refresh_content_browser() -> void:
	var entries: Array = _get_content_entries_for_category()
	tower_category_button.button_pressed = _content_category == "tower"
	commander_category_button.button_pressed = _content_category == "commander"
	enemy_category_button.button_pressed = _content_category == "enemy"
	tower_category_button.modulate = UI_BUTTON_ACTIVE if _content_category == "tower" else UI_BUTTON_IDLE
	commander_category_button.modulate = UI_BUTTON_ACTIVE if _content_category == "commander" else UI_BUTTON_IDLE
	enemy_category_button.modulate = UI_BUTTON_ACTIVE_ENDLESS if _content_category == "enemy" else UI_BUTTON_IDLE
	if entries.is_empty():
		content_name_label.text = ""
		content_summary_label.text = ""
		content_stats_label.text = ""
		return
	_content_index = clampi(_content_index, 0, entries.size() - 1)
	var content = entries[_content_index]
	content_name_label.text = content.get_localized_display_name(_current_language)
	content_summary_label.text = "%s\n\n%s" % [content.get_localized_short_description(_current_language), content.get_localized_description(_current_language)]
	content_stats_label.text = _format_content_stats(content)

func _format_content_stats(content) -> String:
	if content == null:
		return ""
	var category: String = String(content.get("category"))
	match category:
		"tower":
			return _format_tower_stats(content)
		"enemy":
			return _format_enemy_stats(content)
		"commander":
			return _format_commander_stats(content)
		_:
			return ""

func _format_role_value(content) -> String:
	if content == null:
		return ""
	var stats: Dictionary = content.get_gameplay_stats() if content.has_method("get_gameplay_stats") else {}
	return _localize_role(str(stats.get("role", "-")))

func _format_tags(content) -> String:
	if content == null:
		return ""
	var tags: PackedStringArray = content.tags if content.get("tags") != null else PackedStringArray()
	return ", ".join(tags)

func _localize_role(role: String) -> String:
	if _current_language != "de":
		return role.replace("_", " ").capitalize()
	var localized_roles := {
		"cheap generalist": "Günstiger Generalist",
		"anti-armor / elite killer": "Anti-Panzer / Elite-Killer",
		"anti-swarm / choke tower": "Anti-Schwarm / Engpass-Turm",
		"support / scan": "Support / Aufklärung",
		"indirect fire / aoe": "Indirektes Feuer / Fläche",
		"standard swarm enemy": "Standard-Schwarmgegner",
		"fast mover / gap punisher": "Schneller Durchbrecher",
		"tank / front breaker": "Tank / Frontbrecher",
		"support buffer": "Support-Verstärker",
		"boss / siege monster": "Boss / Belagerungsmonster",
	}
	return String(localized_roles.get(role.to_lower(), role.replace("_", " ").capitalize()))

func _format_tower_stats(content) -> String:
	var lines := [
		"%s: %s" % [_text("stat_role"), _format_role_value(content)],
		"%s: %d" % [_text("stat_cost"), int(content.tower_cost)],
		"%s: %.0f" % [_text("stat_damage"), content.damage],
		"%s: %.2f/s" % [_text("stat_rate"), content.fire_rate],
		"%s: %.1f" % [_text("stat_range"), content.attack_range],
	]
	if content.adjacency_fire_rate_bonus > 0.0:
		lines.append("%s: +%d%% %s" % [_text("stat_formation_link"), int(round(content.adjacency_fire_rate_bonus * 100.0)), _text("stat_rate").to_lower()])
	if content.damage_bonus_vs_elite > 0.0 or content.damage_bonus_vs_boss > 0.0:
		lines.append("%s: +%d%% %s | +%d%% %s" % [_text("stat_priority_damage"), int(round(content.damage_bonus_vs_elite * 100.0)), _text("stat_elite").to_lower(), int(round(content.damage_bonus_vs_boss * 100.0)), _text("stat_boss").to_lower()])
	if content.splash_radius > 0.0:
		lines.append("%s: %.0f Radius | %d%% %s" % [_text("stat_splash"), content.splash_radius, int(round(content.splash_damage_multiplier * 100.0)), _text("stat_damage").to_lower()])
	if content.support_aura_radius > 0.0:
		lines.append("%s: %.0f Radius | +%d%% %s | +%d%% %s" % [_text("stat_relay_aura"), content.support_aura_radius, int(round(content.support_fire_rate_bonus * 100.0)), _text("stat_rate").to_lower(), int(round(content.support_range_bonus * 100.0)), _text("stat_range").to_lower()])
	if content.extra_stats.has("special_rule"):
		lines.append("%s: %s" % [_text("stat_rule"), str(content.extra_stats["special_rule"])])
	if content.tags.size() > 0:
		lines.append("%s: %s" % [_text("stat_tags"), _format_tags(content)])
	return "\n".join(lines)

func _format_enemy_stats(content) -> String:
	var lines := [
		"%s: %s" % [_text("stat_role"), _format_role_value(content)],
		"%s: %.0f" % [_text("stat_health"), content.max_health],
		"%s: %.1f" % [_text("stat_speed"), content.move_speed],
		"%s: %.0f" % [_text("stat_armor"), content.armor],
		"%s: %d" % [_text("stat_leak_damage"), int(content.fortress_damage)],
		"%s: %d" % [_text("stat_bounty"), int(content.credit_reward)],
	]
	if content.is_elite:
		lines.append("%s: %s" % [_text("stat_threat_class"), _text("stat_elite")])
	if content.is_boss:
		lines.append("%s: %s" % [_text("stat_threat_class"), _text("stat_boss")])
	if content.extra_stats.has("special_rule"):
		lines.append("%s: %s" % [_text("stat_rule"), str(content.extra_stats["special_rule"])])
	if content.tags.size() > 0:
		lines.append("%s: %s" % [_text("stat_tags"), _format_tags(content)])
	return "\n".join(lines)

func _format_commander_stats(content) -> String:
	var lines := [
		"%s: %s" % [_text("stat_role"), _format_role_value(content)],
		"%s: %.0f" % [_text("stat_move_speed"), content.move_speed],
		"%s: %.0f" % [_text("stat_damage"), content.damage],
		"%s: %.2f/s" % [_text("stat_rate"), content.fire_rate],
		"%s: %.0f" % [_text("stat_range"), content.attack_range],
		"%s: %.0fs | CD %.0fs | Radius %.0f" % [_text("stat_overwatch"), content.overwatch_duration, content.overwatch_cooldown, content.overwatch_radius],
	]
	if content.extra_stats.has("ability_description"):
		lines.append("%s: %s" % [_text("stat_ability"), str(content.extra_stats["ability_description"])])
	elif content.has_method("get_localized_ability_description"):
		lines.append("%s: %s" % [_text("stat_ability"), content.get_localized_ability_description(_current_language)])
	if content.tags.size() > 0:
		lines.append("%s: %s" % [_text("stat_tags"), _format_tags(content)])
	return "\n".join(lines)

func _refresh_selected_commander_summary() -> void:
	var selected_data = null
	for option in COMMANDER_OPTIONS:
		if String(option.get("id", "")) == RunState.selected_commander_id:
			selected_data = option.get("data")
			break
	var summary := ""
	if selected_data != null:
		summary = selected_data.get_localized_short_description(_current_language)
	selected_commander_value_label.text = "%s\n%s\n\n%s" % [RunState.get_selected_commander_name(), _text("commander_card_hint"), summary]
	selected_commander_title_label.add_theme_color_override("font_color", Color(0.86, 0.96, 1.0))
	selected_commander_value_label.add_theme_color_override("font_color", Color(0.92, 0.95, 0.98))

func _find_commander_index(commander_id: String) -> int:
	for i in range(COMMANDER_OPTIONS.size()):
		if String(COMMANDER_OPTIONS[i].get("id", "")) == commander_id:
			return i
	return 0

func _toggle_commander_dialog() -> void:
	commander_dialog.visible = not commander_dialog.visible
	if commander_dialog.visible:
		_refresh_commander_dialog()

func _step_commander(step: int) -> void:
	if COMMANDER_OPTIONS.is_empty():
		return
	_selected_commander_index = posmod(_selected_commander_index + step, COMMANDER_OPTIONS.size())
	_refresh_commander_dialog()

func _refresh_commander_dialog() -> void:
	if COMMANDER_OPTIONS.is_empty():
		commander_name_label.text = ""
		commander_summary_label.text = ""
		commander_stats_label.text = ""
		return
	_selected_commander_index = clampi(_selected_commander_index, 0, COMMANDER_OPTIONS.size() - 1)
	var commander_option: Dictionary = COMMANDER_OPTIONS[_selected_commander_index]
	var commander_data = commander_option.get("data")
	var localized_name: String = commander_data.get_localized_display_name(_current_language)
	var is_current: bool = String(commander_option.get("id", "")) == RunState.selected_commander_id
	commander_name_label.text = ("✓ " if is_current else "") + localized_name
	commander_summary_label.text = "%s\n\n%s\n\n%s" % [commander_data.get_localized_short_description(_current_language), commander_data.get_localized_description(_current_language), _text("commander_dialog_current") if is_current else ""]
	commander_stats_label.text = _format_content_stats(commander_data)
	commander_name_label.add_theme_color_override("font_color", Color(0.92, 1.0, 0.94) if is_current else Color(0.88, 0.92, 0.96))
	commander_summary_label.add_theme_color_override("font_color", Color(0.88, 0.98, 0.92) if is_current else Color(0.84, 0.88, 0.92))
	commander_confirm_button.modulate = Color(0.22, 0.52, 0.34, 1.0) if is_current else Color(0.20, 0.36, 0.48, 1.0)
	commander_prev_button.modulate = Color(0.90, 0.98, 0.92, 1.0) if is_current else UI_BUTTON_IDLE
	commander_next_button.modulate = Color(0.90, 0.98, 0.92, 1.0) if is_current else UI_BUTTON_IDLE

func _start_game() -> void:
	commander_dialog.visible = true
	_refresh_commander_dialog()

func _confirm_start_game() -> void:
	var run_config := _get_selected_config()
	if not COMMANDER_OPTIONS.is_empty():
		run_config["commander_id"] = String(COMMANDER_OPTIONS[_selected_commander_index].get("id", RunState.DEFAULT_COMMANDER_ID))
	RunState.configure_difficulty(run_config)
	_refresh_selected_commander_summary()
	get_tree().paused = false
	SceneRouter.goto_scene(GAME_ROOT_SCENE)
