extends CharacterBody2D
class_name PlayerComponent


@export var _resource: Resource_Player
@export var _base_resource: Resource_Player_Base
@export var _destroy_comp: DestroyComponent
@export var _take_damage_comp: TakeDamageComponent
@export var _game_over_screen_comp: GameOverScreenComponent

@onready var _game_camera_node: Camera2D = get_node("../GameCamera2D")


func _ready() -> void:
	$PlayerCamera2D.make_current()
	_resource.init(_base_resource)


func _physics_process(_delta):
	_destroy_comp.handle_destroy(_resource.health)


func take_damage(damage_taken: int) -> void:
	if _resource.health > 0:
		_take_damage_comp.take_damage(damage_taken)


func _on_collect_drops_component_trigger_drop_effect(drop) -> void:
	_resource.update_level(drop.exp_point)


func _on_destroy_component_trigger_side_effect() -> void:
	# change active camera to camera inside Game Node
	_game_camera_node.position = position
	_game_camera_node.make_current()

	_game_over_screen_comp.show()
