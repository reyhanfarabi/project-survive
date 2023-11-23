extends Area2D


@export var _entity: Resource_Entity
@export var _speed: int = 50
@export var _attack_cooldown: int = 2
@export var _target_distance_padding: int = 1

@onready var _player = get_parent().get_node("Player")

var _direction: Vector2
var _can_attack: bool = true


func _ready():
	_start()


func _start():
	$AttackTimer.wait_time = _attack_cooldown


func _process(delta):
	_direction = Vector2(_player.position - position).normalized()
	_handle_movement(delta)
	_handle_facing()
	_handle_attack_to_player()


func _handle_movement(delta):
	if (position.distance_to(_player.position) > _target_distance_padding):
		position += _direction * _speed * delta


func _handle_facing():
	if _direction.x > 0:
		$Sprite2D.flip_h = false
	elif _direction.x < 0:
		$Sprite2D.flip_h = true


func _handle_attack_to_player():
	if not _can_attack or not overlaps_body(_player):
		return
	_can_attack = false
	$AttackTimer.start()


func _on_attack_timer_timeout():
	_can_attack = true
