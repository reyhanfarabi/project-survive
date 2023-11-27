extends Area2D


@export var texture: CompressedTexture2D
@export var _entity: Resource_Entity
@export var _speed: int = 50
@export var _attack_cooldown: int = 2
@export var _target_distance_padding: int = 1
@export var _damage_shader_delay: float = 0.1
@export var _exp_drop_scene: PackedScene
@export var _exp: int

@onready var _player = get_parent().get_parent().get_node("Player")
@onready var _drops_container = get_parent().get_parent().get_node("DropsContainer")

var _direction: Vector2
var _can_attack: bool = true


func _ready():
	_start()


func _start():
	$Sprite2D.texture = texture
	$AttackTimer.wait_time = _attack_cooldown


func _process(delta):
	if not _player:
		return
	_direction = Vector2(_player.position - position).normalized()
	_handle_movement(delta)
	_handle_facing()
	_handle_attack_to_player()
	_handle_destory()


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
	_player.deal_damage(_entity.attack_damage)


func _handle_destory():
	if _entity.health <= 0:
		_spawn_exp_drop()
		queue_free()


func _spawn_exp_drop():
	var e = _exp_drop_scene.instantiate()
	e.position = position
	e.exp_point = _exp
	_drops_container.add_child(e)


func deal_damage(damage_amount: int):
	$Sprite2D.material.set_shader_parameter("is_damage_taken", true)
	_entity.health -= damage_amount
	await get_tree().create_timer(_damage_shader_delay).timeout
	$Sprite2D.material.set_shader_parameter("is_damage_taken", false)
	print(_entity.health)


func _on_attack_timer_timeout():
	_can_attack = true
