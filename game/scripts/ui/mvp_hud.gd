extends Control

@onready var credits_label: Label = $Panel/VBoxContainer/CreditsLabel
@onready var wave_label: Label = $Panel/VBoxContainer/WaveLabel
@onready var base_label: Label = $Panel/VBoxContainer/BaseLabel
@onready var mode_label: Label = $Panel/VBoxContainer/ModeLabel
@onready var hint_label: Label = $Panel/VBoxContainer/HintLabel

func _process(_delta: float) -> void:
	credits_label.text = "Credits: %d" % RunState.credits
	wave_label.text = "Wave: %d" % RunState.current_wave
	base_label.text = "Base HP: %d" % RunState.base_hp
	mode_label.text = "Build Mode: %s" % ("Basic Tower" if GameState.selected_tower_id != "" else "Off")
	hint_label.text = "1 = arm tower | Left Click = place | Right Click = cancel | WASD = commander"
