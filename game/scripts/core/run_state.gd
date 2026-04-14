extends Node

var credits: int = 0
var current_wave: int = 0
var commander_down: bool = false
var base_hp: int = 20

func reset_for_new_run(starting_credits: int, starting_base_hp: int) -> void:
	credits = starting_credits
	current_wave = 0
	commander_down = false
	base_hp = starting_base_hp

func can_afford(amount: int) -> bool:
	return credits >= amount

func spend_credits(amount: int) -> void:
	credits = max(0, credits - amount)

func gain_credits(amount: int) -> void:
	credits += max(0, amount)
