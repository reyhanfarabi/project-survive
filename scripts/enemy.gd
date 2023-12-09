extends Area2D


@export var _resource: Resource_Enemy: set = set_resource
@export var _target_distance_padding: int = 1
@export var _exp_drop_scene: PackedScene
@export var _destroy_comp: DestroyComponent
@export var _flicker_effect_comp: FlickerEffectComponent

@onready var _player = get_node("../../Player")
@onready var _drops_container = get_node("../../DropsContainer")

var _direction: Vector2
var _can_attack: bool = true


func set_resource(value: Resource_Enemy):
	_resource = value


func _ready():
	_start()


func _start():
	$Sprite2D.texture = _resource.sprite
	$AttackTimer.wait_time = _resource.attack_cooldown


func _process(delta):
	if not _player:
		return
	_direction = Vector2(_player.position - position).normalized()
	_handle_movement(delta)
	_handle_facing()
	_handle_attack_to_player()
	_destroy_comp.handle_destroy(_resource.health)


func _handle_movement(delta):
	if (position.distance_to(_player.position) > _target_distance_padding):
		position += _direction * _resource.move_speed * delta


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
	_player.deal_damage(_resource.attack_damage)


func _spawn_exp_drop():
	var e = _exp_drop_scene.instantiate()
	e.position = position
	e.exp_point = _resource.exp_point
	_drops_container.add_child(e)


func deal_damage(damage_amount: int):
	_flicker_effect_comp.trigger_flicker()
	_resource.health -= damage_amount


func _on_attack_timer_timeout():
	_can_attack = true


func _on_destroy_component_trigger_side_effect() -> void:
	_spawn_exp_drop()
