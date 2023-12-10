extends Area2D


@export var _resource: Resource_Enemy: set = set_resource
@export var _exp_drop_scene: PackedScene
@export var _destroy_comp: DestroyComponent
@export var _take_damage_comp: TakeDamageComponent
@export var _auto_move_comp: AutoMoveComponent

@onready var _player = get_node("../../Player")
@onready var _drops_container = get_node("../../DropsContainer")

var _can_attack: bool = true


func set_resource(value: Resource_Enemy):
	_resource = value
	_take_damage_comp.set_resource(value)


func _ready():
	_start()


func _start():
	$Sprite2D.texture = _resource.sprite
	$AttackTimer.wait_time = _resource.attack_cooldown


func _process(delta):
	if not _player:
		return
	_handle_attack_to_player()
	_destroy_comp.handle_destroy(_resource.health)
	_auto_move_comp.move_towards_position(_player.position, _resource.move_speed, delta)


func _handle_attack_to_player():
	if not _can_attack or not overlaps_body(_player):
		return
	_can_attack = false
	$AttackTimer.start()
	_player.take_damage(_resource.attack_damage)


func _spawn_exp_drop():
	var e = _exp_drop_scene.instantiate()
	e.position = position
	e.exp_point = _resource.exp_point
	_drops_container.add_child(e)


func take_damage(damage_taken: int) -> void:
	_take_damage_comp.take_damage(damage_taken)


func _on_attack_timer_timeout():
	_can_attack = true


func _on_destroy_component_trigger_side_effect() -> void:
	_spawn_exp_drop()
