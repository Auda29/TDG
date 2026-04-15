extends Node

const DEFAULT_DIFFICULTY_ID := "standard"
const DEFAULT_DIFFICULTY_NAME := "Standard"
const DEFAULT_TARGET_WAVE := 12
const DEFAULT_GAME_MODE := "campaign"
const DEFAULT_LANGUAGE := "en"
const SAVE_PATH := "user://profile.cfg"
const PROFILE_VERSION := 3
const DEFAULT_UNLOCKED_DIFFICULTIES: Array[String] = ["recruit", "standard", "custom"]
const DEFAULT_COMMANDER_ID := "legion_prefect"
const LEGION_PREFECT_DATA := preload("res://data/mvp/commander/legion_prefect.tres")
const COMMANDER_DISPLAY_DATA := {
	"legion_prefect": LEGION_PREFECT_DATA,
}

const DIFFICULTY_UNLOCKS := {
	"recruit": "",
	"standard": "",
	"veteran": "standard",
	"brutal": "veteran",
	"nightmare": "brutal",
	"custom": "",
}

const TEXTS := {
	"en": {
		"difficulty": "Difficulty", "objective": "Objective", "wave_reached": "Wave reached", "enemies_defeated": "Enemies defeated", "credits_remaining": "Credits remaining", "survival_time": "Survival time",
		"objective_endless": "Endless", "objective_free_mode": "Free Mode", "objective_target_wave": "Target wave: %d",
		"build_mode_off": "Off", "placement_build_off": "Build off", "hint_gameplay": "1/3 or buttons = build | LMB = place/select | Select commander to move | RMB = cancel | Right panel = tower actions | X/T optional | 2 = Overwatch",
		"commander_offline": "Commander: offline", "commander_active": "Commander: active", "commander_ready": "Commander: Overwatch READY", "commander_active_timer": "Commander: Overwatch ACTIVE %.1fs", "commander_cooldown": "Commander: Overwatch %.1fs",
		"selected_tower": "Selected Tower", "defense_unit": "Defense Unit", "no_tower_selected": "No tower selected", "targeting": "◎ Targeting",
		"build": "Build", "wave_control": "Wave Control", "tower_actions": "Tower Actions", "upgrade_slots": "Upgrade Slots", "build_mode": "Build Mode: %s", "placement": "Placement: %s", "boss_name": "[BOSS] %s", "auto_next_wave": "Auto Next Wave", "start_next_wave": "Start Next Wave",
		"credits": "Credits: %d", "wave": "Wave: %d", "base_hp": "Base HP: %d", "resume": "Resume", "pause": "Pause", "restart_run": "Restart Run", "return_to_menu": "Return to Menu", "continue_free_mode": "Continue Free Mode",
		"victory": "VICTORY", "game_over": "GAME OVER", "target_secured": "Target secured", "base_integrity_collapsed": "Base integrity collapsed", "victory_hint": "Continue into Free Mode, restart, or return to menu", "defeat_hint": "Press R, restart, or return to menu",
		"ready": "Ready", "blocked_outside_build_zone": "Blocked: outside build zone", "blocked_lane": "Blocked: too close to lane", "blocked_tower": "Blocked: too close to tower", "blocked_credits": "Blocked: not enough credits", "blocked": "Blocked",
		"not_enough_credits": "Not enough credits", "tower_placed": "Tower placed", "commander_repositioned": "Commander repositioned", "base_hit": "Base hit -%d", "credits_gain": "+%d credits", "overwatch_active": "Overwatch active",
		"boss_approaching": "[!!!] BOSS APPROACHING", "boss_enter_lane": "Siegebreaker-class shellback entering lane", "boss_priority": "[BOSS] Priority target in lane", "elite_contact": "[!] ELITE CONTACT", "elite_enter_lane": "Shellback Brute entering lane", "elite_pressure": "[BRUTE] Elite pressure detected",
		"boss_terminated": "BOSS TERMINATED", "boss_neutralized": "Siegebreaker neutralized", "boss_clear": "[CLEAR] Boss signature eliminated", "fortress_lost": "FORTRESS LOST", "run_over_restart": "Run over - press R to restart", "failure_base": "[FAILURE] Base integrity collapsed",
		"objective_secured": "OBJECTIVE SECURED", "target_wave_cleared": "Target wave %d cleared - Free Mode unlocked", "victory_continue": "[VICTORY] Continue or return to command", "wave_cleared_bonus": "Wave cleared +%d", "wave_cleared_manual": "Wave cleared - click Start Next Wave", "wave_banner": "WAVE %d", "pressure_rising": "Carrion pressure rising",
		"tower_selected": "Tower selected", "targeting_mode": "Targeting: %s", "tower_sold": "Tower sold +%d", "commander_selected": "Commander selected", "selected_tower_status": "Selected tower | Use right panel for targeting and sell", "commander_selected_status": "Commander selected | LMB move | 2 Overwatch",
		"free_mode_banner": "FREE MODE", "free_mode_continue": "Objective complete - survival can continue indefinitely", "free_mode_manual": "Objective complete - start the next wave when ready",
		"line_defense": "Line Defense", "siege_battery": "Siege Battery", "tower_control": "%s Control", "sell_tower": "Sell Tower (+%d)", "tower_stats": "Damage: %.1f\nDPS: %.1f\nDamage dealt: %.0f\nKills: %d\nRange: %.0f\nFire rate: %.2f\nSell refund: +%d",
		"settings": "Settings", "master_volume": "Master Volume", "music_volume": "Music Volume", "sfx_volume": "SFX Volume", "fullscreen": "Fullscreen", "apply": "Apply", "close": "Close", "locked_requires": "Locked: requires victory on %s",
	},
	"de": {
		"difficulty": "Schwierigkeit", "objective": "Ziel", "wave_reached": "Erreichte Welle", "enemies_defeated": "Besiegte Gegner", "credits_remaining": "Verbleibende Credits", "survival_time": "Überlebenszeit",
		"objective_endless": "Endlos", "objective_free_mode": "Freier Modus", "objective_target_wave": "Zielwelle: %d",
		"build_mode_off": "Aus", "placement_build_off": "Bauen aus", "hint_gameplay": "1/3 oder Buttons = bauen | LMB = platzieren/auswählen | Commander auswählen zum Bewegen | RMB = abbrechen | Rechtes Panel = Turmaktionen | X/T optional | 2 = Overwatch",
		"commander_offline": "Commander: offline", "commander_active": "Commander: aktiv", "commander_ready": "Commander: Overwatch BEREIT", "commander_active_timer": "Commander: Overwatch AKTIV %.1fs", "commander_cooldown": "Commander: Overwatch %.1fs",
		"selected_tower": "Ausgewählter Turm", "defense_unit": "Verteidigungseinheit", "no_tower_selected": "Kein Turm ausgewählt", "targeting": "◎ Zielmodus",
		"build": "Bauen", "wave_control": "Wellensteuerung", "tower_actions": "Turmaktionen", "upgrade_slots": "Upgrade-Slots", "build_mode": "Bau-Modus: %s", "placement": "Platzierung: %s", "boss_name": "[BOSS] %s", "auto_next_wave": "Nächste Welle automatisch", "start_next_wave": "Nächste Welle starten",
		"credits": "Credits: %d", "wave": "Welle: %d", "base_hp": "Basis-HP: %d", "resume": "Fortsetzen", "pause": "Pause", "restart_run": "Run neu starten", "return_to_menu": "Zurück zum Menü", "continue_free_mode": "Freien Modus fortsetzen",
		"victory": "SIEG", "game_over": "GAME OVER", "target_secured": "Ziel gesichert", "base_integrity_collapsed": "Basisintegrität zusammengebrochen", "victory_hint": "Freien Modus fortsetzen, neu starten oder zum Menü zurückkehren", "defeat_hint": "Drücke R, starte neu oder kehre zum Menü zurück",
		"ready": "Bereit", "blocked_outside_build_zone": "Blockiert: außerhalb der Bauzone", "blocked_lane": "Blockiert: zu nah an der Lane", "blocked_tower": "Blockiert: zu nah an einem Turm", "blocked_credits": "Blockiert: nicht genug Credits", "blocked": "Blockiert",
		"not_enough_credits": "Nicht genug Credits", "tower_placed": "Turm platziert", "commander_repositioned": "Commander verlegt", "base_hit": "Basis getroffen -%d", "credits_gain": "+%d Credits", "overwatch_active": "Overwatch aktiv",
		"boss_approaching": "[!!!] BOSS NÄHERT SICH", "boss_enter_lane": "Belagerer-Klasse betritt die Lane", "boss_priority": "[BOSS] Prioritätsziel in der Lane", "elite_contact": "[!] ELITEKONTAKT", "elite_enter_lane": "Shellback-Brute betritt die Lane", "elite_pressure": "[BRUTE] Elitedruck erkannt",
		"boss_terminated": "BOSS ELIMINIERT", "boss_neutralized": "Belagerer neutralisiert", "boss_clear": "[CLEAR] Boss-Signal eliminiert", "fortress_lost": "FESTUNG VERLOREN", "run_over_restart": "Run vorbei - drücke R zum Neustart", "failure_base": "[FAILURE] Basisintegrität zusammengebrochen",
		"objective_secured": "ZIEL GESICHERT", "target_wave_cleared": "Zielwelle %d geschafft - Freier Modus freigeschaltet", "victory_continue": "[SIEG] Fortsetzen oder zum Kommando zurück", "wave_cleared_bonus": "Welle geschafft +%d", "wave_cleared_manual": "Welle geschafft - klicke auf Nächste Welle starten", "wave_banner": "WELLE %d", "pressure_rising": "Carrion-Druck steigt",
		"tower_selected": "Turm ausgewählt", "targeting_mode": "Zielmodus: %s", "tower_sold": "Turm verkauft +%d", "commander_selected": "Commander ausgewählt", "selected_tower_status": "Turm ausgewählt | Rechtes Panel für Zielmodus und Verkauf", "commander_selected_status": "Commander ausgewählt | LMB bewegen | 2 Overwatch",
		"free_mode_banner": "FREIER MODUS", "free_mode_continue": "Ziel erfüllt - Überleben kann unbegrenzt weitergehen", "free_mode_manual": "Ziel erfüllt - starte die nächste Welle, wenn du bereit bist",
		"line_defense": "Linienverteidigung", "siege_battery": "Belagerungsbatterie", "tower_control": "%s Steuerung", "sell_tower": "Turm verkaufen (+%d)", "tower_stats": "Schaden: %.1f\nDPS: %.1f\nVerursachter Schaden: %.0f\nKills: %d\nReichweite: %.0f\nFeuerrate: %.2f\nVerkaufswert: +%d",
		"settings": "Einstellungen", "master_volume": "Master-Lautstärke", "music_volume": "Musik-Lautstärke", "sfx_volume": "SFX-Lautstärke", "fullscreen": "Vollbild", "apply": "Anwenden", "close": "Schließen", "locked_requires": "Gesperrt: benötigt Sieg auf %s",
	},
}

var credits: int = 0
var current_wave: int = 0
var commander_down: bool = false
var base_hp: int = 20
var is_run_over: bool = false
var enemies_defeated: int = 0
var elapsed_run_time: float = 0.0

var starting_credits: int = 300
var starting_base_hp: int = 20
var difficulty_id: String = DEFAULT_DIFFICULTY_ID
var difficulty_name: String = DEFAULT_DIFFICULTY_NAME
var enemy_speed_multiplier: float = 1.0
var enemy_health_multiplier: float = 1.0
var target_wave: int = DEFAULT_TARGET_WAVE
var end_state: String = ""
var free_mode_active: bool = false
var game_mode: String = DEFAULT_GAME_MODE
var menu_language: String = DEFAULT_LANGUAGE
var master_volume: float = 1.0
var music_volume: float = 1.0
var sfx_volume: float = 1.0
var fullscreen_enabled: bool = false
var unlocked_difficulties: Array[String] = ["recruit", "standard", "custom"]
var selected_commander_id: String = DEFAULT_COMMANDER_ID

func _ready() -> void:
	_load_profile()

func configure_difficulty(config: Dictionary) -> void:
	starting_credits = int(config.get("starting_credits", 300))
	starting_base_hp = int(config.get("starting_base_hp", 20))
	difficulty_id = String(config.get("id", DEFAULT_DIFFICULTY_ID))
	difficulty_name = String(config.get("name", DEFAULT_DIFFICULTY_NAME))
	enemy_speed_multiplier = float(config.get("enemy_speed_multiplier", 1.0))
	enemy_health_multiplier = float(config.get("enemy_health_multiplier", 1.0))
	target_wave = int(config.get("target_wave", DEFAULT_TARGET_WAVE))
	game_mode = String(config.get("game_mode", DEFAULT_GAME_MODE))
	menu_language = String(config.get("language", menu_language))
	selected_commander_id = String(config.get("commander_id", selected_commander_id))
	_save_profile()

func reset_for_new_run() -> void:
	credits = starting_credits
	current_wave = 0
	commander_down = false
	base_hp = starting_base_hp
	is_run_over = false
	enemies_defeated = 0
	elapsed_run_time = 0.0
	end_state = ""
	free_mode_active = game_mode == "endless"

func add_elapsed_time(delta: float) -> void:
	if is_run_over:
		return
	elapsed_run_time += maxf(0.0, delta)

func register_enemy_defeat() -> void:
	enemies_defeated += 1

func mark_defeat() -> void:
	is_run_over = true
	end_state = "defeat"

func mark_victory() -> void:
	is_run_over = true
	end_state = "victory"
	_unlock_next_difficulty()
	_save_profile()

func resume_free_mode() -> void:
	is_run_over = false
	end_state = ""
	free_mode_active = true

func is_target_wave_reached(completed_wave: int) -> bool:
	return game_mode == "campaign" and not free_mode_active and completed_wave >= target_wave

func get_run_stats_text() -> String:
	var objective_text: String
	if game_mode == "endless":
		objective_text = t("objective_endless")
	elif free_mode_active:
		objective_text = t("objective_free_mode")
	else:
		objective_text = t("objective_target_wave") % target_wave
	return "%s: %s\nCommander: %s\n%s: %s\n%s: %d\n%s: %d\n%s: %d\n%s: %s" % [t("difficulty"), difficulty_name, get_selected_commander_name(), t("objective"), objective_text, t("wave_reached"), current_wave, t("enemies_defeated"), enemies_defeated, t("credits_remaining"), credits, t("survival_time"), get_formatted_elapsed_time()]

func get_formatted_elapsed_time() -> String:
	var total_seconds: int = int(floor(elapsed_run_time))
	return "%02d:%02d" % [total_seconds / 60, total_seconds % 60]

func get_selected_commander_name() -> String:
	var commander_data = COMMANDER_DISPLAY_DATA.get(selected_commander_id)
	if commander_data != null:
		return commander_data.get_localized_display_name(menu_language)
	return selected_commander_id.capitalize().replace("_", " ")

func t(key: String) -> String:
	var lang_table: Dictionary = TEXTS.get(menu_language, TEXTS["en"])
	return String(lang_table.get(key, key))

func can_select_difficulty(id: String) -> bool:
	return unlocked_difficulties.has(id)

func get_required_difficulty_for(id: String) -> String:
	return String(DIFFICULTY_UNLOCKS.get(id, ""))

func get_locked_reason(id: String, localized_name: String) -> String:
	var required_id: String = get_required_difficulty_for(id)
	if required_id == "":
		return ""
	return t("locked_requires") % localized_name

func apply_settings(master: float, music: float, sfx: float, fullscreen: bool) -> void:
	master_volume = clampf(master, 0.0, 1.0)
	music_volume = clampf(music, 0.0, 1.0)
	sfx_volume = clampf(sfx, 0.0, 1.0)
	fullscreen_enabled = fullscreen
	_save_profile()

func persist_profile() -> void:
	_save_profile()

func can_afford(amount: int) -> bool:
	return credits >= amount

func spend_credits(amount: int) -> void:
	credits = max(0, credits - amount)

func gain_credits(amount: int) -> void:
	credits += max(0, amount)

func _unlock_next_difficulty() -> void:
	for difficulty_id_to_check in DIFFICULTY_UNLOCKS.keys():
		if DIFFICULTY_UNLOCKS[difficulty_id_to_check] == difficulty_id and not unlocked_difficulties.has(difficulty_id_to_check):
			unlocked_difficulties.append(difficulty_id_to_check)
	_normalize_unlocked_difficulties()

func _save_profile() -> void:
	_normalize_unlocked_difficulties()
	var config := ConfigFile.new()
	config.set_value("meta", "version", PROFILE_VERSION)
	config.set_value("profile", "language", menu_language)
	config.set_value("profile", "game_mode", game_mode)
	config.set_value("profile", "selected_commander_id", selected_commander_id)
	config.set_value("audio", "master_volume", master_volume)
	config.set_value("audio", "music_volume", music_volume)
	config.set_value("audio", "sfx_volume", sfx_volume)
	config.set_value("video", "fullscreen_enabled", fullscreen_enabled)
	config.set_value("progression", "unlocked_difficulties", unlocked_difficulties)
	config.save(SAVE_PATH)

func _load_profile() -> void:
	var config := ConfigFile.new()
	if config.load(SAVE_PATH) != OK:
		_normalize_unlocked_difficulties()
		return
	var profile_version: int = int(config.get_value("meta", "version", 1))
	menu_language = String(config.get_value("profile", "language", menu_language))
	game_mode = String(config.get_value("profile", "game_mode", game_mode))
	selected_commander_id = String(config.get_value("profile", "selected_commander_id", DEFAULT_COMMANDER_ID))
	if profile_version >= 2:
		master_volume = float(config.get_value("audio", "master_volume", master_volume))
		music_volume = float(config.get_value("audio", "music_volume", music_volume))
		sfx_volume = float(config.get_value("audio", "sfx_volume", sfx_volume))
		fullscreen_enabled = bool(config.get_value("video", "fullscreen_enabled", fullscreen_enabled))
		_set_unlocked_difficulties(config.get_value("progression", "unlocked_difficulties", DEFAULT_UNLOCKED_DIFFICULTIES))
	else:
		master_volume = float(config.get_value("profile", "master_volume", master_volume))
		music_volume = float(config.get_value("profile", "music_volume", music_volume))
		sfx_volume = float(config.get_value("profile", "sfx_volume", sfx_volume))
		fullscreen_enabled = bool(config.get_value("profile", "fullscreen_enabled", fullscreen_enabled))
		_set_unlocked_difficulties(config.get_value("profile", "unlocked_difficulties", DEFAULT_UNLOCKED_DIFFICULTIES))
	_normalize_unlocked_difficulties()
	if profile_version < PROFILE_VERSION:
		_save_profile()

func _set_unlocked_difficulties(values: Variant) -> void:
	unlocked_difficulties = []
	if values is Array:
		for value in values:
			unlocked_difficulties.append(String(value))

func _normalize_unlocked_difficulties() -> void:
	for base_id in DEFAULT_UNLOCKED_DIFFICULTIES:
		if not unlocked_difficulties.has(base_id):
			unlocked_difficulties.append(base_id)
