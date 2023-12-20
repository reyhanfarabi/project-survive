extends Node2D
class_name EnemyAttackComponent


# need to refactor _enemy_comp when class name added to enemy scene
@export var _enemy_comp: Area2D
@export var _attack_delay_timer_node: Timer

var _resource: Resource_Enemy: set = set_resource
var _player_comp: PlayerComponent: set = set_player_comp
var _can_attack: bool = true


func set_resource(res: Resource_Enemy) -> void:
	_resource = res


func set_player_comp(component: PlayerComponent) -> void:
	_player_comp = component


func _ready() -> void:
	_attack_delay_timer_node.wait_time = _resource.attack_cooldown


func _process(_delta) -> void:
	if not _enemy_comp:
		return
	if not _can_attack:
		return
	if not _enemy_comp.overlaps_body(_player_comp):
		return
	
	_can_attack = false
	_attack_delay_timer_node.start()
	_player_comp.take_damage(_resource.attack_damage)


func _on_attack_delay_timer_timeout() -> void:
	_can_attack = true
