extends Node2D
class_name PlayerLookAtComponent


@export var _sprite: Sprite2D
var _look_at: Vector2: set = _set_look_at, get = get_look_at


func _set_look_at(value: Vector2):
	_look_at = value


func get_look_at() -> Vector2:
	return _look_at


func _process(_delta) -> void:
	var input = Input.get_vector("left", "right", "top", "down")
	_handle_sprite_facing(input)
	_set_look_at(_get_mouse_lookat_vector())


func _handle_sprite_facing(input: Vector2) -> void:
	if input.x > 0:
		_sprite.set_flip_h(false)
		
	elif input.x < 0:
		_sprite.set_flip_h(true)


func _get_mouse_lookat_vector() -> Vector2:
	var center_viewport_position = get_viewport_rect().size / 2
	var mouse_position = get_viewport().get_mouse_position()
	return (mouse_position - center_viewport_position).normalized()
