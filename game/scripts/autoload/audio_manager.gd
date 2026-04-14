extends Node

func play_ui_click() -> void:
	pass

func set_master_volume(normalized_volume: float) -> void:
	_set_bus_volume("Master", normalized_volume)

func set_music_volume(normalized_volume: float) -> void:
	_set_bus_volume("Music", normalized_volume)

func set_sfx_volume(normalized_volume: float) -> void:
	_set_bus_volume("SFX", normalized_volume)

func set_fullscreen(enabled: bool) -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if enabled else DisplayServer.WINDOW_MODE_WINDOWED)

func _set_bus_volume(bus_name: String, normalized_volume: float) -> void:
	var bus_index: int = AudioServer.get_bus_index(bus_name)
	if bus_index < 0:
		if bus_name != "Master":
			return
		bus_index = 0
	var clamped: float = clampf(normalized_volume, 0.0, 1.0)
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(maxf(clamped, 0.001)))
