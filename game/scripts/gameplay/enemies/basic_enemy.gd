extends Node2D

signal defeated(enemy: Node)
signal reached_goal(enemy: Node)

@export var max_health: float = 30.0
@export var move_speed: float = 110.0
@export var fortress_damage: int = 1
@export var credit_reward: int = 15
@export var armor: float = 0.0

var health: float
var progress: float = 0.0
var curve: Curve2D
var _hit_flash: float = 0.0

func _ready() -> void:
	health = max_health
	add_to_group("enemies")

func setup(path_curve: Curve2D, speed_multiplier: float = 1.0, health_multiplier: float = 1.0) -> void:
	curve = path_curve
	move_speed *= speed_multiplier
	max_health *= health_multiplier
	health = max_health
	progress = 0.0
	_update_position()

func _process(delta: float) -> void:
	_hit_flash = maxf(0.0, _hit_flash - delta * 5.0)
	if curve == null:
		return
	progress += move_speed * delta
	var length := curve.get_baked_length()
	if progress >= length:
		reached_goal.emit(self)
		queue_free()
		return
	_update_position()
	queue_redraw()

func apply_damage(amount: float) -> void:
	var reduced_amount := maxf(1.0, amount - armor)
	health -= reduced_amount
	_hit_flash = 1.0
	queue_redraw()
	if health <= 0.0:
		defeated.emit(self)
		queue_free()

func _update_position() -> void:
	global_position = curve.sample_baked(progress)

func _draw() -> void:
	var health_ratio := clampf(health / maxf(1.0, max_health), 0.0, 1.0)
	var bar_width := 30.0
	var bar_height := 5.0
	var bar_pos := Vector2(-bar_width * 0.5, -28.0)
	draw_rect(Rect2(bar_pos, Vector2(bar_width, bar_height)), Color(0.08, 0.08, 0.08, 0.9), true)
	draw_rect(Rect2(bar_pos, Vector2(bar_width * health_ratio, bar_height)), Color(0.25, 0.9, 0.35, 0.95), true)
	if _hit_flash > 0.0:
		draw_circle(Vector2.ZERO, 18.0, Color(1.0, 1.0, 1.0, 0.10 * _hit_flash))
