extends Node2D

signal defeated(enemy: Node)
signal reached_goal(enemy: Node)

@export var max_health: float = 30.0
@export var move_speed: float = 110.0
@export var fortress_damage: int = 1
@export var credit_reward: int = 15

var health: float
var progress: float = 0.0
var curve: Curve2D

func _ready() -> void:
	health = max_health
	add_to_group("enemies")

func setup(path_curve: Curve2D) -> void:
	curve = path_curve
	progress = 0.0
	_update_position()

func _process(delta: float) -> void:
	if curve == null:
		return
	progress += move_speed * delta
	var length := curve.get_baked_length()
	if progress >= length:
		reached_goal.emit(self)
		queue_free()
		return
	_update_position()

func apply_damage(amount: float) -> void:
	health -= amount
	if health <= 0.0:
		defeated.emit(self)
		queue_free()

func _update_position() -> void:
	global_position = curve.sample_baked(progress)
