extends Node2D
class_name SpawnDropComponent


signal trigger_additional_config(drop_scene: PackedScene)

@export var _drop_scene: PackedScene: set = set_drop_scene
@export var _drop_container: Node2D: set = set_drop_container


func set_drop_scene(scene: PackedScene) -> void:
	_drop_scene = scene


func set_drop_container(node: Node2D) -> void:
	_drop_container = node


func spawn() -> void:
	var drop = _drop_scene.instantiate()
	drop.position = get_parent().position
	trigger_additional_config.emit(drop)
	_drop_container.add_child(drop)
