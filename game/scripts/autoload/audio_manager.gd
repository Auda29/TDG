extends Node

func play_ui_click() -> void:
	pass

func set_master_volume(normalized_volume: float) -> void:
	var clamped: float = clampf(normalized_volume, 0.0, 1.0)
	var db_value: float = linear_to_db(maxf(clamped, 0.001))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), db_value)

func set_fullscreen(enabled: bool) -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if enabled else DisplayServer.WINDOW_MODE_WINDOWED)
