extends Area2D


@export var _resource: Resource_Enemy: set = set_resource
@export var _destroy_comp: DestroyComponent
@export var _take_damage_comp: TakeDamageComponent
@export var _auto_move_comp: AutoMoveComponent
@export var _enemy_attack_comp: EnemyAttackComponent
@export var _exp_drop_comp: SpawnDropComponent

@onready var _player = get_node("../../Player")
@onready var _drops_container = get_node("../../DropsContainer")


func set_resource(value: Resource_Enemy):
	_resource = value
	_take_damage_comp.set_resource(value)
	_enemy_attack_comp.set_resource(_resource)


func _ready() -> void:
	$Sprite2D.texture = _resource.sprite
	_enemy_attack_comp.set_player_comp(_player)
	_exp_drop_comp.set_drop_container(_drops_container)


func _process(delta):
	if not _player:
		return
	_destroy_comp.handle_destroy(_resource.health)
	_auto_move_comp.move_towards_position(_player.position, _resource.move_speed, delta)


func take_damage(damage_taken: int) -> void:
	if _resource.health > 0:
		_take_damage_comp.take_damage(damage_taken)


func _on_destroy_component_trigger_side_effect() -> void:
	_exp_drop_comp.spawn()


func _on_spawn_drop_component_trigger_additional_config(drop_scene) -> void:
	drop_scene.exp_point = _resource.exp_point
